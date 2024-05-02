package com.example.triptable.service;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Locale;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Team;
import com.example.triptable.entity.User;
import com.example.triptable.repository.FinanceRepository;
import com.example.triptable.repository.SpotRepository;
import com.example.triptable.repository.TeamRepository;
import com.example.triptable.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Service
public class PlanService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private TeamRepository teamRepository;

	@Autowired
	private FinanceRepository financeRepository;
	
	@Autowired
	private SpotRepository spotRepository;

	/* 팀 생성 메서드, 여행계획 페이지 모달에서 새로운 계획 생성하기 눌렀을때만 실행 됨(수정완료) - 조민희 */
	public JSONObject makegroup(HttpSession session, User user, String region) {
		
		
		// 세션의 저장되어있는 회원의 아이디 값
		int user_id = user.getId();

		// 회원 아이디를 넣을 JSON 배열, 객체 생성
		JSONArray userDatas = new JSONArray();
		JSONObject userData = new JSONObject();

		userData.put("user_id", user_id);
		userDatas.add(userData);

		// 여행 시작날과 마지막날을 팀생성 날짜 기준 +1, +2 일로 defalut값을 줌 / 없으면 캘린더 같지가 않아서 이상해보임
		LocalDate startDay = LocalDate.now().plusDays(1);
		LocalDate endDay = LocalDate.now().plusDays(2);
		
		// yyyy-MM-dd 형태의 문자열로 저장
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String strStartDay = startDay.format(formatter);
        String strEndDay = endDay.format(formatter);

        // 팀 객체에 저장
		Team team = new Team();
		team.setName(user.getNickname() + "와(과) 함께하는 여행!");
		
		if(region != null) {
			team.setDestination(region);
		}else {
			team.setDestination("서울특별시");
		}
		
		team.setTravlestart(strStartDay);
		team.setTravleend(strEndDay);
		team.setUserdata(userDatas.toString());

		// char 선언
		String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		// URL 선언
		String randomUrl = "";

		for (int i = 0; i < 12; i++) {
			int randomIndex = (int) Math.floor(Math.random() * characters.length());
			randomUrl += characters.charAt(randomIndex);
		}

		// 현재 시간을 나타내는 Instant 객체 생성
		Instant now = Instant.now();

		// DateTimeFormatter를 사용하여 특정 형식으로 포맷팅
		formatter = DateTimeFormatter.ofPattern("HHmmssSSSSSSSSS");
		String formattedInstant = now.atOffset(java.time.ZoneOffset.UTC).format(formatter);

		randomUrl += formattedInstant;

		team.setUrl(randomUrl);

		teamRepository.save(team);

		// 팀을 세션에 저장, 여행 계획 AJAX에서 많이 사용됨
		session.setAttribute("team_id", team.getId());

		JSONArray groupDatas = new JSONArray();
		JSONObject groupData = new JSONObject();

		groupData.put("team_id", team.getId());

		String strExistGroupData = user.getGroupdata();

		JSONParser parser = new JSONParser();

		// 파싱때문에 try catch문 필요
		try {

			// 기존에 회원의 그룹데이터가 없으면
			if (strExistGroupData == null) {
				// 새로운 그룹데이터 추가
				groupDatas.add(groupData);

				// 기존에 회원의 그룹데이터가 있으면
			} else {
				// 기존 회원의 그룹데이터를 파싱해서 groupDatas에 저장
				groupDatas = (JSONArray) parser.parse(strExistGroupData);
				// groupDatas에 새로운 그룹 추가
				groupDatas.add(groupData);
			}

			user.setGroupdata(groupDatas.toString());
			userRepository.save(user);

		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		// jsp페이지로 넘길 Group(Team)의 json 데이터 생성
		JSONObject teamObject = new JSONObject();
		Team newTeam = teamRepository.findById(team.getId());
		
		teamObject.put("team_id", newTeam.getId());
		teamObject.put("team_date", newTeam.getDate().toString());
		teamObject.put("team_destination", newTeam.getDestination());
		teamObject.put("team_lastupdate", newTeam.getLastupdate().toString());
		teamObject.put("team_name", newTeam.getName());
		teamObject.put("team_travelend", newTeam.getTravleend());
		teamObject.put("team_travelstart", newTeam.getTravlestart());
		teamObject.put("team_url", newTeam.getUrl());
		teamObject.put("team_userdata", newTeam.getUserdata());
		return teamObject;
	}

	/* 회원을 기준으로 회원이 속해있는 팀 리스트를 불러와 JSON 배열에 저장(수정완료) - 조민희 */
	public JSONArray loadGroupDatas(User user ) {

		String strGroupIds = user.getGroupdata();
		JSONParser parser = new JSONParser();
		JSONArray groupIds = null;
		JSONArray groupDatas = new JSONArray();

		try {
			
			// 회원의 팀 리스트가 널이 아닐 경우 / 널일때 처리를 안하면 파싱에서 에러남
			if (strGroupIds != null) {
				
				// 문자열을 파싱해서 JSON 배열로 저장
				groupIds = (JSONArray) parser.parse(strGroupIds);
				for (int i = groupIds.size()-1; i >= 0; i--) {

					JSONObject groupData = new JSONObject();

					// JSON
					JSONObject groupId = (JSONObject) groupIds.get(i);

					// 
					long longTeamId = (long) groupId.get("team_id");
					int teamId = (int) longTeamId;

					Team team = teamRepository.findById(teamId);
					
					LocalDate today = LocalDate.now();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
					LocalDate travleEnd = LocalDate.parse(team.getTravleend(), formatter);
					if(!travleEnd.isBefore(today)) {
						groupData.put("team_id", team.getId());
						groupData.put("team_name", team.getName());
						groupData.put("team_dest", team.getDestination());

						groupDatas.add(groupData);
					}
				}
			} else {
				groupDatas = null;
			}
		} catch (ParseException e) {
			System.out.println("[에러]" + e.getMessage());
		}
		return groupDatas;
	}




	/* 여행계획 페이지에서 모달을 통해 팀을 로드 - 조민희(수정완료) */
	public JSONObject loadGroup(HttpSession session, int teamId) {
		Team team = teamRepository.findById(teamId);
		session.setAttribute("team_id", teamId);
		
		JSONObject teamObject = new JSONObject();
		teamObject.put("team_name", team.getName());
		teamObject.put("team_url", team.getUrl());
		return teamObject;
	}
	
	/* 팀 이름 수정 - 조민희(수정완료) */ 
	public void reviseGroupName(int team_id, String team_name) {
		Team team = teamRepository.findById(team_id);
		team.setName(team_name);
		teamRepository.save(team);
	}

	/* URL을 통해 팀에 가입(수정완료) - 박수진 */
	public JSONObject joinGroup(HttpSession session, int team_id, User user) {
		
		Team team = teamRepository.findById(team_id);
		
		System.out.println("joingroup() 실행");
		JSONParser parser = new JSONParser();
		String userDataByGroup = team.getUserdata();
		String groupDataByUser = user.getGroupdata();

		JSONObject newObject1 = new JSONObject();
		newObject1.put("user_id", user.getId());

		JSONObject newObject2 = new JSONObject();
		newObject2.put("team_id", team.getId());
		
		JSONObject teamObject = new JSONObject();

		try {
			// JSON 배열 문자열을 JSON 배열로 파싱
			JSONArray userIds = (JSONArray) parser.parse(userDataByGroup);
			JSONArray groupIds = new JSONArray();
			if (groupDataByUser == null) {

			} else {
				groupIds = (JSONArray) parser.parse(groupDataByUser);
			}

			// 초대받은 링크로 올 때 가입되어 있는지 중복값 검사할 flag
			int flag = 0;

			// 중복값 있을시 flag = 1;
			for (int i = 0; i < userIds.size(); i++) {
				JSONObject oldObject = (JSONObject) userIds.get(i);

				if (user.getId() == Integer.parseInt(oldObject.get("user_id").toString())) {
					flag = 1;
					break;
				}
			}

			// 중복값 없을시 joinGroup시키며 데이터 업데이트
			if (flag == 0) {
				userIds.add(newObject1);
				groupIds.add(newObject2);

				team.setUserdata(userIds.toString());
				user.setGroupdata(groupIds.toString());

				team = teamRepository.save(team);
				userRepository.save(user);
				
			}
			
			session.setAttribute("team_id", team_id);

			// 새로운 JSON 객체 생성 및 배열에 추가
			
			
			JSONArray userDataObject = null;
			
			try {
				userDataObject = (JSONArray) parser.parse(team.getUserdata());
			} catch (ParseException e) {
				e.printStackTrace();
			}
						
			teamObject.put("team_id", team.getId());
			teamObject.put("team_date", team.getDate().toString());
			teamObject.put("team_destination", team.getDestination());
			teamObject.put("team_lastupdate", team.getLastupdate().toString());
			teamObject.put("team_name", team.getName());
			teamObject.put("team_travelend", team.getTravleend());
			teamObject.put("team_travelstart", team.getTravlestart());
			teamObject.put("team_url", team.getUrl());
			teamObject.put("team_userdata", userDataObject);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return teamObject;

	}
	
	/* 타임머신을 통해 여행계획페이지에 들어갈 때 팀을 불러옴(수정완료) - 조민희 */
	public JSONObject loadGroupTimeMachine(int team_id) {
		
		Team team = teamRepository.findById(team_id);
		JSONObject teamObject = new JSONObject();
		
		JSONArray userDataObject = null;
		
		JSONParser parser = new JSONParser();
		
		try {
			userDataObject = (JSONArray) parser.parse(team.getUserdata());
		} catch (ParseException e) {
			e.printStackTrace();
		}

		teamObject.put("team_id", team.getId());
		teamObject.put("team_date", team.getDate().toString());
		teamObject.put("team_destination", team.getDestination());
		teamObject.put("team_lastupdate", team.getLastupdate().toString());
		teamObject.put("team_name", team.getName());
		teamObject.put("team_travelend", team.getTravleend());
		teamObject.put("team_travelstart", team.getTravlestart());
		teamObject.put("team_url", team.getUrl());
		teamObject.put("team_userdata", userDataObject);
		
		return teamObject;
	}
	
	/* 여행 날짜 저장(수정완료) - 조민희 */
	public void saveDay(int team_id, String startDay, String endDay) {
		
		Team team = teamRepository.findById(team_id);
		// 기존에 저장되어있던 여행 시작날짜와 끝날짜를 불러와서 문자열로 저장
		String strOldTravelStart = team.getTravlestart();
		String strOldTravelEnd = team.getTravleend();
		
		// LocalDate 객체로 변환
		LocalDate oldTravelStart = LocalDate.parse(strOldTravelStart);
		LocalDate oldTravelEnd = LocalDate.parse(strOldTravelEnd);
		
		// 새로운 여행 시작날짜와 끝날짜를 LocalDate 객체로 변환
		LocalDate travelStart = LocalDate.parse(startDay);
		LocalDate travelEnd = LocalDate.parse(endDay);
		
		// 기존여행시작날짜 - 기존여행끝날짜 + 1
		int oldDaysDifference = (int)ChronoUnit.DAYS.between(oldTravelStart, oldTravelEnd) + 1;
		
		// 새로운여행시작날짜 - 새로운여행끝날짜 + 1
		int daysDifference = (int)ChronoUnit.DAYS.between(travelStart, travelEnd) + 1;

		// 새로운 여행기간이 기존 여행기간보다 짧을 경우
		if(daysDifference - oldDaysDifference < 0) {
			
			// 사라진 일차의 여행지, 가계부 데이터를 삭제
			for(int i=daysDifference+1; i<=oldDaysDifference; i++) {
				spotRepository.deleteByTeamAndDay(team.getId(), i);
				financeRepository.deleteByTeamAndDay(team.getId(), i);
			}
		}
		
		// 팀에 새로운 여행날짜 업데이트
		team.setTravlestart(startDay);
		team.setTravleend(endDay);		
		teamRepository.save(team);
		
		
	}
	
	/* 캘린더 버튼 생성(수정완료) - 조민희 */
	public JSONObject createDayButton(int team_id) {	
		
		Team team = teamRepository.findById(team_id);
		
		// 기존 여행날짜를 불러와 문자열로 저장
		String startDay = team.getTravlestart();
		String endDay = team.getTravleend();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = null;
		Date endDate = null;

		try {
			// Date 객체로 변환
			startDate = formatter.parse(startDay);
			endDate = formatter.parse(endDay);
			
			SimpleDateFormat dayFormat = new SimpleDateFormat("EEEE", Locale.KOREAN);
			
			// "-"를 "."으로 바꾸고 요일 정보를 붙임
			startDay = startDay.replace("-", ".") + "(" + dayFormat.format(startDate).replace("요일", "") + ")";
			endDay = endDay.replace("-", ".") + "(" + dayFormat.format(endDate).replace("요일", "") + ")";

		} catch (java.text.ParseException e) {
			e.printStackTrace();
		}
		
		JSONObject dayObject = new JSONObject();
		
		// JSON 객체 반환
		dayObject.put("startDay", startDay);
		dayObject.put("endDay", endDay);		

		return dayObject;
	}
	
	/* 팀 여행지역 저장 - 조민희 */
	public void saveDosi(int team_id, String dosi) {
		Team team = teamRepository.findById(team_id);
		team.setDestination(dosi);
		
		teamRepository.save(team);
		
	}
	
	/* 가계부 일차 선택 옵션 생성 - 조민희 */
	public int createDayOption(int team_id) {
		
		Team team = teamRepository.findById(team_id);
		// 기존의 여행 날짜를 불러와서 문자열로 저장
		String startDay = team.getTravlestart();
		String endDay = team.getTravleend();
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate startDate = null;
		LocalDate endDate = null;

		// LocalDate 객체로 변환
		startDate = LocalDate.parse(startDay, formatter);
		endDate = LocalDate.parse(endDay, formatter);
			
		// 여행 일차 = 여행 끝 날짜 - 시작 날짜 + 1
		int daysBetween = (int)java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate) + 1;
		
		return daysBetween;
	}
	
	/* 팀 멤버의 정보 반환(초대링크 모달에서 사용)(수정완료) - 조민희 */
	public JSONArray loadGroupMember(int team_id) {
		
		// 세션에 저장되어있는 team은 업데이트 안된 team 이라 다시 불러와야 함
		Team team = teamRepository.findById(team_id); 
		
		// 팀의 회원 정보를 불러와서 문자열로 저장
		String strUserIdData = team.getUserdata();
		JSONParser parser = new JSONParser();
		JSONArray memberArray = new JSONArray();
		
		try {
			// 문자열 회원 정보를 JSON 배열 형식으로 파싱
			JSONArray userIdData = (JSONArray)parser.parse(strUserIdData);
			
			// 배열의 크기만큼 반복
			for(int i=0; i<userIdData.size(); i++) {
				JSONObject memberObject = new JSONObject();
				
				// 회원 id를 JSON 객체로 저장
				JSONObject userIdObject = (JSONObject)userIdData.get(i);
				
				// JSONObject에서 id를 long으로 받아 int로 변환 -> 바로 int로 받으면 에러남..
				Long longUserId = (Long)userIdObject.get("user_id");
				int userId = longUserId.intValue();
				
				// 회원 id를 기준으로 회원을 찾아 아이콘, 별명, 메일을 memberObject에 저장
				User user = userRepository.findById(userId);
				
				if(user != null) {
					
					memberObject.put("icon", user.getIcon());
					memberObject.put("nickname", user.getNickname());
					memberObject.put("mail", user.getMail());
					
					memberArray.add(memberObject);
				}
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return memberArray;
	}
                    

}