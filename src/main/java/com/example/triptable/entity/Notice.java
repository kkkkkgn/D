package com.example.triptable.entity;
import java.sql.Timestamp;

import org.hibernate.annotations.CreationTimestamp;
import org.json.simple.JSONArray;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Entity(name="notice")
public class Notice {

   /*PK*/
   /** 공지사항 테이블 **/
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name="n_id")
   private int id;

   @Column(name = "n_name", nullable = false)
   private String name;
   
   @Column(name="n_content", columnDefinition = "varchar(2000)", nullable = false)
   private String content;
   
   @Column(name = "n_manager", nullable = false)
   private String manager;
   
   @Column(name="n_file", nullable=true, columnDefinition = "TEXT")
   private String file;
   
   @CreationTimestamp
   @Column(name = "n_date", nullable = false)
   private Timestamp date;
   
   //공지사항 insert할 때 hit값 0으로 넣기 (default값 설정이 안되기 때문)
   @Column(name="hit")
   private int hit = 0;
   
   // 공지사항 기간 시작
   @Column(name="n_start")
   private String noticestart;
   
   // 공지사항 기간 끝
   @Column(name="n_end")
   private String noticeend;
   
   // 긴급 여부
   @Column(name="n_category")
   private String category;
   
   // 공지사항 활성화 상태
   @Column(name="n_state")
   private Boolean state = false;
   
}