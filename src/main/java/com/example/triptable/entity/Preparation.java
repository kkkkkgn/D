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
@Entity(name = "preparation")
public class Preparation {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "pre_id")
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "team_id")
	private Team team;
	
	@Column(name = "pre_name", nullable = false)
	private String name;
	
	@Column(name = "pre_check", nullable = false)
	private boolean check;
	
}
