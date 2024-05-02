package com.example.triptable.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.example.triptable.auth.PrincipalManagerDetailService;
import com.example.triptable.auth.PrincipalManagerDetails;
import com.example.triptable.entity.Accommodation;
import com.example.triptable.entity.DeletedUser;
import com.example.triptable.entity.CourseRecommendation;
import com.example.triptable.entity.Manager;
import com.example.triptable.entity.Notice;
import com.example.triptable.entity.PayLog;
import com.example.triptable.entity.RefundStatus;
import com.example.triptable.entity.Reservation;
import com.example.triptable.entity.User;
import com.example.triptable.excel.ExcelUtil;
import com.example.triptable.repository.AccommodationRepository;
import com.example.triptable.repository.CourseRecommendationRepository;
import com.example.triptable.repository.DeletedUserRepository;
import com.example.triptable.repository.ManagerRepository;
import com.example.triptable.repository.ManagerRoleRepository;
import com.example.triptable.repository.PayLogRepository;
import com.example.triptable.repository.ReservationRepository;
import com.example.triptable.repository.TeamRepository;
import com.example.triptable.repository.UserRepository;
import com.example.triptable.service.CourseRecommendationService;
import com.example.triptable.service.ManagerService;
import com.example.triptable.service.NoticeService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.example.triptable.service.TeamService;
import com.example.triptable.service.S3Service;
import com.example.triptable.service.UserLoginService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//** 관리자 CONTROLLER **//
@Controller
public class ManagerController {

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private ManagerRepository managerRepository;

	@Autowired
	private AccommodationRepository accommodationRepository;

	@Autowired
	private PrincipalManagerDetailService principalManagerDetailService;

	@Autowired
	private ManagerService managerService;

	@Autowired
	private CourseRecommendationRepository courseRecommendationRepository;

	@Autowired
	private DeletedUserRepository deletedUserRepository;

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private UserLoginService userLoginService;

	@Autowired
	private TeamRepository teamRepository;

	@Autowired
	private ManagerRoleRepository managerRoleRepository;

	@Autowired
	private ReservationRepository reservationRepository;

	@Autowired
	private PayLogRepository payLogRepository;

	@Autowired
	private S3Service s3Service;

	@Autowired
	private TeamService teamService;

	@Autowired
	private CourseRecommendationService courseRecommendationService;

	@Autowired
	private ExcelUtil excelUtil;

	/********************************************
	 * 관리자 공지사항 매핑
	 ********************************************/
	@RequestMapping("/manager/mnotice.do")
	public String mnotice(@RequestParam(name = "title", defaultValue = "") String searchTitle,
			@RequestParam(name = "category", defaultValue = "") String category,
			@PageableDefault(page = 0, size = 5, sort = "id") Pageable pageable, HttpServletRequest request,
			Model model) {

		System.out.println("mnotice.do 호출 성공");

		// 공지사항 페이징
		Page<Notice> lists = null;

		if (category.equals("") || category.equals("전체 공지")) {
			lists = noticeService.getMnoticeListByTitle(searchTitle, pageable);
		} else {
			lists = noticeService.getMnoticeListByTitleAndCategory(searchTitle, category, pageable);
		}

		int nowPage = lists.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage - 1, lists.getTotalPages());

		model.addAttribute("lists", lists);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("nowPage", pageable.getPageNumber() + 1);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		// 공지사항 추가 시 관리자 목록 선택 가능하도록 설정
		List<Manager> managerLists = managerService.findAllManager();
		model.addAttribute("managerlists", managerLists);

