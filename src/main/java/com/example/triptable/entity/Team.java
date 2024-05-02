package com.example.triptable.entity;

import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@ToString 
@Getter
@Setter
@Entity(name = "team")
public class Team {

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "team_id")
   private int id;
   
   @Column(name = "team_name", nullable = false)
   private String name;

   @Column(name = "trvl_dest", nullable = false)
   private String destination;

   @Column(name = "trvl_start", nullable = false)
   private String travlestart;

   @Column(name = "trvl_end", nullable = false)
   private String travleend;

   @CreationTimestamp
   @Column(name = "team_date", nullable = false)
   private Timestamp date;

   @UpdateTimestamp
   @Column(name = "last_update", nullable = false)
   private Timestamp lastupdate;

   @Column(columnDefinition = "JSON")
   private String userdata;
   
   @Column(name = "team_url", nullable = false)
   private String url;
}