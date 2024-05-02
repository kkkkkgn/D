package com.example.triptable.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.triptable.auth.PrincipalOauth2UserService;
import com.example.triptable.auth.PrincipalUserDetails;
import com.example.triptable.entity.CourseRecommendation;
import com.example.triptable.entity.Notice;
import com.example.triptable.entity.Region;
import com.example.triptable.entity.User;
import com.example.triptable.repository.CourseRecommendationRepository;
import com.example.triptable.repository.NoticeRepository;
import com.example.triptable.repository.RegionRepository;
import com.example.triptable.repository.UserRepository;
import com.example.triptable.service.CalendarUtil;
import com.example.triptable.service.NoticeService;
import com.example.triptable.service.S3Service;
import com.example.triptable.service.TeamService;
import com.example.triptable.service.UserService;

//** 회원 CONTROLLER **//

@Controller
public class UserController {

	@Autowired
	BCryptPasswordEncoder bcripBCryptPasswordEncoder;

	@Autowired
	private PrincipalOauth2UserService principalOauth2UserService;

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private RegionRepository regionRepository;

	@Autowired
	private CourseRecommendationRepository courseRecommendationRepository;

	@Autowired
	private TeamService teamService;

	@Autowired
	private UserService userService;

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private S3Service s3Service;

	@Autowired
	private NoticeRepository noticeRepository;

	/********************************************
	 * INDEX
	 * 
	 * @throws ParseException
	 ********************************************/

	@GetMapping({ "/", "/index.do" })
	public ModelAndView index(HttpSession session, HttpServletRequest request,
			@RequestParam(name = "year", defaultValue = "0") int year,
			@RequestParam(name = "month", defaultValue = "0") int month) throws ParseException {

		session.removeAttribute("team_id");

		Notice popUpNotice = noticeService.getPopUpNotice();

		List<Notice> urgentNoticeList = noticeService.getUrgentNotice();

		if (year == 0 || month < 1 || month > 12) {
			YearMonth currentMonth = YearMonth.now();
			year = currentMonth.getYear();
			month = currentMonth.getMonthValue();
		}
		// 이번 달의 HTML 생성
		String currentMonthHtml = CalendarUtil.generateCalendarHtml(year, month);
		// 다음 달의 HTML 생성
		YearMonth nextMonth = YearMonth.of(year, month).plusMonths(1);
		String nextMonthHtml = CalendarUtil.generateCalendarHtml(nextMonth.getYear(), nextMonth.getMonthValue());

		ModelAndView modelAndView = new ModelAndView();

		

		// 메인페이지에 지도 내용 띄우기
		List<Region> region = regionRepository.findAll();
		request.setAttribute("region", region);

		// SecurityContextHolder에서 인가된 사용자 정보를 가져와서 Authentication 객체에 저장
		Authentication authentication = principalOauth2UserService.getCurrentUserInfo();

		// 정보가 null 이거나 anonymousUser이면 인가받지 못하거나 로그인 실패 -> index 페이지로 넘김
		if (authentication == null || authentication.getPrincipal().equals("anonymousUser")) {
			modelAndView.setViewName("index");
			// 메인페이지 코스 추천
			List<CourseRecommendation> courseList = courseRecommendationRepository.findOrderByHit();
			modelAndView.addObject("courseList", courseList);

			Map<String, Integer> destNum = teamService.destNum();
			modelAndView.addObject("destNum", destNum);

			modelAndView.addObject("popUpNotice", popUpNotice);
			modelAndView.addObject("urgentNoticeList", urgentNoticeList);
			
			modelAndView.addObject("currentMonthHtml", currentMonthHtml);
			modelAndView.addObject("nextMonthHtml", nextMonthHtml);
			// 연도와 월을 Model에 추가
			modelAndView.addObject("selectedYear", year);
			modelAndView.addObject("selectedMonth", month);

			return modelAndView;
			// 로그인 성공함
		} else {

			// authentication의 사용자 정보를 user 객체로 저장
			PrincipalUserDetails principalDetails = (PrincipalUserDetails) authentication.getPrincipal();
			User user = principalDetails.getUser();

			// 사용하기 쉽게 세션에 user 저장
			session.setAttribute("user", user);

			// 초대받은 URL을 세션에 저장.
			String randomUrl = (String) session.getAttribute("randomUrl");

			if (randomUrl == null) {
				// 회원이 비밀번호 설정을 안했다면 회원가입부터 하게 함
				if (user.getPassword().equals("기본비밀번호")) {
					modelAndView.setViewName("user/agree");

					// 회원가입을 통해 비밀번호가 암호화되어 있다면 user/main 페이지로 넘김
				} else {
					
					modelAndView.addObject("currentMonthHtml", currentMonthHtml);
					modelAndView.addObject("nextMonthHtml", nextMonthHtml);
					// 연도와 월을 Model에 추가
					modelAndView.addObject("selectedYear", year);
					modelAndView.addObject("selectedMonth", month);

					// 메인페이지 코스 추천
					List<List<String>> activeTeamList = teamService.activeTeamDay(session, user);
					List<CourseRecommendation> courseList = courseRecommendationRepository.findOrderByHit();
					modelAndView.addObject("courseList", courseList);

					Map<String, Integer> destNum = teamService.destNum();
					modelAndView.addObject("destNum", destNum);
					if (activeTeamList != null) {
						modelAndView.addObject("activeTeamList", activeTeamList.toString());
					}

					modelAndView.addObject("urgentNoticeList", urgentNoticeList);

					modelAndView.setViewName("index");

					modelAndView.addObject("popUpNotice", popUpNotice);

				}

			} else if (randomUrl != null) {
				// 그룹 초대 메서드
				// 회원이 비밀번호 설정을 안했다면 회원가입부터 하게 함
				if (user.getPassword().equals("기본비밀번호")) {
					modelAndView.setViewName("user/agree");

					// 회원가입을 통해 비밀번호가 암호화되어 있다면 user/main 페이지로 넘김
				} else {
					// 그룹 가입 메서드 추가
					modelAndView.setViewName("redirect:/user/trip_plan.do");
				}
			}

			return modelAndView;
		}
	}