		return "manager/mnotice";
	}

	/* 공지사항 수정 모달 안에 데이터를 set(json형식으로 반환하여 사용) */
	@GetMapping("/manager/mnotice_setting.do")
	public ResponseEntity<Notice> mnotice_setting(HttpServletRequest request, HttpServletResponse response,
			Model model) throws ParseException {
		int notice_id = Integer.parseInt(request.getParameter("notice_id"));

		Notice notice = managerService.setNotice(notice_id);

		if (notice != null) {

			String strFile = notice.getFile();

			JSONParser parser = new JSONParser();

			JSONArray jsonArray = (JSONArray) parser.parse(strFile);

			Iterator<JSONObject> iterator = jsonArray.iterator();

			JSONArray mFileArr = new JSONArray();
			while (iterator.hasNext()) {
				JSONObject fileInfo = iterator.next();
				String fileName = (String) fileInfo.get("fileName");
				String size = (String) fileInfo.get("size");

				String fileUrl = s3Service.getFilePath(fileName);

				JSONObject mFileInfo = new JSONObject();
				mFileInfo.put("fileName", fileName);
				mFileInfo.put("fileUrl", fileUrl);
				mFileInfo.put("size", size);

				mFileArr.add(mFileInfo);

			}

			notice.setFile(mFileArr.toJSONString());

			return ResponseEntity.ok(notice);
		} else {
			return ResponseEntity.notFound().build();
		}
	}

	/********************************************
	 * 관리자 인증 관련 매핑
	 ********************************************/

	/* 관리자가 로그인 한 후 대시보드 페이지 - 조민희 */
	@GetMapping("/manager/dashboard.do")
	public String muserinfo(HttpSession session, HttpServletRequest request) {

		session.removeAttribute("team_id");

		// 시큐리티 세션의 인증 정보를 반환해서 관리자객체에 저장한 후 세션에 관리자 정보 저장
		Authentication authentication = principalManagerDetailService.getCurrentManagerInfo();
		PrincipalManagerDetails principalManagerDetails = (PrincipalManagerDetails) authentication.getPrincipal();
		Manager manager = principalManagerDetails.getManager();
		session.setAttribute("manager", manager);

		// 관리자 로그인 기록 업데이트
		managerService.updateLastLogin(manager);

		// 시간별 로그인 현황
		JSONArray timeArray = userLoginService.showDayDashBoard("today");
		List<Integer> timeList = (List<Integer>) timeArray.get(1);
		request.setAttribute("timeList", timeList);

		// 하루 로그인 현환
		JSONObject totalObject = userLoginService.selectDayTotal("today");
		int todayTotal = (Integer) totalObject.get("loginUserNum");
		request.setAttribute("todayTotal", todayTotal);

		// 소셜로그인 경로별 가입자 수
		int kakao = userRepository.findByProvider("kakao").size();
		int google = userRepository.findByProvider("google").size();
		request.setAttribute("kakao", kakao);
		request.setAttribute("google", google);

		// 여행지역 순위
		List<Object[]> destRank = teamRepository.findRankTravelDestinations();
		request.setAttribute("destRank", destRank);

		// 추천코스 순위
		List<Object[]> courseRank = courseRecommendationRepository.findRankCourse();
		request.setAttribute("courseRank", courseRank);

		return "manager/mdashboard";
	}

	/* 관리자 회원가입 매핑, 인덱스 페이지로 리다이렉트 - 조민희 */
	@PostMapping("/manager/mjoin.do")
	public String mjoin(HttpServletRequest request, HttpSession session) {

		session.removeAttribute("team_id");

		String mgr_mail = request.getParameter("adminUsermail");

		// 암호화 하지 않은 비밀번호
		String mgr_rawPassword = request.getParameter("adminPassword");

		// 암호화 한 비밀번호
		String mgr_encPassword = bCryptPasswordEncoder.encode(mgr_rawPassword);
		String mgr_name = request.getParameter("adminName");
		String mgr_tel = request.getParameter("adminUsertel");

		Manager manager = new Manager();
		manager.setMail(mgr_mail);
		manager.setPassword(mgr_encPassword);
		manager.setManagerRole(managerRoleRepository.findById(1));
		manager.setName(mgr_name);
		manager.setTel(mgr_tel);

		managerRepository.save(manager);

		return "redirect:/manager/manager.do";
	}

	@RequestMapping("/manager/userDel.do")
	public String uselDel() {

		return "manager/muser_deleted";
	}

	@RequestMapping("/check_exist_mail.do")
	public void checkExistMail(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String mail = request.getParameter("mail");
		Manager manager = managerRepository.findByMail(mail);
		if (manager == null) {
			response.getWriter().print(0);
		} else {
			response.getWriter().print(1);
		}

	}

	/********************************************
	 * 숙소 관리 매핑
	 ********************************************/

	/* 숙소 페이지 */
	@RequestMapping("/manager/accDB.do")
	public String accommodationDB(HttpServletRequest request, Model model,
			@RequestParam(name = "address", defaultValue = "") String address,
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Sort.Direction.ASC) Pageable pageable) {
		System.out.println("accDB 호출 성공");

		Page<Accommodation> accLists = accommodationRepository.findByAddressContaining(address, pageable);
		int nowPage = accLists.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage, accLists.getTotalPages());

		model.addAttribute("nowPage", pageable.getPageNumber() + 1);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("accLists", accLists);

		return "manager/maccommodation_DB";
	}

	/* 숙소 추가 */
	@PostMapping("/manager/accDB_insert.do")
	public ModelAndView accDB_insert(HttpServletRequest request) {
		System.out.println("accDB_insert.do 호출 성공");

		ModelAndView modelAndView = new ModelAndView();

		String iname = request.getParameter("iname");
		Double ilatitude = (double) Integer.parseInt(request.getParameter("ilatitude"));
		Double ilongitude = (double) Integer.parseInt(request.getParameter("ilongitude"));
		String isummary = request.getParameter("isummary");
		String icategory = request.getParameter("icategory");
		int irooms = Integer.parseInt(request.getParameter("irooms"));
		String iaddress = request.getParameter("iaddress");
		int ifee = Integer.parseInt(request.getParameter("ifee"));

		String ilink = request.getParameter("ilink");

		String iimage = request.getParameter("iimage");

		int flag = managerService.accDBInsert(iname, ilatitude, ilongitude, isummary, icategory, irooms, iaddress, ifee,
				ilink, iimage);

		modelAndView.addObject("flag", flag);
		modelAndView.setViewName("manager/maccommodation_DB_Ok");
		return modelAndView;

	}

	/* 숙소 수정 모달 */
	@PostMapping("/manager/accDB_modal.do")
	public void accDB_modal(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int accId = Integer.parseInt(request.getParameter("accId"));

		Accommodation idLists = accommodationRepository.findById(accId);

		int id = idLists.getId();
		String name = idLists.getName();
		Double latitude = idLists.getLatitude();
		Double longitude = idLists.getLongitude();
		String summary = idLists.getSummary();
		String category = idLists.getCategory();
		int rooms = idLists.getRooms();
		String address = idLists.getAddress();
		int fee = idLists.getFee();

		// 링크에서 필요없는 부분 자르기
		String link = idLists.getUrl();

		String image = idLists.getImage();

		response.setCharacterEncoding("UTF-8");

		// JSONObject를 사용하여 JSON 문자열 생성
		JSONObject jsonObject = new JSONObject();

		jsonObject.put("id", id);
		jsonObject.put("name", name);
		jsonObject.put("latitude", latitude);
		jsonObject.put("longitude", longitude);
		jsonObject.put("summary", summary);
		jsonObject.put("category", category);
		jsonObject.put("rooms", rooms);
		jsonObject.put("address", address);
		jsonObject.put("fee", fee);
		jsonObject.put("link", link);
		jsonObject.put("image", image);

		// JSON 문자열 출력
		String result = jsonObject.toString();

		response.getWriter().write(result);

	}

	/* 숙소 수정 */
	@PostMapping("/manager/accDB_update.do")
	public ModelAndView accDB_update(HttpServletRequest request) {
		System.out.println("accDB_update.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();

		// uid 없애기
		int uid = Integer.parseInt(request.getParameter("uid"));
		String uname = request.getParameter("uname");

		Accommodation acc = accommodationRepository.getById(uid);
		Timestamp date = acc.getDate();

		Double ulatitude = Double.parseDouble(request.getParameter("ulatitude"));
		Double ulongitude = Double.parseDouble(request.getParameter("ulongitude"));
		String usummary = request.getParameter("usummary");
		String ucategory = request.getParameter("ucategory");
		int urooms = Integer.parseInt(request.getParameter("urooms"));
		String uaddress = request.getParameter("uaddress");
		int ufee = Integer.parseInt(request.getParameter("ufee"));
		String ulink = request.getParameter("ulink");
		String uimage = request.getParameter("uimage");

		int flag = managerService.accDBUpdate(uid, uname, date, ulatitude, ulongitude, usummary, ucategory, urooms,
				uaddress, ufee, ulink, uimage);

		modelAndView.addObject("flag", flag);
		modelAndView.setViewName("manager/maccommodation_DB_Ok");
		return modelAndView;

	}

	/* 숙소 삭제 */
	@PostMapping("/manager/accDB_delete.do")
	public ModelAndView accDB_delete(HttpServletRequest request) {
		System.out.println("accDB_delete.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();

		String accIdString = request.getParameter("accId");

		try {
			if (accIdString != null && !accIdString.isEmpty()) {
				int accId = Integer.parseInt(accIdString);

				accommodationRepository.deleteById(accId);
				modelAndView.setViewName("manager/maccommodation_DB_delete");
			} else {
				// accId가 null 또는 빈 문자열일 경우 처리
				modelAndView.setViewName("manager/maccommodation_DB_delete");
			}
		} catch (Exception e) {
			// 삭제 중에 예외가 발생할 경우
			e.printStackTrace(); // 에러 메시지 출력
			modelAndView.setViewName("manager/error_page"); // 에러 페이지로 리다이렉트 또는 에러 처리를 위한 뷰로 변경
		}

		return modelAndView;
	}

	/********************************************
	 * 숙소 예약 관리
	 ********************************************/

	@GetMapping("/manager/accRes.do")
	public String accommodationReservation(HttpServletRequest request, Model model,
			@RequestParam(name = "username", defaultValue = "") String username,
			@RequestParam(name = "category", defaultValue = "") String category,
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {
		System.out.println("accommodationReservation 호출 성공");

		Page<Reservation> lists = null;
		RefundStatus refundStatus = null;

		if (category.equals("전체") || category.equals("")) {
			lists = reservationRepository.findByUser_nameContaining(username, pageable);
		} else {
			if (category.equals("이용 전")) {
				refundStatus = RefundStatus.BEFORE_USE;
			} else if (category.equals("이용 후")) {
				refundStatus = RefundStatus.AFTER_USE;
			} else if (category.equals("취소 중")) {
				refundStatus = RefundStatus.CANCELING;
			} else if (category.equals("취소 됨")) {
				refundStatus = RefundStatus.CANCELED;
			}

			lists = reservationRepository.findByUser_nameContainingAndRefundStatus(username, refundStatus, pageable);

		}

		model.addAttribute("reservationData", lists);

		int nowPage = lists.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage, lists.getTotalPages());

		model.addAttribute("nowPage", pageable.getPageNumber() + 1);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("lists", lists);

		return "manager/maccommodation_res";
	}

	/********************************************
	 * 코스 추천 관리
	 ********************************************/
	@RequestMapping("/manager/recommend.do")
	public ModelAndView recommendation(HttpServletRequest request,
			@RequestParam(name = "region", defaultValue = "") String region,
			@PageableDefault(page = 0, size = 12, sort = "hit", direction = Sort.Direction.DESC) Pageable pageable) {
		System.out.println("recommend.do 호출 성공");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("manager/mrecommendation");

		Page<CourseRecommendation> courseList = courseRecommendationRepository.findByCoursedestContaining(region,
				pageable);
		if (StringUtils.isEmpty(region)) {
			courseList = courseRecommendationRepository.findAll(pageable);
		} else {
			courseList = courseRecommendationRepository.findByCoursedestContainsOrCoursenameContains(region, region,
					pageable);
		}
		int nowPage = courseList.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage, courseList.getTotalPages());

		modelAndView.addObject("nowPage", pageable.getPageNumber() + 1);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.addObject("courseList", courseList);

		// 공지사항 추가 시 관리자 목록 선택 가능하도록 설정
		List<Manager> managerLists = managerService.findAllManager();
		modelAndView.addObject("managerlist", managerLists);

		return modelAndView;
	}

	/* 코스 수정 팝업창에 띄우기 */
	@PostMapping("/manager/rec_modal.do")
	public void rec_modal(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int courseId = Integer.parseInt(request.getParameter("courseId"));

		CourseRecommendation idLists = courseRecommendationRepository.findById(courseId);

		int id = idLists.getId();
		String name = idLists.getCoursename();
		String dest = idLists.getCoursedest();
		String summary = idLists.getCoursesum() == null ? "" : idLists.getCoursesum().replaceAll("</br>", "");
		// S3로 받아오는 데이터와 데이터베이스 데이터 구분
		String image = null;
		if (idLists.getCourseimage() != null && s3Service.getFilePath(idLists.getCourseimage()) != null) {
			image = idLists.getCourseimage().contains("http") == true ? idLists.getCourseimage()
					: s3Service.getFilePath(idLists.getCourseimage());
		}
		String dis = idLists.getCoursedis();
		String dur = idLists.getCoursedur();
		String manager = idLists.getCoursemanager();
		String detail = idLists.getCoursedetail();
		int hit = idLists.getHit();

		// Timestamp를 String으로 변환
		Timestamp date = idLists.getDate();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = dateFormat.format(date);

		response.setCharacterEncoding("UTF-8");

		// JSONObject를 사용하여 JSON 문자열 생성
		JSONObject jsonObject = new JSONObject();

		jsonObject.put("id", id);
		jsonObject.put("name", name);
		jsonObject.put("dest", dest);
		jsonObject.put("summary", summary);
		jsonObject.put("image", image);
		jsonObject.put("dis", dis);
		jsonObject.put("dur", dur);
		jsonObject.put("manager", manager);
		jsonObject.put("detail", detail);
		jsonObject.put("hit", hit);
		jsonObject.put("date", dateString);

		// JSON 문자열 출력
		String result = jsonObject.toString();

		response.getWriter().write(result);

	}

	/* 코스 승인 */
	@PostMapping("/manager/course_check.do")
	public void courseCheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int courseId = Integer.parseInt(request.getParameter("courseId"));

		int flag = courseRecommendationService.courseCheck(courseId);

		if (flag == 1) {
			response.getWriter().write("1");
		}
	}

	/* 코스 승인해제 */
	@PostMapping("/manager/course_uncheck.do")
	public void courseUncheck(HttpServletRequest request, HttpServletResponse response) {
		int courseId = Integer.parseInt(request.getParameter("courseId"));

		courseRecommendationService.courseUncheck(courseId);
	}

	/****************************** user Info **************************/
	@RequestMapping("/manager/userInfo.do")
	public String userInfo(HttpServletRequest request, Model model,
			@RequestParam(name = "user", defaultValue = "") String user,
			@RequestParam(name = "provider", defaultValue = "") String provider,
			@PageableDefault(page = 0, size = 15, sort = "id", direction = Sort.Direction.ASC) Pageable pageable) {
		System.out.println("userInfo 호출 성공");

		Page<User> lists = null;

		if (provider.equals("all") || provider.equals("")) {
			lists = userRepository.findByNameContaining(user, pageable);
		} else {
			lists = userRepository.findByNameContainingAndProvider(user, provider, pageable);
		}

		int nowPage = lists.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage, lists.getTotalPages());

		model.addAttribute("nowPage", pageable.getPageNumber() + 1);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("lists", lists);

		return "manager/muser_info";
	}

	@RequestMapping("/manager/duserInfo.do")
	public String duserInfo(HttpServletRequest request, Model model,
			@RequestParam(name = "user", defaultValue = "") String user,
			@RequestParam(name = "reason", defaultValue = "") String reason,
			@PageableDefault(page = 0, size = 15, sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {

		Page<DeletedUser> dlists = null;

		if (reason.equals("all") || reason.equals("")) {
			dlists = deletedUserRepository.findByNameContaining(user, pageable);
		} else {

			dlists = deletedUserRepository.findByNameContainingAndReasonContaining(user, reason, pageable);
			List<DeletedUser> dlist = dlists.getContent();

		}

		int nowPage = dlists.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage, dlists.getTotalPages());

		model.addAttribute("nowPage", pageable.getPageNumber() + 1);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("lists", dlists);

		return "manager/muser_deleted";
	}

	/****************************** manager Info **************************/
	/* 관리자 기존 list */
	@RequestMapping("/manager/manager.do")
	public String managerList(@RequestParam(name = "mname", defaultValue = "") String name,
			@RequestParam(name = "manager", defaultValue = "") String managerCategory,
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Sort.Direction.ASC) Pageable pageable,
			HttpServletRequest request,
			Model model) {
		System.out.println("managerInfo 호출 성공");

		Page<Manager> mlists = null;

		if (managerCategory.equals("전체") || managerCategory.equals("")) {
			mlists = managerRepository.findByNameContaining(name, pageable);
		} else {
			if (managerCategory.equals("비승인")) {
				managerCategory = "ROLE_UNAPPROVED";
			} else if (managerCategory.equals("관리자")) {
				managerCategory = "ROLE_SUPER";
			} else if (managerCategory.equals("운영자")) {
				managerCategory = "ROLE_OPERATOR";
			}
			mlists = managerRepository.findByNameContainingAndManagerRole_rolename(name, managerCategory, pageable);

		}

		int nowPage = mlists.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage - 1, mlists.getTotalPages());

		model.addAttribute("nowPage", pageable.getPageNumber() + 1);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		model.addAttribute("lists", mlists);

		return "manager/mmanager_list";
	}

	/* 관리자 권한 승인 */
	@PostMapping("/manager/manager_approve.do")
	public void managerApprove(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("manager_approve.do 호출");

		String selectedApprove = request.getParameter("selectedApprove");
		int memberId = Integer.parseInt(request.getParameter("memberId"));

		int iselectedApprove = Integer.parseInt(selectedApprove.substring(0, 1));

		int flag = managerService.managerApprove(memberId, iselectedApprove);

		if (flag == 0) {
			try {
				response.getWriter().print(flag);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	/* 관리자 권한 승인 list 삭제 */
	@PostMapping("/manager/manager_dapprove.do")
	public void managerDapprove(HttpServletRequest request, HttpServletResponse response)
			throws JsonMappingException, JsonProcessingException {
		System.out.println("manager_dapprove.do 호출");

		String memberIdArr = request.getParameter("memberIdArr");

		// Jackson ObjectMapper를 생성
		ObjectMapper objectMapper = new ObjectMapper();

		// JSON 배열을 int 배열로 변환
		int[] memberIds = objectMapper.readValue(memberIdArr, int[].class);

		// 숫자 출력
		for (int memberId : memberIds) {
			managerRepository.deleteById(memberId);

		}

	}

	/**** 소라 ****/
	@RequestMapping("/manager/fileUpload.do")
	public String fileUpload(@RequestParam(name = "searchName", defaultValue = "") String name,
			HttpServletRequest request,
			Model model) {
		System.out.println("manager_agree 호출 성공");

		return "manager/fileUpload";
	}

	/******************************
	 * 대시보드 AJAX
	 * 
	 * @throws IOException
	 **************************/
	@PostMapping("/manager/select_day_time.do")
	public void selectDayTime(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String day = request.getParameter("day");

		JSONArray timeArray = userLoginService.showDayDashBoard(day);

		response.getWriter().write(timeArray.toJSONString());

	}

	@PostMapping("/manager/select_day_total.do")
	public void selectDayTotal(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String day = request.getParameter("day");

		JSONObject totalObject = userLoginService.selectDayTotal(day);

		response.getWriter().write(totalObject.toJSONString());

	}

	@PostMapping("/manager/check_manager_role.do")
	public void checkManagerRole(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {

		Manager manager = (Manager) session.getAttribute("manager");

		manager = managerRepository.findById(manager.getId());

		if (manager.getManagerRole().getRolename().equals("ROLE_SUPER")) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	/****************************** 대시보드 엑셀 다운로드 **************************/

	// 로그인 현황 엑셀 다운로드
	@PostMapping("/manager/loginExcelDownload.do")
	public void loginExcelDownload(HttpServletRequest request, HttpServletResponse response)
			throws InvalidFormatException {

		// 일자 정보를 받아옴
		String day = request.getParameter("day");

		// 일자에 해당하는 정보를 엑셀형태로 담은 리스트
		List<Map<String, String>> userLoginList = userLoginService.loginExcelDownload(day);

		// 엑셀에서 값을 받기위해 userLoginList라는 이름으로 리스트를 저장
		Map<String, Object> beans = new HashMap<String, Object>();
		beans.put("userLoginList", userLoginList);

		excelUtil.download(request, response, beans, "user_login", "userlogin.xlsx");

	}

	// 많이 가는 여행지역 순위 엑셀 다운로드
	@PostMapping("/manager/DestExcelDownload.do")
	public void DestExcelDownload(HttpServletRequest request, HttpServletResponse response)
			throws InvalidFormatException {

		// 여행지역 순위 정보를 엑셀형태로 담은 리스트
		List<Map<String, String>> destList = teamService.DestExcelDownload();

		// 엑셀에서 값을 받기위해 destList라는 이름으로 리스트를 저장
		Map<String, Object> beans = new HashMap<String, Object>();
		beans.put("destList", destList);

		excelUtil.download(request, response, beans, "dest_list", "dest.xlsx");

	}

	// 추천 코스 조회수 랭킹 엑셀 다운로드
	@PostMapping("/manager/courseExcelDownload.do")
	public void courseExcelDownload(HttpServletRequest request, HttpServletResponse response)
			throws InvalidFormatException {

		// 추천코스 조회수 순위 정보를 엑셀형태로 담은 리스트
		List<Map<String, String>> courseList = courseRecommendationService.courseExcelDownload();

		// 엑셀에서 값을 받기위해 courseList라는 이름으로 리스트를 저장
		Map<String, Object> beans = new HashMap<String, Object>();
		beans.put("courseList", courseList);

		excelUtil.download(request, response, beans, "course_list", "course.xlsx");

	}

	/********************************************
	 * 메인페이지 관리
	 ********************************************/
	/** footer-link 관리 **/
	@RequestMapping("/manager/footer_link.do")
	public ModelAndView mainpage_footer_link(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("footer_link() 호출성공");
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("manager/footer_link");
		return modelAndView;

	}

	@PostMapping("/manager/notice_check.do")
	public void noticeCheck(HttpServletRequest request, HttpServletResponse response) {

		int noticeId = Integer.parseInt(request.getParameter("noticeId"));

		noticeService.noticeCheck(noticeId);

	}

	@PostMapping("/manager/notice_uncheck.do")
	public void noticeUncheck(HttpServletRequest request, HttpServletResponse response) {

		int noticeId = Integer.parseInt(request.getParameter("noticeId"));

		noticeService.noticeUncheck(noticeId);

	}

	/********************************************
	 * 결제로그 관리
	 ********************************************/
	/* 로그 페이지 */
	@RequestMapping("/manager/payLog.do")
	public String payLog(HttpServletRequest request, Model model,
			@RequestParam(name = "logStarter", defaultValue = "") String logStarter,
			@PageableDefault(page = 0, size = 20, sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {
		System.out.println("payLog 호출 성공");
		//결제 승인</option><option>취소 요청</option><option>취소 승인
		Page<PayLog> logData = null;
		String logOption = null;
		if (logStarter.equals("전체") || logStarter.equals("")) {
			logData = payLogRepository.findAll(pageable);			
		} else {
			if (logStarter.equals("결제 승인")) {
				logOption = "kakaoPayApproval : ";
			} else if (logStarter.equals("취소 요청")) {
				logOption = "clientRequestRefund : ";
			} else if (logStarter.equals("취소 승인")) {
				logOption = "kakaoPayCanceled : ";
			} 

			logData = payLogRepository.findByLogDataContaining(logOption, pageable);

		}
		int nowPage = logData.getPageable().getPageNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage - 1, logData.getTotalPages());

		model.addAttribute("logData", logData);
		model.addAttribute("nowPage", pageable.getPageNumber() + 1);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		return "manager/mpaylog";
	}

}