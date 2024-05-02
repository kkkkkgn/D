package com.example.triptable.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.triptable.entity.Accommodation;

@Repository
public interface AccommodationRepository extends JpaRepository<Accommodation, Integer> {

	Page<Accommodation> findByAddressContaining(String address, Pageable pageable);
	
	List<Accommodation> findByAddressContaining(String address);
	
	List<Accommodation> findByNameContaining(String name);
	
	List<Accommodation> findByNameContainingAndAddressContaining(String name, String sido);
	
	Accommodation findById(int id);
	
}