package com.example.triptable.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Team;
import com.example.triptable.entity.User;
import com.example.triptable.repository.RegionRepository;
import com.example.triptable.repository.TeamRepository;
import com.example.triptable.repository.UserRepository;
import jakarta.servlet.http.HttpSession;

@Service
public class TeamService {

	@Autowired
	private TeamRepository teamRepository;

	@Autowired
	private RegionRepository regionRepository;

	// 회원에 대한 진행중인 여행, 지난 여행 리스트를 Map에 담아 반환하는 메서드
	public Map<String, Object> loadPlanByUserId(HttpSession session, User user) {

		JSONParser parser = new JSONParser();

		String strExistGroupData = user.getGroupdata();
		JSONArray existGroupData = null;

		// 진행중인 여행계획이 담길 리스트
		List<Team> activeTeamList = new ArrayList<>();

		// 지난 여행계획이 담길 리스트
		List<Team> inActiveTeamList = new ArrayList<>();

		// 진행중인 여행계획과 지난 여행계획을 담을 Map
		Map<String, Object> allTeamList = new HashMap<String, Object>();

		// 지난 여행인지 구분하기 위한 LocalDate 객체 / 실행한 날의 전날로 되어있음
		LocalDate yesterday = LocalDate.now().minusDays(1);

		// DB에 저장되어있는 여행끝날짜 문자열을 LocalDate 객체로 바꿀 formatter
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		try {
			if (strExistGroupData == null) {
				return null;
			}

			// DB에 저장되어 있는 팀데이터를 JSONArray로 변환
			existGroupData = (JSONArray) parser.parse(strExistGroupData);

			// existGroupData에서 teamId 추출
			for (int i = 0; i < existGroupData.size(); i++) {
				JSONObject currentObject = (JSONObject) existGroupData.get(i);

				// 객체에서 team_id를 가져와 teamID라는 정수형으로 변환
				int teamID = Integer.parseInt(currentObject.get("team_id").toString());

				// teamID를 기준으로 team을 찾음
				Team team = teamRepository.findById(teamID);

				// 팀의 여행 끝 날짜를 불러옴
				String strTrvlEnd = team.getTravleend();

				// 여행 끝날짜를 LocalDate 객체로 변환
				LocalDate trvlEnd = LocalDate.parse(strTrvlEnd, formatter);

				// 어제 날짜보다 미래의 날짜 = 진행중인 여행이면
				if (trvlEnd.isAfter(yesterday)) {
					// 활성화팀리스트에 추가함
					activeTeamList.add(team);

					// 지난여행이면
				} else {
					// 비활성화팀리스트에 추가함
					inActiveTeamList.add(team);
				}

			}

		} catch (ParseException e) {
			e.printStackTrace();
		}

		// 리스트의 사이즈로 빈리스트인지 확인
		// activeTeamList == null 이런 식으로 검사했더니 빈리스트는 []라는 값이 존재해 무조건 null값이 아니라함..
		// 진행중인 여행, 지난여행 모두 없을 때
		if (activeTeamList.size() == 0 && inActiveTeamList.size() == 0) {
			allTeamList.put("activeTeamList", null);
			allTeamList.put("inActiveTeamList", null);

			// 진행 중인 여행만 있을 때
		} else if (activeTeamList.size() != 0 && inActiveTeamList.size() == 0) {
			allTeamList.put("activeTeamList", activeTeamList);
			allTeamList.put("inActiveTeamList", null);

			// 지난 여행만 있을 때
		} else if (activeTeamList.size() == 0 && inActiveTeamList.size() != 0) {
			allTeamList.put("activeTeamList", null);
			allTeamList.put("inActiveTeamList", inActiveTeamList);

			// 진행중인 여행, 지난여행 모두 있을 때
		} else {
			allTeamList.put("activeTeamList", activeTeamList);
			allTeamList.put("inActiveTeamList", inActiveTeamList);
		}

		// Map 객체를 반환
		return allTeamList;

	}

