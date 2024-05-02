 package com.example.triptable.controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.util.IOUtils;
import com.example.triptable.entity.CourseRecommendation;
import com.example.triptable.entity.Finance;
import com.example.triptable.entity.Preparation;
import com.example.triptable.entity.Spot;
import com.example.triptable.entity.Team;
import com.example.triptable.entity.User;
import com.example.triptable.repository.CourseRecommendationRepository;
import com.example.triptable.repository.FinanceRepository;
import com.example.triptable.repository.PreparationRepository;
import com.example.triptable.repository.SpotRepository;
import com.example.triptable.repository.TeamRepository;
import com.example.triptable.repository.UserRepository;
import com.example.triptable.service.S3Service;
import com.example.triptable.service.TeamService;
import com.example.triptable.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//** 마이페이지 CONTROLLER **//

@Controller
public class MypageController {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private TeamRepository teamRepository;
	
	@Autowired
	private TeamService teamService;
	
	@Autowired
	private FinanceRepository financeRepository;
	
	@Autowired
	private PreparationRepository preparationRepository;
	
	@Autowired
	private SpotRepository spotRepository;
	
	@Autowired
	private AmazonS3Client amazonS3Client;
	
	@Autowired
	private S3Service s3Service;

	// 저장할 bucket의 이름을 가져옴 (application.properties에 있음)
	@Value("${cloud.aws.s3.bucket}")
	private String bucket;
	
	/* 마이페이지 */
	@GetMapping("/user/mypage.do")
	public ModelAndView mypage(HttpServletRequest request, HttpSession session) {
		System.out.println("mypage.do 호출 성공");	

		session.removeAttribute("team_id");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/mypage");
		return modelAndView;
	}

	/* 프로필 설정 페이지 - 박수진? */
	@GetMapping("/user/profile_set.do")
	public ModelAndView profile_set(HttpServletRequest request, HttpSession session) {
		System.out.println("profile_set.do 호출 성공");

		session.removeAttribute("team_id");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/profile_set");
		return modelAndView;
	}

	/* 정보 수정 Ok page - 박수진? */
	@PostMapping("/user/profile_set_ok.do")
	public ModelAndView profile_set_Ok(HttpServletRequest request, HttpSession session) {
		System.out.println("profile_set_Ok.do 호출 성공");

		session.removeAttribute("team_id");
		

		ModelAndView modelAndView = new ModelAndView();

		// 마이페이지 회원 정보 받아오는 request
		String nickname = (String) request.getParameter("nickname");
		String password = (String) request.getParameter("password");
		String icon = (String) request.getParameter("selecticon");

		User user = (User) session.getAttribute("user");

		// 비밀번호 확인하는 알고리즘
		UserService userService = new UserService();

		int flag = userService.updateUser(user, password);

		if (flag == 0) {
			user.setNickname(nickname);
			user.setNickname(nickname);
			user.setIcon(icon);
			userRepository.save(user);
		}

		session.setAttribute("flag", flag);

		modelAndView.setViewName("user/profile_set_ok");
		return modelAndView;
	}

	/* 비밀번호 변경 Ok page - 박수진 */
	@PostMapping("/user/change_password_ok.do")
	public ModelAndView change_passowrd_Ok(HttpServletRequest request, HttpSession session) {
		System.out.println("change_password_Ok.do 호출 성공");

		session.removeAttribute("team_id");
		

		ModelAndView modelAndView = new ModelAndView();

		// 기존 비밀번호 확인
		String originPassword = request.getParameter("originpassword");
		// 변경할 비밀번호
		String changePassword = request.getParameter("changepassword");
		// 변경할 비밀번호 확인
		String checkChangePassword = request.getParameter("checkchangepassword");
		// 유저 정보
		User user = (User) session.getAttribute("user");

		UserService userService = new UserService();

		int flag = userService.changePassword(user, originPassword, changePassword, checkChangePassword);

		// 비밀번호 변경
		if (flag == 0) {
			// 변경할 비밀번호 암호화 및 세션에 저장
			String rawPassword = bCryptPasswordEncoder.encode(changePassword);
			user.setPassword(rawPassword);
			userRepository.save(user);
		}
		session.setAttribute("flag", flag);
		session.setAttribute("user", user);
		modelAndView.setViewName("user/change_password_ok");
		return modelAndView;
	}
	
