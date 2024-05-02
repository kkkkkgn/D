package com.example.triptable.service;

import jakarta.transaction.Transactional;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.CourseRecommendation;
import com.example.triptable.entity.DeletedUser;
import com.example.triptable.entity.RefundStatus;
import com.example.triptable.entity.Reservation;
import com.example.triptable.entity.User;
import com.example.triptable.repository.CourseRecommendationRepository;
import com.example.triptable.repository.DeletedUserRepository;
import com.example.triptable.repository.ReservationRepository;
import com.example.triptable.repository.UserRepository;

//** USER SERVICE 클래스 - 조민희 **//
@Service
@Transactional
public class UserService {

   @Autowired
   private UserRepository userRepository;

   @Autowired
   private CourseRecommendationRepository courseRecommendationRepository;

   @Autowired
   private BCryptPasswordEncoder bcripBCryptPasswordEncoder;
   
   @Autowired
   private DeletedUserRepository deletedUserRepository;

   @Autowired
   private ReservationRepository reservationRepository;

   /* 회원 닉네임 수정 */
   public int updateUser(User user, String password) {

      int flag = 1;
      bcripBCryptPasswordEncoder = new BCryptPasswordEncoder();

      // 비밀번호 일치 확인 메서드
      if (bcripBCryptPasswordEncoder.matches(password, user.getPassword())) {
         flag = 0;
      }
      return flag;
   }

   /* 비밀번호 변경 */
   public int changePassword(User user, String originPassword, String changePassword, String checkChangePassword) {

      int flag = 1;
      bcripBCryptPasswordEncoder = new BCryptPasswordEncoder();

      // 비밀번호가 기존 비밀번호와 일치하는지 확인
      if (bcripBCryptPasswordEncoder.matches(originPassword, user.getPassword())) {
         // 변경할 비밀번호가 변경할 비밀번호와 일치하는지 확인
    	 if (originPassword.equals(changePassword)) {
    		flag = 2;
    	 } else if (changePassword.equals(checkChangePassword)) {
            flag = 0;
         }
      }
      return flag;
   }
   
   /* 회원탈퇴 메서드 - 탈회 테이블에 관리 */
   public int deleteUser(User user, String reason) {
      int flag = 0;
	   
	   
      String name = user.getName();
      String mail = user.getMail();
      // 회원가입시 null값 처리됨
      
      DeletedUser dUser = new DeletedUser();
      dUser.setName(name);
      dUser.setMail(mail);
      dUser.setReason(reason);
      
      List<Reservation> rsList = reservationRepository.findAllByUser(user);
      if(rsList != null) {
    	  
    	  for(Reservation rs : rsList) {
    		  RefundStatus rsStatus = rs.getRefundStatus();
    		  if( rsStatus==RefundStatus.BEFORE_USE || rsStatus ==RefundStatus.CANCELING) {
    			  
    			  flag = 1;
    			  return flag;
    		  } 
    	  }
    		  
      }
      
      user.setName("탈퇴 회원");
      user.setNickname("excepted User");
      user.setGroupdata(null);
      user.setMail(null);
      user.setPassword(null);
      user.setFavorite(null);
      user.setProvider(null);
      user.setRole(null);
      user.setDate(null);
      
      userRepository.save(user);
      deletedUserRepository.save(dUser);
      
      return flag;
   }

   /* 즐겨찾기 저장 */
   public String updateFavorite(User user, String courseId) {

      String strExistData = user.getFavorite();

      JSONArray jsonArray = new JSONArray();
      JSONObject jsonObject = new JSONObject();

      JSONParser parser = new JSONParser();

      try {
         if (strExistData == null) {
            jsonObject.put("id", courseId);
            jsonArray.add(jsonObject);
         } else {
            jsonArray = (JSONArray) parser.parse(strExistData);
            jsonObject.put("id", courseId);
            jsonArray.add(jsonObject);
         }

         // 사용자의 favorite 값을 업데이트하고 저장
         user.setFavorite(jsonArray.toJSONString());
         userRepository.save(user);

      } catch (ParseException e) {
         e.printStackTrace();
      }

      return jsonArray.toJSONString();

   }

   /* 즐겨찾기 삭제 */
   public String deleteFavorite(User user, String courseId) {
      String strExistData = user.getFavorite();

      if (strExistData == null || strExistData.isEmpty()) {
         // 사용자의 favorite 값이 null일 경우 처리

         return "";
      }

      JSONArray jsonArray = new JSONArray();
      JSONParser parser = new JSONParser();

      try {
         jsonArray = (JSONArray) parser.parse(strExistData);

         // id가 null인 경우에 대한 예외 처리 및 객체 삭제
         for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject jsonObject = (JSONObject) jsonArray.get(i);

            Object courseIdObj = jsonObject.get("id");
            if (courseIdObj != null) {
               String id = courseIdObj.toString();
               if (id.equals(courseId)) {
                  // 해당 객체 삭제
                  jsonArray.remove(i);
                  break;
               }
            }
         }
      } catch (ParseException e) {
         e.printStackTrace();
      }
      // 사용자의 favorite 값을 업데이트하고 저장
      user.setFavorite(jsonArray.toJSONString());
      userRepository.save(user);

      return jsonArray.toJSONString();
   }
   
   /* 마이페이지에 즐겨찾기 데이터 가져오기 */
   public Page<CourseRecommendation> loadFavorite(User user, String keyword, Pageable pageable) {
      JSONParser parser = new JSONParser();

      //JSON형식의 즐겨찾기 내용을 String으로 가져옴
      String strExistUserCourse = user.getFavorite();
      JSONArray existUserCourse = null;
      
      //JSONArray에서 courseid 추출하여 리스트에 저장
      List<Integer> lists = new ArrayList<>();
      try {
         //String 내용을 JSONArray로 파싱
         existUserCourse = (JSONArray) parser.parse(strExistUserCourse);

         //파싱한 내용을 Array로 여기자
         for (int i = 0; i < existUserCourse.size(); i++) {
            JSONObject courseObject = (JSONObject) existUserCourse.get(i);
            int courseId = Integer.parseInt(courseObject.get("id").toString());

            lists.add(courseId);
         }
   
         System.out.println(lists);
      }catch (Exception e) {
      }
      
       return courseRecommendationRepository.findByCoursedestContainingAndIdInOrCoursenameContainingAndIdIn(keyword, lists, keyword, lists, pageable);
      
   }
   
   public User addContentToGroupData(User user, JSONArray arrGroupdata) {
	   
	   user.setGroupdata(arrGroupdata.toJSONString());
	   
	   return userRepository.save(user);
   }

}