package com.example.triptable.auth;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.example.triptable.entity.Manager;
import com.example.triptable.entity.ManagerRole;

import lombok.Data;

//** PrincipalManagerDetails의 반환 클래스 - 조민희 **//
@Data
public class PrincipalManagerDetails implements UserDetails {

   private Manager manager;

   /* 관리자 일반 로그인 생성자 */
   public PrincipalManagerDetails(Manager manager) {
      this.manager = manager;
   }

   /* DB에 저장되어 있는 관리자의 권한을 반환하는 오버라이드 메서드 */
   @Override
   public Collection<? extends GrantedAuthority> getAuthorities() {
      Collection<GrantedAuthority> collect = new ArrayList<GrantedAuthority>();
      collect.add(new GrantedAuthority() {

         @Override
         public String getAuthority() {
            ManagerRole managerRole = new ManagerRole();
            managerRole = manager.getManagerRole();
            return managerRole.getRolename();
         }
      });
      return collect;
   }

   /* 관리자 비밀번호 반환 */
   @Override
   public String getPassword() {
      return manager.getPassword();
   }

   /* 관리자 비밀번호 반환 */
   @Override
   public String getUsername() {
      return manager.getMail();
   }

   /* 계정이 만료되었는지 반환 (TRUE - 계정 만료 안됨) */
   @Override
   public boolean isAccountNonExpired() {
      return true;
   }

   /* 계정이 잠겼는지 반환 (TRUE - 계정 안잠김) */
   @Override
   public boolean isAccountNonLocked() {
      return true;
   }

   /* 자격증명 만료여부 반환 (TRUE - 만료 안됨) ex.비밀번호 만료.. */
   @Override
   public boolean isCredentialsNonExpired() {
      return true;
   }

   /* 계정이 활성화되었는지 여부 반환 (TRUE - 활성화) */
   @Override
   public boolean isEnabled() {
      return true;
   }

   public Manager getManager() {
      return manager;
   }

}
