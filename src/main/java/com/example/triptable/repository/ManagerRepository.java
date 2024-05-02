package com.example.triptable.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.triptable.entity.Manager;



//** 매니저 REPOSITORY - 조민희 **//
public interface ManagerRepository extends JpaRepository<Manager, Integer>{

	/* 관리자 회원가입에서 사용 */
	public Manager findByMail(String mail);
	
	Page<Manager> findByNameContaining(String name, Pageable pageable);
	
	Page<Manager> findByNameContainingAndManagerRole_rolename(String name, String roleName, Pageable pageable);
	
	Manager findById(int id);
}
