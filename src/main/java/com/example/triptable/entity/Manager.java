package com.example.triptable.entity;

import java.sql.Timestamp;


import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;
import lombok.NoArgsConstructor;

//** 관리자 ENTITIY 클래스 - 조민희 **/
@Entity
@Data
@NoArgsConstructor
public class Manager {

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "mgr_id")
   private int id;

   /* ManagerRole 테이블의 - FK */
   @ManyToOne(fetch = FetchType.EAGER)
   @JoinColumn(name = "role_code")
   private ManagerRole managerRole;

   @Column(name = "mgr_mail")
   private String mail;

   @Column(name = "mgr_password")
   private String password;

   @Column(name = "mgr_name")
   private String name;

   @Column(name = "mgr_tel")
   private String tel;

   @Column(name = "mgr_last_login")
   private Timestamp lastlogin;

   @CreationTimestamp
   @Column(name = "mgr_join_date")
   private Timestamp join_date;
}