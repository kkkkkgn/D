<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute( "flag" );
	
	out.println( "<script type='text/javascript'>" );
	if(flag == 0) {
		out.println( "alert('정상적으로 탈퇴되었습니다!');" );
		out.println( "location.href = 'index.do';" );
	} else if(flag == 1) {
		out.println( "alert('예약된 숙소가 있거나 취소중인 내역이 있다면 탈퇴하실 수 없습니다.');" );
		out.println( "history.back();" );
	} else {
		out.println( "alert('사이트 에러');" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>
