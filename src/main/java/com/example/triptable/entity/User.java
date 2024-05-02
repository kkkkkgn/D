package com.example.triptable.entity;

import java.sql.Timestamp;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//** 회원 ENTITY 클래스 - 조민희 **//
@Entity
@Data
@NoArgsConstructor
public class User {

	/* PK */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id")
	private int id;

	@Column(name = "user_name")
	private String name;

	@Column(name = "user_mail")
	private String mail;

	@Column(name = "user_password")
	private String password;

	@Column(name = "user_nick")
	private String nickname;

	@Column(name = "user_provide")
	private String provider;

	@Column(name = "user_role")
	private String role;

	@Column(columnDefinition = "JSON")
	private String groupdata;

	@CreationTimestamp
	@Column(name = "join_date")
	private Timestamp date;

	@Column(name = "user_icon")
	@NotNull
	private String icon;

	@Column(name = "user_fav", columnDefinition = "JSON")
	private String favorite;

	/* 소셜 로그인할 때 사용 됨 */
	@Builder
	public User(int id, String name, String icon, String mail, String password, String nickname, String provider,
			String role, Timestamp date) {
		this.id = id;
		this.name = name;
		this.icon = icon;
		this.mail = mail;
		this.password = password;
		this.nickname = nickname;
		this.provider = provider;
		this.role = role;
		this.date = date;

	}

}