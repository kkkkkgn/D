package com.example.triptable.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Finance;
import com.example.triptable.entity.Team;
import com.example.triptable.repository.FinanceRepository;
import com.example.triptable.repository.TeamRepository;

@Service
public class FinanceService {

   @Autowired
   private FinanceRepository financeRepository;

	@Autowired
	private TeamRepository teamRepository;
	/* 가계부 리스트 반환 - 조민희 */
	public JSONArray getFinanceList(int team_id) {

		// 세션에 저장되어 있는 팀의 값을 기준으로 가계부 리스트 반환
		Team team = teamRepository.findById(team_id);
		
		List<Finance> lists = financeRepository.findByTeam(team);

      JSONArray financeArray = new JSONArray();

      // 가계부 리스트의 사이즈만큼
      for (int i = 0; i < lists.size(); i++) {

         JSONObject financeObject = new JSONObject();

         // 가계부 리스트 i번째의 값을 가계부 객체에 저장 
         Finance finance = lists.get(i);
         int id = finance.getId();
         String day = finance.getDay()+"";
         int expense = finance.getExpense();
         String detail = finance.getDetail();

         financeObject.put("id", id);
         financeObject.put("day", day);
         financeObject.put("expense", expense);
         financeObject.put("detail", detail);

         financeArray.add(financeObject);

      }

      return financeArray;
   }

	/* 가계부 목록 추가(수정완료) - 조민희 */
	public void insertFinance(int trvl_day, String fin_detail, int fin_exp, int team_id) {

		Finance finance = new Finance();
		Team team = teamRepository.findById(team_id);
		
		// AJAX를 통해 파라미터로 받은 값을 가계부 객체에 저장
		finance.setDay(trvl_day);
		finance.setDetail(fin_detail);
		finance.setExpense(fin_exp);
		finance.setTeam(team);

      financeRepository.save(finance);

   }

   /* 가계부 목록 삭제 - 조민희 */
   public void deleteFinance(int fin_id) {
      
      // 가계부 ID를 기준으로 목록 삭제
      financeRepository.deleteById(fin_id);
   }
   
   public void resaveFinance(String detail, int expense, int fin_id) {
	   
	   Finance finance = financeRepository.findById(fin_id);
	   finance.setDetail(detail);
	   finance.setExpense(expense);
	   
	   financeRepository.save(finance);
   }
}