package com.example.triptable.entity;

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
@Entity(name = "region")
public class Region {
   
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "reg_id")
   private int id;
   
   @Column(name = "reg_dosi", nullable = false)
   private String dosi;
   private int hit;

}
