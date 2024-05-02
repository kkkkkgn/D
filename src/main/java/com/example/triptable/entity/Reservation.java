package com.example.triptable.entity;

import java.sql.Timestamp;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "reservation")
public class Reservation {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "res_id")
	private int id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToOne
	@JoinColumn(name = "acc_id")
	private Accommodation accommodation;

	@Column(name = "res_guests", nullable = false)
	private String guests;

	@Column(name = "res_start", nullable = false)
	private String resstart;

	@Column(name = "res_end", nullable = false)
	private String resend;

	@Column(name = "res_fee", nullable = false)
	private String fee;

	@CreationTimestamp
	@Column(name = "res_date", nullable = false)
	private Timestamp date;

	@Column(name = "order_number")
	private long orderNumber;
	
	@Column(name = "res_tid")
	private String tid;
	
	@Column(name = "refund_status", nullable = false)
	@Enumerated(EnumType.STRING)
	private RefundStatus refundStatus = RefundStatus.BEFORE_USE;  // 기본 값 설정
	
}
