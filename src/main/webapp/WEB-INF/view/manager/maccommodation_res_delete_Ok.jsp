<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");

	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert( '예약이 취소 되었습니다.' );" );
		out.println( "location.href='/manager/accRes.do';" );
	} else if( flag == 1 ) {
		out.println( "alert( '오류입니다. 주문번호나 사용자명을 다시 확인해주세요.' );" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>