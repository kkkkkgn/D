package com.example.triptable.auth;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.User;
import com.example.triptable.entity.UserLogin;
import com.example.triptable.repository.UserLoginRepository;
import com.example.triptable.repository.UserRepository;
import com.example.triptable.userinfo.GoogleUserInfo;
import com.example.triptable.userinfo.KakaoUserInfo;
import com.example.triptable.userinfo.OAuth2UserInfo;

import lombok.extern.slf4j.Slf4j;

//** 로그인 요청이 들어왔을 때 실행되는 클래스 - 조민희 **//
@Service
@Slf4j
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {

	/*
	 * SecurityConfig랑 순환참조오류가 나서 @Lazy 사용함 /
	 * springframework.context.annotation.Lazy 여야 함, 다른거 import하면 안 됨
	 */
	@Autowired
	@Lazy
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserLoginRepository userLoginRepository;

	/* 로그인 정보를 받아서 처음 로그인이면 DB에 저장하는 메서드 */
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		OAuth2User oAuth2User = super.loadUser(userRequest);
		log.info("getAttributes : {}", oAuth2User.getAttributes());

		OAuth2UserInfo oAuth2UserInfo = null;

		// provider 정보를 받아서
		String provider = userRequest.getClientRegistration().getRegistrationId();

		// provider에 따라 GoogleUserInfo, KakaoUserInfo 클래스의 객체를 저장
		if (provider.equals("google")) {
			log.info("구글 로그인 요청");
			oAuth2UserInfo = new GoogleUserInfo(oAuth2User.getAttributes());
		} else if (provider.equals("kakao")) {
			log.info("카카오 로그인 요청");
			oAuth2UserInfo = new KakaoUserInfo((Map) oAuth2User.getAttributes());
		}

		String mail = oAuth2UserInfo.getEmail();
		String nickname = provider + "_" + System.currentTimeMillis();
		String name = oAuth2UserInfo.getName();

		User userEntity = userRepository.findByMail(mail);

		// USER 생성
		if (userEntity == null) {
			userEntity = User.builder()
					.mail(mail)
					.icon("icon01")
					.password("기본비밀번호")
					.name(name)
					.nickname(nickname)
					.role("ROLE_USER")
					.provider(provider)
					.build();

			userRepository.save(userEntity);
			
			
		}
		
		// 로그인 시간 저장 테이블
		UserLogin userLogin = new UserLogin();
		userLogin.setName(name);
		userLoginRepository.save(userLogin);

		return new PrincipalUserDetails(userEntity, oAuth2User.getAttributes());
	}

	/* SecurityContextHolder에서 인증된 사용자 정보를 불러오는 메서드 */
	public Authentication getCurrentUserInfo() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.isAuthenticated()) {
			return authentication;
		}
		return null;
	}

}