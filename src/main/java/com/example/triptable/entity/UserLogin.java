package com.example.triptable.entity;

import java.sql.Timestamp;


import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

//** 회원 로그인 ENTITY 클래스 - 조민희 **//
@Entity
@Data
@NoArgsConstructor
public class UserLogin {

	/* PK */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "login_id")
	private int id;

	@Column(name = "user_name")
	private String name;

	@CreationTimestamp
	@Column(name = "login_time")
	private Timestamp time;

}