	/* 타임머신 페이지 - 손수빈 */
	   @GetMapping("/user/time_machine.do")
	   public ModelAndView mytrip(HttpServletRequest request, HttpSession session) {
	      System.out.println("time_machine.do 호출 성공");

	      session.removeAttribute("team_id");
	      
	      ModelAndView modelAndView = new ModelAndView();
	      User user = (User) session.getAttribute("user");

		// 진행중인 여행 계획과 지난여행계획이 담긴 Map을 불러옴
		Map<String, Object> allTeamList= teamService.loadPlanByUserId(session, user);
		
		if(allTeamList != null && !allTeamList.isEmpty()) {
			// 진행중인 여행계획 리스트
			List<Team> activeTeamList = (List<Team>)allTeamList.get("activeTeamList");
			// 지난 여행계획 리스트
			List<Team> inActiveTeamList = (List<Team>)allTeamList.get("inActiveTeamList");
	
			// null이 아닌 값만 request.setAttribute로 저장해야함
			// 아니면 타임머신 들어가서 NullPointerException 남
			if(allTeamList.get("activeTeamList") == null && allTeamList.get("inActiveTeamList") == null) {
	
			} else if(allTeamList.get("activeTeamList") != null && allTeamList.get("inActiveTeamList") == null) {
				request.setAttribute("activeTeamList", activeTeamList);
				
			} else if(allTeamList.get("activeTeamList") == null && allTeamList.get("inActiveTeamList") != null) {
				request.setAttribute("inActiveTeamList", inActiveTeamList);
	
			} else {
				request.setAttribute("activeTeamList", activeTeamList);
				request.setAttribute("inActiveTeamList", inActiveTeamList);
	
			}
		}	
		modelAndView.setViewName("user/time_machine");
		return modelAndView;
	}
	
