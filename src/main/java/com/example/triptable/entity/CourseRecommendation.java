package com.example.triptable.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

//** COURSE_RECOMMENDATION 테이블 ENTITY - 손수빈 **//
@Data
@NoArgsConstructor
@Entity(name = "course_recommendation")
public class CourseRecommendation {

	/* PK */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "c_id")
	private int id;

	/*
	 * 일반 COLUMN / name = DB에 있는 컬럼 명을 작성 / nullable = true : null 허용 = null ,
	 * nullable = fasle : null 허용안함 = not null
	 */
	@Column(name = "c_dest", nullable = false)
	private String coursedest;

	@Column(name = "c_name")
	private String coursename;

	@Column(name = "c_sum", columnDefinition = "TEXT")
	private String coursesum;

	@Column(name = "c_img")
	private String courseimage;
	 
	@Column(name = "c_manager", nullable = false)
	private String coursemanager;

	@Column(name = "c_dis")
	private String coursedis;

	@Column(name = "c_dur")
	private String coursedur;

	@Column(name = "c_detail", columnDefinition = "TEXT")
	private String coursedetail;

	@Column(name = "c_hit")
	private int hit;
	
	@Column(name = "c_approve") // 관리자 승인 
	private boolean approve;
	
	@CreationTimestamp
	@Column(name = "c_date", nullable = false)
	private Timestamp date;
	
	public CourseRecommendation(int id, String courseimage, String coursename, String coursedest, int hit) {
        this.id = id;
        this.courseimage = courseimage;
        this.coursename = coursename;
        this.coursedest = coursedest;
        this.hit = hit;
    }
}