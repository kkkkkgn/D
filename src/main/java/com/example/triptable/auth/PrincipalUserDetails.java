package com.example.triptable.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.example.triptable.entity.User;

import lombok.Data;

//** PrincipalUserDetails의 반환 클래스 - 조민희 **//
@Data
public class PrincipalUserDetails implements OAuth2User {

	private User user;

	private Map<String, Object> attributes;

	/* 회원 소셜 로그인 생성자 */
	public PrincipalUserDetails(User user, Map<String, Object> attributes) {
		this.user = user;
		this.attributes = attributes;
	}

	/* 회원 정보를 반환 */
	@Override
	public Map<String, Object> getAttributes() {

		return attributes;
	}

	/* 회원의 권한을 반환 / 사실 user.getRole() 대신에 "ROLE_USER" 반환 해도 됨 */
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collect = new ArrayList<GrantedAuthority>();
		collect.add(new GrantedAuthority() {

			@Override
			public String getAuthority() {
				return user.getRole();
			}
		});
		return collect;
	}

	/* 회원 이름 반환 */
	@Override
	public String getName() {
		return user.getName();
	}

	/* 회원 반환 (indexController에서 사용) */
	public User getUser() {
		return user;
	}

}
