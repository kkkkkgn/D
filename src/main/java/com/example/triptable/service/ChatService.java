package com.example.triptable.service;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Service;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@Service
@ServerEndpoint(value="/chatt")
public class ChatService {
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

	//login버튼 눌렀을 때 session이 오픈되면서 
	@OnOpen
	public void onOpen(Session s) {
		System.out.println("open session : " + s.toString());
		// 세션에 유저가 없을때
		if(!clients.contains(s)) {
			
			clients.add(s);
			System.out.println("session open : " + s.toString());
		// 세션에 이미 유저가 있을때
		} else {
			System.out.println("이미 연결된 세션 입니다.");
		}
	}
	
	
	@OnMessage
	public void onMessage(String msg, Session session) throws Exception {
		System.out.println("receive message : " + msg);
		// 모든 세션에 메시지 전송
		for(Session s : clients) {
			System.out.println("send data : " + msg);
			s.getBasicRemote().sendText(msg);
		}
	}
	
	//창 닫을 때 세션 닫힘
	@OnClose
	public void onClose(Session s) {
		System.out.println("session close : " + s);
		clients.remove(s);
	}
	
	
	
	
	
	
	
	
	
}
