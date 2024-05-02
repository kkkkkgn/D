package com.example.triptable.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@ToString
@Getter
@Setter
@Entity(name = "finance")
public class Finance {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "fin_id")
	private int id;

	@ManyToOne
	@JoinColumn(name = "team_id")
	private Team team;

	@Column(name = "trvl_day", nullable = false)
	private int day;

	@Column(name = "fin_exp", nullable = true)
	private int expense;

	@Column(name = "fin_detail", nullable = true)
	private String detail;

}
