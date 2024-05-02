package com.example.triptable.config;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

//** 로그인이 실패했을 때 이유를 알려주는 클래스 - 조민희 / 지금 안쓰긴 한데 나중에 로그인 안될때를 대비해서 없애지 않는게 좋을 것 같음 **//
@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    private static final Logger logger = LoggerFactory.getLogger(CustomAuthenticationFailureHandler.class);

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {

        // 실패한 요청의 IP 주소
        String ipAddress = request.getRemoteAddr();
        // 실패한 사용자의 ID 또는 이메일
        String username = request.getParameter("username");

        // 실패한 이유
        String errorMessage = exception.getMessage();
        // 실패한 로그인 시도를 로그에 기록
        logger.error("Login failed for user: " + username + " from IP: " + ipAddress + ". Reason: " + errorMessage);

                // 실패한 사용자에게 적절한 메시지 전달
                request.getSession().setAttribute("error-message", "로그인에 실패했습니다. 다시 시도해주세요.");

                // 로그인 페이지로 리다이렉트 또는 특정 URL로 리다이렉트 가능
                response.sendRedirect("/loginForm?error");
        }
}
