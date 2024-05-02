package com.example.triptable.valueobject;

import com.example.triptable.entity.Accommodation;
import com.example.triptable.entity.Reservation;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class KakaoPayReadyVO {

	private String tid; // 결제 번호
	private String next_redirect_pc_url; // 결제 완료시 이동할 페이지
	private String partner_order_id; // 주문한 사람 ID
	
	private Reservation reservation;
}