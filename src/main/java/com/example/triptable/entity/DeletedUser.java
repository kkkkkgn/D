package com.example.triptable.entity;

import java.sql.Timestamp;



import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@ToString
@Getter
@Setter
@Entity(name = "deleted_user")
public class DeletedUser {
	/* PK */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "duser_id")
	private int id;

	@Column(name = "duser_mail", nullable = false)
	private String mail;

	@Column(name = "duser_name", nullable = false)
	private String name;


	@CreationTimestamp
	@Column(name = "d_date", nullable = false)
	private Timestamp date;

	@Column(name = "d_reason", nullable = false)
	private String reason;
}
