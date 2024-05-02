package com.example.triptable.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Spot;
import com.example.triptable.entity.Team;
import com.example.triptable.repository.SpotRepository;
import com.example.triptable.repository.TeamRepository;

@Service
public class SpotService {

	@Autowired
	private SpotRepository spotRepository;

	@Autowired
	private TeamRepository teamRepository;

	/* 여행지 추가(수정완료) - 조민희 , 이거 순서 건들지 마세요 제발 - 구동현 */
	public int insertSpot(
			int team_id, int day, String name, String latitude, String longitude,
			String address, String roadaddress, String imgUrl, String category, String phone, String memo) {

		Team team = teamRepository.findById(team_id);
		
		List<Spot> spotList = spotRepository.findByTeamAndDay(team_id, day);

		// 일차 별 추가 가능한 여행지는 최대 12개 / 12개가 넘으면 0을 반환
		if (spotList.size() >= 12) {
			return 0;

			// 12개보다 작으면
		} else {
			Spot spot = new Spot();

			if (spotList.size() == 0) {
				spot.setSpotStart("10:00");
				spot.setSpotOrder(1);
			} else {

				String strMaxTime = spotList.get(0).getSpotStart();
				LocalTime maxTime = LocalTime.parse(strMaxTime);

				for (int i = 1; i < spotList.size(); i++) {
					String strTime = spotList.get(i).getSpotStart();
					LocalTime time = LocalTime.parse(strTime);
					
					// maxtime이 이전이면 음수
					int comparison = maxTime.compareTo(time);
					if (comparison < 0) {
						maxTime = time;
					}
				}
				spot.setSpotStart(maxTime.plusMinutes(30).toString());
			}

			// 여행지 업데이트 후 1을 반환
			spot.setTeam(team);
			spot.setDay(day);
			spot.setName(name);
			spot.setLatitude(latitude);
			spot.setLongtitude(longitude);
			spot.setAddress(address);
			spot.setRoadaddress(roadaddress);
			spot.setImgurl(imgUrl);
			spot.setCategory(category);
			spot.setPhone(phone);
			spot.setSpotMemo(memo);
			
			for (int d = 1; d <= spotList.size(); d++){
				spot.setSpotOrder(d+1);
			}
		

			spotRepository.save(spot);

			return 1;
		}
	}

	/* 여행지 테이블 생성(DB아니고 html 테이블)(수정완료) - 조민희 */
	public JSONArray createSpotTable(int team_id) {

		Team team = teamRepository.findById(team_id);
		// 팀의 여행 시작날짜와 끝날짜를 문자열로 저장
		String startDay = team.getTravlestart();
		String endDay = team.getTravleend();

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate startDate = null;
		LocalDate endDate = null;

		// LocalDate 객체로 파싱
		startDate = LocalDate.parse(startDay, formatter);
		endDate = LocalDate.parse(endDay, formatter);

		// 여행일차 = 여행 끝날짜 - 여행 시작날짜 + 1
		int daysBetween = (int) java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate) + 1;

		List<Spot> spotList = spotRepository.findByTeamOrderByTime(team_id);

		JSONArray dayArray = new JSONArray();

		// 일차별로 JSONObject에 값을 담아 Array에 추가
		for (int i = 1; i <= daysBetween; i++) {

			JSONArray spotArray = new JSONArray();

			for (int j = 0; j < spotList.size(); j++) {
				JSONObject spotObject = new JSONObject();

				if (spotList.get(j).getDay() == i) {
					Spot spot = spotList.get(j);
					spot.setTeam(team);

					spotObject.put("id", spot.getId());
					spotObject.put("name", spot.getName());
					spotObject.put("latitude", spot.getLatitude());
					spotObject.put("longitude", spot.getLongtitude());
					spotObject.put("address", spot.getAddress());
					spotObject.put("roadaddress", spot.getRoadaddress());
					spotObject.put("imgUrl", spot.getImgurl());
					spotObject.put("category", spot.getCategory());
					spotObject.put("phone", spot.getPhone());
					spotObject.put("startTime", spot.getSpotStart());
					spotObject.put("memo", spot.getSpotMemo());

					spotArray.add(spotObject);

				}
			}

			dayArray.add(spotArray);
		}

		return dayArray;
	}

	/* 여행지 시간 한꺼번에 저장 - 조민희 */
	public void saveTime(int spotId, String spotTime) {

		Spot spot = spotRepository.findById(spotId);
		spot.setSpotStart(spotTime);

		spotRepository.save(spot);

	}

	/* 여행지 삭제 - 조민희 */
	public void deleteSpot(int spotId) {

		Spot spot = spotRepository.findById(spotId);
		spotRepository.delete(spot);

	}

	/* 여행지 메모 추가 - 구동현 */
    public void updateSpotMemo(int spotId, String newMemo) {
        Spot existingSpot = spotRepository.findById(spotId);

        existingSpot.setSpotMemo(newMemo);
        spotRepository.save(existingSpot);
    }


	public void updateSpotOrder(int team_id, int day, List<Integer> spotIds) {
	
		// 팀과 날짜에 해당하는 Spot 엔터티 목록 조회
		List<Spot> spotList = spotRepository.findByTeamAndDay(team_id, day);
	
		// Spot 엔터티 목록과 spotIds의 크기가 일치하는지 확인
		if (spotList.size() != spotIds.size()) {
			return;
		}
	
		// Spot 엔터티 목록을 순회하며 spotIds를 기반으로 spotOrder 업데이트
		for (int i = 0; i < spotIds.size(); i++) {
			int spotId = spotIds.get(i);

			// Spot 엔터티 목록에서 spotId에 해당하는 Spot 찾기
			Spot spotToUpdate = spotList.stream()
					.filter(spot -> spot.getId() == spotId)
					.findFirst()
					.orElse(null);

			// Spot 엔터티가 존재하면 spotOrder 업데이트
			if (spotToUpdate != null) {
				spotToUpdate.setSpotOrder(i + 1);
			} 
		}

	
		// 변경된 Spot 엔터티 목록을 저장
		spotRepository.saveAll(spotList);
	}

}