	/********************************************
	 * 회원 인증 관련 매핑
	 ********************************************/

	/* 회원 / 매니저 로그인 폼 */
	@GetMapping("/loginForm.do")
	public String loginForm(HttpServletRequest request) {
		String exception = request.getParameter("error");

		if (exception == null) {
			return "loginForm";
		} else if (exception.equals("Invalid username or password")) {
			return "invalid_manager";

		} else if (exception.equals("accessDenied")) {

			return "access_denied_manager";
		} else {
			return "loginForm";
		}
	}

	/* 회원이 비밀번호 설정을 안했을 때 회원가입하는 페이지 */
	@GetMapping("/user/joinForm.do")
	public String joinForm() {

		return "user/joinForm";
	}

	// URL 초대받아 들어오게되는 로그인 form
	@GetMapping("/joinGroupform.do/{randomUrl}")
	public ModelAndView joinGroupform(@PathVariable("randomUrl") String randomUrl, HttpSession session) {
		System.out.println("joinGroupform.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();

		session.setAttribute("randomUrl", randomUrl);
		modelAndView.setViewName("loginForm");
		return modelAndView;
	}

	/*
	 * joinForm에서 확인 버튼을 눌렀을때 이동하는 페이지 / 비밀번호 암호화를 진행하여 DB에 회원정보를 업데이트 / index 페이지로
	 * redirect 함
	 */
	@PostMapping("/user/join.do")
	public String join(HttpServletRequest request, HttpSession session) {
		User user = (User) session.getAttribute("user");

		String rawPassword = request.getParameter("password");

		// Bcrypt암호화
		String encPassword = bcripBCryptPasswordEncoder.encode(rawPassword);

		user.setPassword(encPassword);

		userRepository.save(user);

		session.setAttribute("user", user);

		// 가입완료페이지로 redirect시킴
		return "redirect:/user/joinDone.do";
	}

	/* 가입완료시 표시하는 페이지 */
	@GetMapping("/user/joinDone.do")
	public ModelAndView joindone(HttpServletRequest request, HttpSession session) {
		System.out.println("joindone.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/join_done");

		return modelAndView;
	}

	/* 회원 탈퇴 처리 페이지 */
	@PostMapping("/user_delete_ok.do")
	public ModelAndView user_delete_ok(HttpServletRequest request, HttpSession session) {
		System.out.println("user_delete_ok.do 호출 성공");
		User user = (User) session.getAttribute("user");

		// 탈퇴 이유 배열로 가져옴
		String[] reasons = request.getParameterValues("gridRadios");
		String reason = "";
		for (int i = 0; i < reasons.length; i++) {
			reason += reasons[i];
		}

		// System.out.println(reason);
		// UserService userService = new UserService();
		// System.out.println("deletedUserRepository : " + deletedUserRepository);
		int flag = userService.deleteUser(user, reason);
		// userRepository.deleteById(user.getId());
		if (flag == 0) {
			session.invalidate();
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("flag", flag);
		modelAndView.setViewName("user_delete_ok");
		return modelAndView;

	}

	/* 공지사항 페이지 - 손수빈 */
	@GetMapping("/notice.do")
	public ModelAndView notice(@RequestParam(name = "title", defaultValue = "") String searchTitle,
			@RequestParam(name = "category", defaultValue = "") String category,
			// 페이징
			@PageableDefault(page = 0, size = 5, sort = "id") Pageable pageable, HttpServletRequest request) {

		System.out.println("notice.do 호출 성공");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice");

		// 1. Notice 목록을 가져옴
		Page<Notice> list = null;

		if (category.equals("전체 공지") || category.equals("") ) {
			list = noticeService.getNoticeListByTitle(searchTitle, pageable);
		} else  {
			list = noticeService.getNoticeListByTitleAndCategory(searchTitle, category, pageable);
		}

		// 4. 페이징 적용
		int nowPage = list.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage - 1, list.getTotalPages());


		// 6. ModelAndView에 필요한 정보 추가
		modelAndView.addObject("lists", list);
		modelAndView.addObject("searchTitle", searchTitle);
		modelAndView.addObject("nowPage", pageable.getPageNumber() + 1);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);

		return modelAndView;
	}

