package com.example.triptable.repository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.triptable.entity.UserLogin;

//** 회원 REPOSITORY - 조민희 **//
public interface UserLoginRepository extends JpaRepository<UserLogin, Integer> {
	
	List<UserLogin> findByTimeBetween(Timestamp startTime, Timestamp endTime);
		
}