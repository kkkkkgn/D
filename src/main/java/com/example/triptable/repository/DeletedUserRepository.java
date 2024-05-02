package com.example.triptable.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.triptable.entity.DeletedUser;

@Repository
public interface DeletedUserRepository extends JpaRepository<DeletedUser, Integer> {
		
	Page<DeletedUser> findByNameContaining(String name, Pageable pageable);
	
	Page<DeletedUser> findByNameContainingAndReasonContaining(String name, String reason, Pageable pageable);
}