package com.example.triptable.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.triptable.entity.Preparation;
import com.example.triptable.entity.Team;

public interface PreparationRepository extends JpaRepository<Preparation, Integer>{

	List<Preparation> findByTeam(Team team);
	
	Preparation findById(int id);
}
