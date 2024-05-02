package com.example.triptable.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

//** 결제로그 ENTITY 클래스 - 조민희 **//
//** 결제로그 ENTITY 클래스 - 조민희 **//
@Entity
@Data
@NoArgsConstructor
public class PayLog {

	/* PK */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "log_id")
	private long id;

	@Column(name = "log_data", columnDefinition = "LONGTEXT")
	private String logData;
}
