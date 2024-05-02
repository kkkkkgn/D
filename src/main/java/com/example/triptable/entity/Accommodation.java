package com.example.triptable.entity;

import java.sql.Timestamp;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity(name = "accommodation")
public class Accommodation {
	
	/* PK */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "acc_id")
	private int id;
	
	/* 일반 COLUMN / name = DB에 있는 컬럼 명을 작성 / nullable = true : null 허용, nullable = fasle : null 허용안함 */
	@Column(name = "acc_name", nullable = false)
	private String name;
	
	@Column(name = "acc_lat", nullable = false)
	private double latitude;
	
	@Column(name = "acc_lon", nullable = false)
	private double longitude;

	@Column(name = "acc_sum", nullable = true, columnDefinition = "VARCHAR(1000)")
	private String summary;
	
	@Column(name = "acc_cat", nullable = false)
	private String category;
	
	@Column(name = "acc_rooms", nullable = false)
	private int rooms;
	
	@Column(name = "acc_add", nullable = false)
	private String address;
	
	@Column(name = "acc_fee", nullable = false)
	private int fee;
	
	@Column(name= "acc_url", nullable = true)
	private String url;
	
	@Column(name= "acc_img", nullable = true)
	private String image;
	
	@CreationTimestamp
	@Column(name = "acc_date", nullable = false)
	private Timestamp date;
	
}
