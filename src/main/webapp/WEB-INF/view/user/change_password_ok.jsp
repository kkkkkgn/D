<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="com.example.triptable.entity.User" %>
<%
	int flag = (Integer)session.getAttribute( "flag" );
	
	out.println( "<script type='text/javascript'>" );
	if(flag == 0) {
		out.println( "alert('비밀번호 수정 성공');" );
		out.println( "location.href='./profile_set.do';" );
	} else if(flag == 1) {
		out.println( "alert('변경할 비밀번호가 서로 다릅니다.');" );
		out.println( "history.back();" );
	} else if(flag == 2) {
		out.println("alert('기존 비밀번호와 다른 비밀번호를 입력 해주세요.')");
		out.println("history.back();");
	} else {
		out.println( "alert('사이트 에러');" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>