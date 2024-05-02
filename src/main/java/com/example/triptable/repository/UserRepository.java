package com.example.triptable.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.triptable.entity.User;

//** 회원 REPOSITORY - 조민희 **//
public interface UserRepository extends JpaRepository<User, Integer> {

	public User findByMail(String mail);
	
	User findById(int id);
	
	@Query("SELECT u FROM User u WHERE u.name LIKE %:name% AND u.nickname != 'excepted User'")
	Page<User> findByNameContaining(String name, Pageable pageable);
	
	Page<User> findByNameContainingAndProvider(String name, String provider, Pageable pageable);
	
	List<User> findByProvider(String provider);	
}