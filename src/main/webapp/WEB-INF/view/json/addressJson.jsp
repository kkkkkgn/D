<%@page import="java.util.List"%>
<%@page import="net.minidev.json.JSONObject"%>
<%@page import="net.minidev.json.JSONArray"%>
<%@page import="com.example.triptable.entity.Region"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

<%
	List<Region> datas = (List)request.getAttribute( "datas" );
	// 도,시 별 출력정보 JSON배열
	JSONArray jsonArray = new JSONArray();
	for( Region region : datas ) {
		int id = region.getId();
		String dosi = region.getDosi();
		
		JSONObject obj = new JSONObject();
		obj.put( "id", id );
		obj.put( "dosi", dosi );
		
		jsonArray.add( obj );
	}
%>