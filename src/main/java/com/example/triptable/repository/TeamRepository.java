package com.example.triptable.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.triptable.entity.Team;

import java.util.List;


public interface TeamRepository extends JpaRepository<Team, Integer>{
	
	public List<Team> findAllById(int userId);

	public Team findById(int id);
	
	public Team findByUrl(String url);
	
	@Query(value = "SELECT a.trvl_dest, a.dest_count, b.acc_count, d.c_count AS c_count FROM (SELECT trvl_dest, COUNT(*) AS dest_count FROM team GROUP BY trvl_dest) a LEFT JOIN (SELECT SUBSTRING_INDEX(acc_add, ' ', 1) AS acc_dest, COUNT(*) AS acc_count FROM accommodation WHERE SUBSTRING_INDEX(acc_add, ' ', 1) IN (SELECT DISTINCT SUBSTRING_INDEX(acc_add, ' ', 1) AS distinct_dest FROM accommodation) GROUP BY acc_dest) b ON a.trvl_dest = b.acc_dest LEFT JOIN (SELECT c_dest, COUNT(*) AS c_count FROM course_recommendation GROUP BY c_dest) d ON a.trvl_dest LIKE CONCAT(d.c_dest, '%') ORDER BY dest_count DESC;", nativeQuery = true)
	List<Object[]> findRankTravelDestinations(); 
	
	@Query(value="select trvl_dest, count(*) from team group by trvl_dest", nativeQuery = true)
	List<Object[]> teamNumByDest(); 
	
}
