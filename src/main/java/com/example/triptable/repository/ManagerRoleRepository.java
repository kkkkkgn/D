package com.example.triptable.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.triptable.entity.ManagerRole;

@Repository
public interface ManagerRoleRepository extends JpaRepository<ManagerRole, Integer>{
	
	ManagerRole findById(int id);
}
