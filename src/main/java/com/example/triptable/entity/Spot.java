package com.example.triptable.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
@Entity(name = "spot")
public class Spot {

   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "spot_id")
   private int id;

   @ManyToOne
   @JoinColumn(name = "team_id")
   private Team team;

   @Column(name = "trvl_day", nullable = false)
   private int day;

   @Column(name = "spot_name", nullable = false)
   private String name;

   @Column(name = "spot_lat", nullable = false)
   private String latitude;

   @Column(name = "spot_lon", nullable = false)
   private String longtitude;

   @Column(name = "spot_add")
   private String address;

   @Column(name = "spot_road")
   private String roadaddress;

   @Column(name = "spot_url")
   private String imgurl;

   @Column(name = "spot_category")
   private String category;

   @Column(name = "spot_phone")
   private String phone;

   @Column(name = "spot_start")
   private String spotStart;

   @Column(name = "spot_memo")
   private String spotMemo;

   @Column(name = "spot_order")
   private Integer spotOrder;

}
