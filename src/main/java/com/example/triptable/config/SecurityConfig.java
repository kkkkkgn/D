package com.example.triptable.config;

import jakarta.servlet.http.HttpSession;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.example.triptable.auth.PrincipalOauth2UserService;

import lombok.RequiredArgsConstructor;

//** URL 권한 확인, 로그인, 로그아웃, 로그인 관련 경로 설정하는 클래스 - 조민희 **//
@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

	// 로그인 실패했을 때 이유 확인을 위해서 여기서 객체 생성해서 사용 함
	// CustomAuthenticationFailureHandler customAuthenticationFailureHandler = new
	// CustomAuthenticationFailureHandler();

	@Autowired
	private PrincipalOauth2UserService principalOauth2UserService;

	/* 회원, 관리자 비밀번호 암호화를 위해서 Bean으로 등록 */
	@Bean
	public BCryptPasswordEncoder encodePwd() {
		return new BCryptPasswordEncoder();
	}

	/* 로그인, 로그아웃, URL 권한 설정 */
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		// CSRF 보안 기능 해제
		http.csrf(AbstractHttpConfigurer::disable);

		// (user/**) -> USER이라는 권한을 가진 사용자만 접근 가능 / (manager/**) -> MANAGER라는 권한을 가진
		// 사용자만 접근 가능
		http.authorizeHttpRequests(authorize -> authorize
				.requestMatchers("/user/**").hasRole("USER")
				// 관리자만 접근가능한 URL
				.requestMatchers("/manager/**").hasAnyRole("SUPER", "OPERATOR")
				.anyRequest().permitAll())
			.exceptionHandling()
		    .accessDeniedHandler((request, response, accessDeniedException) -> {
		        // AccessDeniedException 처리
		        response.sendRedirect("/loginForm.do?error=accessDenied");
		    });

		// 관리자 일반로그인 (로그인 폼 페이지 ("/loginForm.do") / 로그인 실행되는 페이지 ("/mlogin") / 로그인 성공 시
		// ("/manager/muser-info.do"))
		http.formLogin(login -> login
				.loginPage("/loginForm.do")
				.loginProcessingUrl("/mlogin")
				.defaultSuccessUrl("/manager/dashboard.do")
				.failureHandler((request, response, exception) -> {
				    String errorMessage;
				    if (exception instanceof BadCredentialsException) {
				        errorMessage = "Invalid username or password";
				    } else {
				        // 그 외의 실패 처리
				    	errorMessage = "Invalid username or password";		        
				    }
				    response.sendRedirect("/loginForm.do?error=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
				}));
		
		http.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl("/index.do")
			.invalidateHttpSession(true)
			.permitAll();

		// 회원 소셜 로그인 (로그인 폼 페이지 ("/loginForm.do") / 로그인 성공 시 ("index.do") / 로그인 요청이 들어왔을
		// 때 실행되는 서비스 (principalOauth2UserService))
		http.oauth2Login(login -> login
				.loginPage("/loginForm.do")
				.defaultSuccessUrl("/index.do")
				.userInfoEndpoint()
				.userService(principalOauth2UserService));

		// 회원, 관리자 로그아웃 (addLogoutHandler (세션 초기화) / logoutSuccessHandler (로그아웃이 성공했을때
		// 로그인 폼 페이지로 이동))
		http.logout(logout -> logout
				.addLogoutHandler((request, response, authentication) -> {
					HttpSession session = request.getSession();
					if (session != null) {
						session.invalidate();
					}
				})
				.logoutSuccessHandler((request, response, authentication) -> {
					response.sendRedirect("/loginForm.do");
				})
				.deleteCookies("remember-me"));

		return http.build();
	}

}