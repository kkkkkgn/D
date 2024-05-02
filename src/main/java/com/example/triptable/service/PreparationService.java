package com.example.triptable.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Preparation;
import com.example.triptable.entity.Team;
import com.example.triptable.repository.PreparationRepository;
import com.example.triptable.repository.TeamRepository;

@Service
public class PreparationService {
	
	@Autowired
	private PreparationRepository preparationRepository;
	
	@Autowired
	private  TeamRepository teamRepository;
	
	/* 준비물 추가(수정완료) - 조민희 */
	public void addTodo(int team_id, Boolean checkboxState, String checklist) {

		Team team = teamRepository.findById(team_id);
		
		Preparation preparation = new Preparation();
		
		// 준비물 추가 시 처음에는 무조건 check가 안되어있는 상태
		preparation.setCheck(checkboxState);
		preparation.setName(checklist);
		preparation.setTeam(team);
			
		preparationRepository.save(preparation);
	}
	
	/* 준비물 로드(수정완료) - 조민희 */
	public JSONArray loadTodo(int team_id) {
		
		Team team = teamRepository.findById(team_id);
		
		// 팀을 기준으로 준비물 리스트 반환
		List<Preparation> todoList = preparationRepository.findByTeam(team);
		
		JSONArray todoArray = new JSONArray();
		
		// 팀의 준비물이 없는 상태면 null을 반환
		if(todoList.size() == 0) {
			
			return null;
		
		// 팀의 준비물이 있으면
		} else {
			
			// 팀의 준비물 갯수만큼 반복
			for(int i=0; i<todoList.size(); i++) {
				
				JSONObject todoObject = new JSONObject();
				
				todoObject.put("pre_id", todoList.get(i).getId());
				todoObject.put("pre_name", todoList.get(i).getName());
				todoObject.put("pre_check", todoList.get(i).isCheck());
				
				todoArray.add(todoObject);
			}
			
			return todoArray;
		}
	}
	
	/* 준비물 삭제 - 조민희 */
	public void deleteTodo(int pre_id) {
		
		preparationRepository.deleteById(pre_id);
		
	}
	
	/* 준비물 재저장 - 조민희 */
	public void resaveTodo(int pre_id, Boolean checkboxState, String checklist) {
		
		Preparation preparation = preparationRepository.findById(pre_id);
		
		// check 여부는 boolean임
		preparation.setCheck(checkboxState);
		preparation.setName(checklist);
		
		preparationRepository.save(preparation);
	}
}
