package com.example.triptable.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import com.example.triptable.entity.Region;

//** 행정구역 REPOSITORY - 박수진 **//
public interface RegionRepository extends JpaRepository<Region, Integer> {
	
	/* 도/시 출력 메서드(중복값 제거) */
	@Query("SELECT DISTINCT r.dosi FROM region r")
	public List<String> findDistinctDosi();
	
	/* 도/시 별로 시/군 출력 메서드 */
	public List<Region> findAllByDosi(String dosi);
	
	public Region findByDosi(String dosi);
}

