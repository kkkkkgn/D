<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");

	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert( '예약이 취소 되었습니다.' );" );
		out.println( "location.href='/user/res_status.do';" );
	} else if( flag == 2 ) {
		out.println( "alert( '이미 사용 되었거나 취소된 내역입니다. 다시 확인해주세요.' );" );
		out.println( "history.back();" );
	} else if( flag == 1 ) {
		out.println( "alert( '오류입니다. 주문번호를 다시 확인해주세요.' );" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%>