	// 여행계획 수를 구하는 메서드, koreamap.jsp에서 사용됨
	public Map<String, Integer> destNum() {

		Map<String, Integer> destNum = new HashMap<String, Integer>();

		// 도시 이름 리스트를 불러옴
		List<String> dosiList = regionRepository.findDistinctDosi();

		// 지역을 group by로 묶어서 지역별 여행계획 수를 담은 리스트
		List<Object[]> teamGroupByDest = teamRepository.teamNumByDest();

		// 도시 이름 리스트의 사이즈만큼 반복
		for (int i = 0; i < dosiList.size(); i++) {

			// 도시리스트의 i번째 도시
			String dosi = dosiList.get(i);

			// 일단 무조건 도시의 여행계획수를 0으로 설정, if문에서 해당하는 도시만 값을 바꿔줌
			destNum.put(dosi, 0);

			// 지역별 여행계획 수를 담은 리스트의 사이즈만큼 반복
			for (int j = 0; j < teamGroupByDest.size(); j++) {
				// 도시 이름과 지역별 여행계획 수 리스트의 도시이름이 같으면, 여행계획이 하나라도 있다는 뜻
				// 도시의 여행계획 수를 0에서 바꿈
				if (dosi.equals(teamGroupByDest.get(j)[0])) {
					destNum.put(dosi, ((Long) teamGroupByDest.get(j)[1]).intValue());
				}
			}
		}

		return destNum;
	}

	// 관리자 페이지 - 많이 가는 여행지역 순위 엑셀파일 다운로드에 사용
	public List<Map<String, String>> DestExcelDownload() {

		List<Map<String, String>> destList = new ArrayList<Map<String, String>>();

		// 팀 여행지역 많은 순서로 랭킹을 가져옴
		List<Object[]> destRank = teamRepository.findRankTravelDestinations();

		// 리스트의 순서만큼 반복
		for (int i = 0; i < destRank.size(); i++) {

			Map<String, String> dest = new HashMap<String, String>();

			// 랭킹리스트의 i번째 지역정보를 가져옴
			Object[] destObj = destRank.get(i);

			// 순위 넣기
			dest.put("rank", (i + 1) + "");
			// 지역이름 넣기
			dest.put("name", destObj[0].toString());
			// 여행계획 수 넣기
			dest.put("planTotal", destObj[1].toString());
			// 해당지역에 등록되어 있는 숙소 개수 넣기
			dest.put("accommodationTotal", destObj[2] != null ? destObj[2].toString() : "0");
			
			// 해당지역에 등록되어 있는 코스 개수 넣기			
			dest.put("courseTotal", destObj[3] != null ? destObj[3].toString() : "0");

			destList.add(dest);
		}
		return destList;
	}

	// 메인페이지 달력 띄우기
	public List<List<String>> activeTeamDay(HttpSession session, User user) throws ParseException {

		JSONArray activeTeamList = new JSONArray();

		String strTeamList = user.getGroupdata();
		JSONParser parser = new JSONParser();

		if (strTeamList == null || strTeamList.equals("")) {
			return null;
		} else {
			JSONArray teamArray = (JSONArray) parser.parse(strTeamList);

			LocalDate today = LocalDate.now();

			for (int i = 0; i < teamArray.size(); i++) {

				JSONObject teamObject = (JSONObject) teamArray.get(i);
				int teamId = Integer.parseInt(teamObject.get("team_id").toString());

				Team team = teamRepository.findById(teamId);

				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

				LocalDate travelEnd = LocalDate.parse(team.getTravleend(), formatter);

				JSONArray activeTeam = new JSONArray();

				if (!travelEnd.isBefore(today)) {
					
					activeTeam.add(team.getTravlestart());
					activeTeam.add(team.getTravleend());

					activeTeamList.add(activeTeam);
				}

			}

			return activeTeamList;
		}

	}

}
