package com.example.triptable.controller;

import java.io.IOException;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import com.example.triptable.entity.Region;
import com.example.triptable.entity.Team;
import com.example.triptable.entity.User;
import com.example.triptable.repository.RegionRepository;
import com.example.triptable.repository.TeamRepository;
import com.example.triptable.service.CalendarUtil;
import com.example.triptable.service.FinanceService;
import com.example.triptable.service.MapService;
import com.example.triptable.service.PlanService;
import com.example.triptable.service.PreparationService;
import com.example.triptable.service.SpotService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;


//** 여행 계획 CONTROLLER **//

@Controller
public class TripPlanController {

	@Autowired
	private RegionRepository regionRepository;

	@Autowired
	private TeamRepository teamRepository;

	@Autowired
	private PlanService planService;

	@Autowired
	private PreparationService preparationService;

	@Autowired
	private FinanceService financeService;

	@Autowired
	private SpotService spotService;

	@Autowired
	private MapService mapService;


	/********************************************
	 * URL 매핑
	 ********************************************/

	/* 도,시 별 시,군 행정구역 JSON - 박수진 */
	@PostMapping("/user/addressJson.do")
	public ModelAndView showRegion(HttpServletRequest request) {
		System.out.println("showRegion() 호출 성공");
		ModelAndView modelAndView = new ModelAndView();

		// select 된 도/시 별로 호출
		String dosi = request.getParameter("dosi");
		List<Region> datas = regionRepository.findAllByDosi(dosi);

		request.setAttribute("datas", datas);
		modelAndView.setViewName("json/addressJson");
		return modelAndView;
	}



