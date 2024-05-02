package com.example.triptable.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Manager;
import com.example.triptable.repository.ManagerRepository;

//** 로그인 요청이 들어왔을 때 실행되는 클래스 - 조민희 **//
@Service
public class PrincipalManagerDetailService implements UserDetailsService {

   @Autowired
   private ManagerRepository managerRepository;

   /*
    * 관리자 로그인을 할 때 입력하는 메일을 기준으로 DB에서 관리자를 찾은 뒤 NULL이 아니면 DB의 관리자 정보를 담은
    * PrincipalManagerDetails를 반환
    */
   @Override
   public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
      Manager managerEntity = managerRepository.findByMail(username);
      if (managerEntity != null) {

         return new PrincipalManagerDetails(managerEntity);
      }
      return null;
   }

   /* 관리자의 인증 정보 반환 */
   public Authentication getCurrentManagerInfo() {
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

      if (authentication != null || authentication.isAuthenticated()) {
         return authentication;
      }
      return null;
   }

}