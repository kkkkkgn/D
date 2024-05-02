package com.example.triptable.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

//** 관리자 권한 ENTITIY 클래스 - 조민희 **/
@Entity
@Data
@NoArgsConstructor
public class ManagerRole {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "role_code")
	private int rolecode;

	@Column(name = "role_name")
	private String rolename;
}