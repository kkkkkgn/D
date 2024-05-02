package com.example.triptable.service;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.UserLogin;
import com.example.triptable.repository.UserLoginRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class UserLoginService {
	
	@Autowired
	private UserLoginRepository userLoginRepository;
	
	
	
	public JSONArray showDayDashBoard(String day) {
		
		JSONArray timeArray = new JSONArray();
		
		LocalDate date = null;
		
		if(day.equals("today")) {
			date = LocalDate.now();
		}else if(day.equals("yesterday")){
			date = LocalDate.now().minusDays(1);
		}else if(day.equals("twoDaysAgo")){
			date = LocalDate.now().minusDays(2);
		}
		//  0번 - 날짜
		timeArray.add(date.toString());
		
		List<Integer> timeList = new ArrayList<>();
		
		for(int i=0; i<23; i++) {
			LocalDateTime localTime1 = LocalDateTime.of(date, LocalTime.of(i, 0, 0));
			LocalDateTime localTime2 = LocalDateTime.of(date, LocalTime.of(i+1, 0, 0));
			Timestamp time1 = Timestamp.valueOf(localTime1);
			Timestamp time2 = Timestamp.valueOf(localTime2);
			
			int loginUserNum = userLoginRepository.findByTimeBetween(time1, time2).size();
			
			timeList.add(loginUserNum);
			
		}
		// 2번 - 시간별 로그인 수 배열
		timeArray.add(timeList);
		
		
		return timeArray;
	}
	
	public JSONObject selectDayTotal(String day) {
		
		JSONObject totalObject = new JSONObject();
		
		LocalDate date = null;
		
		if(day.equals("today") || day == null) {
			date = LocalDate.now();
		}else if(day.equals("yesterday")){
			date = LocalDate.now().minusDays(1);
		}else if(day.equals("twoDaysAgo")){
			date = LocalDate.now().minusDays(2);
		}
		
		LocalDateTime localTime1 = date.atStartOfDay();
		LocalDateTime localTime2 = date.plusDays(1).atStartOfDay();
		
		Timestamp day1 = Timestamp.valueOf(localTime1);
		Timestamp day2 = Timestamp.valueOf(localTime2);
		
		int loginUserNum = userLoginRepository.findByTimeBetween(day1, day2).size();
		
		totalObject.put("date", date.toString());
		totalObject.put("loginUserNum", loginUserNum);
		
		return totalObject;
	}
	
	// 관리자 페이지 - 일자별 로그인 현황 엑셀파일 다운로드에 사용
	public List<Map<String, String>> loginExcelDownload(String day){
		
		LocalDate date = null;
		
		if(day.equals("today")) {
			date = LocalDate.now();
		}else if(day.equals("yesterday")){
			date = LocalDate.now().minusDays(1);
		}else if(day.equals("twoDaysAgo")){
			date = LocalDate.now().minusDays(2);
		}
		
		List<Map<String, String>> excelList = new ArrayList<Map<String,String>>();
				
		LocalDateTime localTime1 = date.atStartOfDay();
		LocalDateTime localTime2 = date.plusDays(1).atStartOfDay();
		
		Timestamp day1 = Timestamp.valueOf(localTime1);
		Timestamp day2 = Timestamp.valueOf(localTime2);
		
		List<UserLogin> userLoginList = userLoginRepository.findByTimeBetween(day1, day2);	
		
		for(int i=0; i<userLoginList.size(); i++) {
			Map<String, String> userLogin = new HashMap<String, String>();
			// 로그인 seq 넣기
			userLogin.put("id", userLoginList.get(i).getId()+"");
			// 회원 이름 넣기
			userLogin.put("name", userLoginList.get(i).getName());
			// 로그인 시간 넣기
			userLogin.put("time", userLoginList.get(i).getTime().toString());
			
			excelList.add(userLogin);
		}		
		
		return excelList;
	}
}