	@GetMapping("/notice_view.do")
	public ModelAndView noticeView(@RequestParam("noticenum") int noticenum, HttpServletRequest request)
			throws ParseException {
		System.out.println("notice_view.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("notice_view");

		// view로 들어올 때 조회수 + 1 해줌
		noticeService.incrementHitForNotice(noticenum);

		Notice notice = null;

		LocalDate tommorow = LocalDate.now().plusDays(1);
		LocalDate yesterday = LocalDate.now().minusDays(1);

		List<Notice> totalNotice = noticeRepository
				.findByNoticestartBeforeAndNoticeendAfterAndState(tommorow.toString(), yesterday.toString(), true);

		List<Integer> noticeIdList = new ArrayList<>();

		for (Notice notices : totalNotice) {

			noticeIdList.add(notices.getId());
		}
		//System.out.println(noticeIdList);

		for (int i = 0; i < noticeIdList.size(); i++) {
			int currentId = noticeIdList.get(i);

			if (currentId == noticenum) {
				// 공지사항 Id를 통해 세부 내용을 가져올 수 있음
				notice = noticeService.findNoticeById(noticenum);
				// System.out.println("현재 id: "+ currentId + i);
				// 이전 공지사항 Id가 있는지 확인하고 true/false 값을 넘겨 버튼이 보이거나 보이지 않도록 함
				boolean hasPreviousNotice = noticeService.checkForPreviousNotice(currentId, noticeIdList);
				modelAndView.addObject("hasPreviousNotice", hasPreviousNotice);
				modelAndView.addObject("preIndex", hasPreviousNotice ? noticeIdList.get(i - 1) : null);

				// 다음 공지사항 Id가 있는지 확인하고 true/false 값을 넘겨 버튼이 보이거나 보이지 않도록 함
				boolean hasNextNotice = noticeService.checkForNextNotice(currentId, noticeIdList);
				modelAndView.addObject("hasNextNotice", hasNextNotice);
				modelAndView.addObject("nextIndex", hasNextNotice ? noticeIdList.get(i + 1) : null);
			}
		}
		if (notice != null) {
			String strFile = notice.getFile();
			try {
				JSONParser parser = new JSONParser();
				JSONArray jsonArray = (JSONArray) parser.parse(strFile);

				JSONArray mFileArr = new JSONArray();
				for (Object fileObj : jsonArray) {
					if (fileObj instanceof JSONObject) {
						JSONObject fileInfo = (JSONObject) fileObj;
						String fileName = (String) fileInfo.get("fileName");
						String size = (String) fileInfo.get("size");

						String fileUrl = s3Service.getFilePath(fileName);

						JSONObject mFileInfo = new JSONObject();
						mFileInfo.put("fileName", fileName);
						mFileInfo.put("fileUrl", fileUrl);
						mFileInfo.put("size", size);

						mFileArr.add(mFileInfo);
					}
				}

				// System.out.println("file 수정 모달 : " + mFileArr);
				notice.setFile(mFileArr.toJSONString());
			} catch (ParseException e) {
				e.printStackTrace();
				// 예외 처리를 여기에 추가하세요.
			}
		}
		request.setAttribute("notice", notice);

		return modelAndView;
	}

	/* 구동현의 실험실 페이지 - 구동현꺼 건들지마 */
	@GetMapping("/icon.do")
	public ModelAndView bootstrap_icosn(HttpServletRequest request, HttpSession session) {
		System.out.println("bootstrap_icon() 호출성공");
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("bootstrap-icon");
		return modelAndView;
	}

	/* 구동현의 실험실 페이지 - 구동현꺼 건들지마 */
	@GetMapping("/test.do")
	public ModelAndView testmap(HttpServletRequest request, HttpSession session) {
		System.out.println("testmap 호출성공");
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("user/testmap");
		return modelAndView;
	}

	/* 구동현의 실험실 페이지 - 구동현꺼 건들지마 */
	@GetMapping("/test2.do")
	public ModelAndView testmap2(HttpServletRequest request, HttpSession session) {
		System.out.println("testmap 호출성공");
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("user/testmap2");
		return modelAndView;
	}

	/* 구동현의 실험실 페이지 - 구동현꺼 건들지마 */
	@GetMapping("/test3.do")
	public ModelAndView test3(HttpServletRequest request, HttpSession session) {
		System.out.println("test3 호출성공");
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("user/testmapWrite");
		return modelAndView;
	}

	/* 조민희의 실험실 페이지 - 조민희꺼 건들지마 */
	@GetMapping("/mini.do")
	public ModelAndView mini(HttpServletRequest request, HttpSession session) {
		System.out.println("test3 호출성공");
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("mini");
		List<CourseRecommendation> courseList = courseRecommendationRepository.findOrderByHit();
		modelAndView.addObject("courseList", courseList);

		return modelAndView;
	}

}