	/* 여행 계획 페이지 매핑 - 조민희(수정완료) */
	@GetMapping("/user/trip_plan.do")
	public ModelAndView tripplan(
		@RequestParam(name = "year", defaultValue = "0") int year,
		@RequestParam(name = "month", defaultValue = "0") int month,
		HttpServletRequest request, 
		HttpSession session
	) {
		System.out.println("tripplan.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();

		String region = request.getParameter("region");

		// randomUrl, user를 세션에서 얻어옴
		String randomUrl = (String) session.getAttribute("randomUrl");
		User user = (User) session.getAttribute("user");

		// randomUrl을 기준으로 팀을 찾음
		Team team = teamRepository.findByUrl(randomUrl);

		int team_id = 0;

		// 밑에 if문을 검사하려면 팀을 세션에서 받아와야하는데
		if (session.getAttribute("team_id") != null) {
			team_id = (Integer) session.getAttribute("team_id");
		}

		// 여기서 makegroup에서 또 세션에 team을 저장해서
		if (region != null && team_id == 0) {
			planService.makegroup(session, user, region);

		}

		// 다시 team을 session에서 얻어와야 함
		if (session.getAttribute("team_id") != null) {
			team_id = (Integer) session.getAttribute("team_id");
		}
		JSONObject teamObject = null;

		// randomUrl이 있으면
		if (randomUrl != null) {

			// 가입을 시킨 후
			teamObject = planService.joinGroup(session, team.getId(), user);

			// 세션에서 randomUrl을 삭제, 삭제 안하면 trip_plan 페이지에서 못 빠져나감
			session.removeAttribute("randomUrl");

			// 타임머신에서 옴 & ramdomUrl로 가입한뒤 새로고침 & 이전 여행계획 불러온 뒤 새로고침 & 새로운 그룹 생성 후 새로고침 ->
			// 여기서 처리 됨
			// timeMachineTeam가 있으면 teamObject를 반환하여 여행계획 페이지에서 모달 띄움 여부를 결정
		} else if (team_id != 0) {
			teamObject = planService.loadGroupTimeMachine(team_id);
		}
		// teamObject 값이 있으면 request에 값 저장, session에 저장하면 모달이 계속 뜸
		if (teamObject != null) {
			request.setAttribute("teamObject", teamObject.toJSONString());
		}

		// 도,시 중복값 제외 list
		List<String> listDosi = regionRepository.findDistinctDosi();

		/********************************************
	 	* 달력 구현 - 구동현 
	 	********************************************/

		// generateCalendarHtml 메서드를 사용하여 HTML 문자열 생성
		// year와 month가 0이면 현재 날짜의 년도와 월을 기본값으로 사용
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
	
		request.setAttribute("listDosi", listDosi);

		String apiKey = mapService.getKakao_javaScript_key();
	
		modelAndView.addObject("apiKey", apiKey);
		modelAndView.addObject("currentMonthHtml", currentMonthHtml);
		modelAndView.addObject("nextMonthHtml", nextMonthHtml);
		// 연도와 월을 Model에 추가
		modelAndView.addObject("selectedYear", year);
		modelAndView.addObject("selectedMonth", month);
		modelAndView.setViewName("user/trip_plan");
		
		StringBuffer sbDomain = new StringBuffer();
		sbDomain.append(request.getScheme()).append("://").append(request.getServerName()).append(":").append(request.getServerPort()).append(request.getContextPath());

		modelAndView.addObject("domain", sbDomain.toString());
		return modelAndView;
	}

	/********************************************
	 * 팀 정보 불러오기 AJAX
	 ********************************************/

	/* 팀 생성 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/create_Group.do")
	public void create_Group(HttpSession session, HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");

		// 생성되는 그룹에 대한 JSONObect 데이터
		JSONObject jsonObject = planService.makegroup(session, user, null);

		response.setCharacterEncoding("utf-8");

		// AJAX안에서 사용할 수 있도록 JSONString 형태로 반환
		response.getWriter().write(jsonObject.toJSONString());

	}

	/* 팀 리스트 데이터 불러오기 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/load_GroupDatas.do")
	public void load_GroupDatas(HttpSession session, HttpServletResponse response) throws IOException {
		User user = (User) session.getAttribute("user");

		// 로그인한 회원을 기준으로 팀 리스트를 JSONArray 형태로 반환
		JSONArray groupArray = planService.loadGroupDatas(user );

		response.setCharacterEncoding("utf-8");

		// 팀 리스트가 null일 경우 0을 반환해서 AJAX 안에서 새로운 그룹을 생성하라는 알림창을 띄움
		if (groupArray == null) {

			response.getWriter().print(0);
		} else {
			// AJAX안에서 사용할 수 있도록 JSONString 형태로 반환
			response.getWriter().write(groupArray.toJSONString());
		}
	}

	/* 팀 불러오기 AJAX - 조민희(수정완료) */
	@PostMapping("/user/load_Group.do")
	public void load_Group(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {

		// 팀 리스트에서 회원이 선택한 팀의 ID를 AJAX를 통해 받음
		int teamId = Integer.parseInt(request.getParameter("teamId"));

		// 팀 ID에 맞는 팀의 JSONObject를 반환
		JSONObject teamObject = planService.loadGroup(session, teamId);

		response.setCharacterEncoding("utf-8");

		// AJAX안에서 사용할 수 있도록 JSONString 형태로 반환
		response.getWriter().write(teamObject.toJSONString());
	}

	/* 팀 이름 수정 AJAX - 조민희(수정완료) */
	@PostMapping("/user/revise_group_name.do")
	public void revise_group_name(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {

		// AJAX를 통해 팀의 이름을 받아옴
		String team_name = request.getParameter("team_name");

		// 세션에서 팀을 받아옴
		int team_id = (Integer) session.getAttribute("team_id");

		// 팀 이름 수정
		planService.reviseGroupName(team_id, team_name);

		response.getWriter().write("1");
	}

	/* 타임머신에서 여행계획으로 이동할 때 세션에 팀 저장 AJAX(수정완료) - 손수빈 */
	@PostMapping("/user/team_session.do")
	public void team_session(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {
		int team_id = Integer.parseInt(request.getParameter("team_id"));

		// 팀 ID를 기준으로 팀을 찾음

		session.setAttribute("team_id", team_id);

		response.getWriter().write(1);
	}

	/* 그룹멤버 리스트 불러오기(수정완료) - 조민희 */
	@PostMapping("/user/load_group_member.do")
	public void loadGroupMember(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {

		int team_id = (Integer) session.getAttribute("team_id");

		JSONArray memberArray = planService.loadGroupMember(team_id);

		response.setCharacterEncoding("utf-8");
		response.getWriter().write(memberArray.toJSONString());
	}

	/********************************************
	 * 여행 일정 관련 AJAX
	 ********************************************/

	/* 여행 일정 저장 AJAX - 조민희(수정완료) */
	@PostMapping("/user/save_day.do")
	public void saveDay(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {

		// AJAX를 통해 여행 시작날과 끝날을 받아옴
		String startDay = request.getParameter("startDay");
		String endDay = request.getParameter("endDay");

		int team_id = (Integer) session.getAttribute("team_id");
		// 여행 시작날과 끝날을 저장
		planService.saveDay(team_id, startDay, endDay);

		response.getWriter().write(1);
	}

	/* 일차 생성 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/create_day_button.do")
	public void createDayButton(HttpSession session, HttpServletResponse response) throws IOException {

		// 세션에서 팀을 받아옴
		int team_id = (Integer) session.getAttribute("team_id");

		// 여행날짜를 받아와서 JSONObject에 저장
		JSONObject dayObject = planService.createDayButton(team_id);

		response.setCharacterEncoding("utf-8");

		// AJAX안에서 사용할 수 있도록 JSONString 형태로 반환
		response.getWriter().write(dayObject.toJSONString());
	}

	/* 일차 옵션 버튼, 여행지 일차 정보(추가 예정) AJAX(수정완료) - 조민희 */
	@PostMapping("/user/create_day_option.do")
	public void createDayOption(HttpSession session, HttpServletResponse response) throws IOException {

		int team_id = (Integer) session.getAttribute("team_id");

		// daysBetween = 끝날짜 - 시작 날짜;
		int daysBetween = planService.createDayOption(team_id);

		// AJAX에 daysBetween 반환
		response.getWriter().print(daysBetween);
	}

	/********************************************
	 * 여행지 관련 AJAX
	 ********************************************/

	/* 여행지 추가 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/insert_spot.do")
	public void insertSpot(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {

		int team_id = (Integer) session.getAttribute("team_id");
		int day = Integer.parseInt(request.getParameter("sourceDay"));
		String name = request.getParameter("sourceName");
		String latitude = request.getParameter("sourceLatitude");
		String longitude = request.getParameter("sourceLongitude");
		String address = request.getParameter("sourceAddress");
		String roadaddress = request.getParameter("sourceRoadAddress");
		String imgUrl = request.getParameter("sourceImgUrl");
		String category = request.getParameter("sourceCategory");
		String phone = request.getParameter("sourcePhone");
		String memo = request.getParameter("sourceMemo");

		int flag = spotService.insertSpot(
				team_id, day, name, latitude, longitude, address, roadaddress, imgUrl, category, phone, memo);

		if (flag == 1) {
			response.getWriter().print(1);
		} else {
			response.getWriter().print(0);
		}
	}

	/* 여행지 테이블 생성 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/create_spot_table.do")
	public void createSpotTable(HttpSession session, HttpServletResponse response) throws IOException {

		int team_id = (Integer) session.getAttribute("team_id");
		JSONArray dayArray = spotService.createSpotTable(team_id);
		response.setCharacterEncoding("utf-8");

		if (dayArray.size() == 0) {
			response.getWriter().print(0);
		} else {
			response.getWriter().write(dayArray.toJSONString());
		}

	}

	/* 여행지 메모 업데이트 - 구동현 */
	@PostMapping("/user/saveSpotMemo.do")
	public void saveSpotMemo(
		HttpServletRequest request, HttpServletResponse response
	)throws IOException {
		String spotString = request.getParameter("spotId");
		if (spotString != null) {
			int spotId = Integer.parseInt(spotString);
			String newMemo = request.getParameter("newMemo");
			
			spotService.updateSpotMemo(spotId, newMemo);

			response.getWriter().print(0);
		}
	}
		
	@PostMapping("/user/updateOrder.do")
	public void updateOrder(
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response
	) {
		String strspotId = request.getParameter("spotId");

		String[] arraySpot = strspotId.split(",");
		List<Integer> spotIds = new ArrayList<>();

		String strDay = request.getParameter("spotDay");
		int spotDay = Integer.parseInt(strDay);

		for (String spot : arraySpot) {
			int spotId = Integer.parseInt(spot);
			spotIds.add(spotId);
		}

		int team_id = (Integer) session.getAttribute("team_id");

		spotService.updateSpotOrder(team_id, spotDay, spotIds);
	}
	


	/* 여행지 삭제 AJAX - 조민희 */
	@PostMapping("/user/delete_spot.do")
	public void deleteSpot(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String spotString = request.getParameter("spotId");

		if (spotString != null) {
			int spotId = Integer.parseInt(spotString);

			spotService.deleteSpot(spotId);

			response.getWriter().print(0);
		}

	}

	/********************************************
	 * 여행 지역 관련 AJAX
	 ********************************************/

	/* 도시 저장 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/save_dosi.do")
	public void saveDosi(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {

		// AJAX에서 dosi를 받아옴
		String dosi = request.getParameter("dosi");

		int team_id = (Integer) session.getAttribute("team_id");

		// 여행 지역을 팀에 저장
		planService.saveDosi(team_id, dosi);

		response.getWriter().write(1);
	}

	/* 도시 버튼 생성 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/create_dosi_button.do")
	public void createDosiButton(HttpSession session, HttpServletResponse response) throws IOException {
		int team_id = (Integer) session.getAttribute("team_id");

		// 팀의 여행지역 반환
		Team team = teamRepository.findById(team_id);
		String dosi = team.getDestination();

		response.setCharacterEncoding("utf-8");

		// AJAX에 여행지역 반환
		response.getWriter().write(dosi);
	}

	/********************************************
	 * 준비물 관련 AJAX
	 ********************************************/

	/* 준비물 생성 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/add_todo.do")
	public void addTodo(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {
		
		Boolean checkboxState = Boolean.parseBoolean(request.getParameter("checkboxState"));
		
		String checklist = request.getParameter("checklist");
		int team_id = (Integer) session.getAttribute("team_id");

		preparationService.addTodo(team_id, checkboxState, checklist);

		response.getWriter().write(1);
	}

	/* 준비물 테이블 생성 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/create_todo_table.do")
	public void loadTodo(HttpSession session, HttpServletResponse response) throws IOException {
		int team_id = (Integer) session.getAttribute("team_id");
		JSONArray todoArray = preparationService.loadTodo(team_id);

		response.setCharacterEncoding("utf-8");

		if (todoArray == null) {
			response.getWriter().print(0);
		} else {
			response.getWriter().write(todoArray.toJSONString());
		}
	}

	/* 준비물 삭제 AJAX - 조민희 */
	@PostMapping("/user/delete_todo.do")
	public void deleteTodo(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int pre_id = Integer.parseInt(request.getParameter("pre_id"));

		preparationService.deleteTodo(pre_id);

		response.getWriter().write(1);
	}

	/* 준비물 재저장 저장 AJAX - 조민희 */
	@PostMapping("/user/resave_todo.do")
	public void resaveTodo(HttpServletRequest request, HttpServletResponse response) throws IOException {

		
		int pre_id = Integer.parseInt(request.getParameter("pre_id"));
		Boolean checkboxState = Boolean.parseBoolean(request.getParameter("checkboxState"));
		String checklist = request.getParameter("checklist");

		preparationService.resaveTodo(pre_id, checkboxState, checklist);

		response.getWriter().write(1);

	}

	/********************************************
	 * 가계부 관련 AJAX
	 ********************************************/

	/* 가계부 테이블 생성 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/create_finance_table.do")
	public void create_finance_table(HttpSession session, HttpServletResponse response) throws IOException {

		int team_id = (Integer) session.getAttribute("team_id");
	
		JSONArray financeArray = financeService.getFinanceList(team_id);

		response.setCharacterEncoding("utf-8");
		response.getWriter().write(financeArray.toJSONString());

	}

	/* 가계부 항목 저장 AJAX(수정완료) - 조민희 */
	@PostMapping("/user/add_expense.do")
	public void addExpense(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		int day = Integer.parseInt(request.getParameter("day"));
		String detail = request.getParameter("detail");
		int expense = Integer.parseInt(request.getParameter("expense"));
		int team_id = (Integer)session.getAttribute("team_id");
		financeService.insertFinance(day, detail, expense, team_id);
		
	     response.getWriter().print(1);

   }

   /* 가계부 항목 삭제 AJAX - 조민희 */   
   @PostMapping("/user/delete_expense.do")
   public void delete_finance(HttpServletRequest request, HttpServletResponse response) throws IOException {

      int fin_Id = Integer.parseInt(request.getParameter("id"));

      financeService.deleteFinance(fin_Id);
      response.getWriter().print(1);

   }
   
   @PostMapping("/user/resave_expense.do")
   public void resaveExpense(HttpServletRequest request, HttpServletResponse response) throws IOException {
	   
	   String detail = request.getParameter("detail");
	   int expense = Integer.parseInt(request.getParameter("expense"));
	   int fin_Id = Integer.parseInt(request.getParameter("id"));   

	   financeService.resaveFinance(detail, expense, fin_Id);
	   
	   response.getWriter().print(1);   
   }
	

}