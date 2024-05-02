<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.example.triptable.entity.User" %>
<%
	int flag = (Integer)session.getAttribute( "flag" );
	
	out.println( "<script type='text/javascript'>" );
	if(flag == 0) {
		out.println( "alert('정보 수정 성공');" );
		out.println( "location.href='./profile_set.do';" );
	} else if(flag == 1) {
		out.println( "alert('비밀번호 오류');" );
		out.println( "history.back();" );
	} else {
		out.println( "alert('사이트 에러');" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>