	/* 즐겨찾기 페이지 */
	@GetMapping("/user/favorite.do")
	public ModelAndView favorite(@RequestParam(name = "keyword", defaultValue = "") String keyword,
			@PageableDefault(page = 0, size = 6) Pageable pageable, 
			HttpServletRequest request, HttpSession session) {
		System.out.println("favorite.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();
		User user = (User) session.getAttribute("user");

		Page<CourseRecommendation> lists = userService.loadFavorite(user, keyword, pageable);

		int nowPage = lists.getNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage - 1, lists.getTotalPages());
		
		modelAndView.addObject("lists", lists);
		modelAndView.addObject("nowPage", nowPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		
		modelAndView.addObject("keyword", keyword);
		
		modelAndView.setViewName("user/favorite_course");
		return modelAndView;
	}

	/* 지난 타임머신 */
	@PostMapping("/user/pretime_machine.do")
	public ModelAndView pretimeMachine(HttpServletRequest request, HttpSession session) throws ParseException {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/pretime_machine");
		
		User user = (User) session.getAttribute("user");
		
		String strTeam_id = request.getParameter("teamId");
		
		if(strTeam_id != null) {
			int team_id = Integer.parseInt(strTeam_id);
			
			Team team = teamRepository.findById(team_id);
			
			String strEnd = team.getTravleend();
			String strStart = team.getTravlestart();
			
			LocalDate endDay = LocalDate.parse(strEnd);
			LocalDate startDay = LocalDate.parse(strStart);
			
			// 두 날짜 간의 차이 계산
	        int days = (int) (ChronoUnit.DAYS.between(startDay, endDay) + 1);

			JSONArray spotArr = new JSONArray();
			JSONArray financeArr = new JSONArray();
			
			// 일차와 각 데이터들 json으로 저장
			for(int day=1 ; day<=days ; day++) {

				List<Spot> spotLists = spotRepository.findByTeamAndDay(team_id, day);
				List<Finance> financeLists = financeRepository.findByTeamAndDay(team_id, day);

				JSONObject spotObj = new JSONObject();
				JSONObject financeObj = new JSONObject();

				// 여행지
				// 해당 일차에 데이터가 존재할 때
				if(!spotLists.isEmpty() && spotLists.get(0).getDay() == day) {
					spotObj.put("day", day);
					spotObj.put("spot", spotLists);		
				// 해당 일차에 데이터가 존재하지 않을 때 빈 배열이 들어감
				}else if(days != day){
					spotObj.put("day", day);
					spotObj.put("spot", new ArrayList<>());
					
				}
				spotArr.add(spotObj);
				
				// 가계부 (여행지와 같음)
				if(!financeLists.isEmpty() && financeLists.get(0).getDay() == day) {
					financeObj.put("day", day);
					financeObj.put("finance", financeLists);
		
				}else{
					financeObj.put("day", day);
					financeObj.put("finance", new ArrayList<>());
				}
				financeArr.add(financeObj);
				
			}
			
			// 메모장
			String strGroupdata = user.getGroupdata();
			JSONArray groupData = null;
			
			JSONParser parser = new JSONParser();
			
			groupData = (JSONArray)parser.parse(strGroupdata);
			
			String pretimeContent = null;
			
			// 그룹데이터에서 현재 팀 아이디에 해당하는 content 가져오기 
			for(int i=0 ; i<groupData.size() ; i++) {
				JSONObject groupObj = (JSONObject) groupData.get(i);

				Long teamId = (Long) groupObj.get("team_id");
				int id = teamId.intValue();
				
				// 현재 팀아이디의 content 내용 가져옴
				if(id == team_id) {
					pretimeContent = (String) groupObj.get("content");
				}
			}
			// 준비물리스트 바로 가져옴
			List<Preparation> preparationLists = preparationRepository.findByTeam(team);

			modelAndView.addObject("financeArr", financeArr);
			modelAndView.addObject("preparationLists", preparationLists);
			modelAndView.addObject("spotArr", spotArr);
			modelAndView.addObject("pretimeContent", pretimeContent);
			modelAndView.addObject("team", team);
		}
		return modelAndView;
	}
	
	/* 지난 타임머신 메모장 */
	@PostMapping("/user/pretime_content.do")
	@ResponseBody
	public void pretimeText(HttpServletRequest request, HttpSession session) throws ParseException {
	
		String content = request.getParameter("content");
		
		String strTeam_id = request.getParameter("teamId");
		User user = (User) session.getAttribute("user");

		String strGroupData = user.getGroupdata();  
		JSONArray groupData = null;
		JSONParser parser = new JSONParser();
		
		groupData = (JSONArray)parser.parse(strGroupData);
		JSONArray groupAddArr = new JSONArray();
		
		if(strTeam_id != null) {
			for(int i=0 ; i<groupData.size() ; i++) {
				JSONObject groupObj = (JSONObject) groupData.get(i);
				
				int currentTeam_id = Integer.parseInt(strTeam_id);
				Long teamId = (Long) groupObj.get("team_id");
				int id = teamId.intValue();
				String existContent = (String) groupObj.get("content");

                JSONObject groupAddObj = new JSONObject();
                
                // 팀 아이디에 해당하는 팀의 내용을 업데이트하고, 다른 팀은 기존 내용을 유지하면서 새로운 내용을 추가
                // 현재 팀아이디에 content put
                if(id == currentTeam_id) {
	                groupAddObj.put("team_id", id);
	                groupAddObj.put("content",content);
	
	                groupAddArr.add(groupAddObj);
                } else {
                // 다른 팀아이디는 원래 내용 put
                	groupAddObj.put("team_id", id);
                	groupAddObj.put("content",content == null ? null : existContent);
                	
                	groupAddArr.add(groupAddObj);
                }
			}
		}
		
		userService.addContentToGroupData(user,groupAddArr);
	}
	
	@ResponseBody
	@GetMapping(value = "/display")
	public ResponseEntity<byte[]> showImageGET(
	        @RequestParam("fileName") String fileName
	) {
	   
		String fileUrl = s3Service.getFilePath(fileName);
	    ResponseEntity<byte[]> result = null;

	    try {
	    	 // URL을 통해 InputStream을 열어서 byte 배열로 읽어옴
	        URL url = new URL(fileUrl);
	        InputStream inputStream = url.openStream();
	        byte[] imageBytes = IOUtils.toByteArray(inputStream);

	        HttpHeaders headers = new HttpHeaders();
	        // 확장자에 따라 Content-type을 설정
	        String extension = "";
	        int dotIndex = fileUrl.lastIndexOf('.');
	        if (dotIndex > 0 && dotIndex < fileUrl.length() - 1) {
	            extension = fileUrl.substring(dotIndex);
	        }
	        
	        switch (extension.toLowerCase()) {
	            case "jpg":
	            	headers.add("Content-Type", "image/jpg");
	                break;
	            case "jpeg":
	                headers.add("Content-Type", "image/jpeg");
	                break;
	            case "png":
	                headers.add("Content-Type", "image/png");
	                break;
	            default:
	            	// 기본적으로 바이너리 데이터로 처리
	                headers.add("Content-Type", "application/octet-stream"); 
	                break;
	        }

	        return new ResponseEntity<>(imageBytes, headers, HttpStatus.OK);
	    } catch (IOException e) {
	        e.printStackTrace();
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
		
	@PostMapping("/imageUpload")
	public ResponseEntity<Map<String, String>> rec_uploadFile(@RequestPart(value = "file", required = false) MultipartFile[] files,
			HttpServletRequest request) {

		 try {
			Map<String, String> data = new HashMap();
			// 각 파일에 대해 처리
			for (MultipartFile file : files) {
				// 업로드할 파일의 메타데이터 설정
				ObjectMetadata metadata = new ObjectMetadata();
				metadata.setContentType(file.getContentType());
				metadata.setContentLength(file.getSize());

				// 타임스탬프를 포함한 새로운 파일 이름 생성
				String timestamp = String.valueOf(System.currentTimeMillis());
				String newFile = timestamp + "_" + file.getOriginalFilename();

				// 각 파일에 대해 Amazon S3에 업로드하고, 업로드된 이미지의 경로를 반환
				amazonS3Client.putObject(bucket, newFile, file.getInputStream(), metadata);
				
	            data.put("uploadPath", newFile);  // 업로드된 이미지 경로
			}

            return ResponseEntity.ok(data);
        } catch (Exception e) {
            e.printStackTrace();
            return (ResponseEntity<Map<String, String>>) ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR);
        }
	}
	
	
	@PostMapping("/user/check_exist_user_pw.do")
	public void checkExistUserPw(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		
		String existPassword = request.getParameter("password");
		User user = (User)session.getAttribute("user");
		if(bCryptPasswordEncoder.matches(existPassword, user.getPassword())) {
			response.getWriter().print(1);
		}else {
			response.getWriter().print(0);
		}
	}
	
}

