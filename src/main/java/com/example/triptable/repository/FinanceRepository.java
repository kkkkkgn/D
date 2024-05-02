package com.example.triptable.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.triptable.entity.Finance;
import com.example.triptable.entity.Team;

public interface FinanceRepository extends JpaRepository<Finance, Integer> {

	List<Finance> findByTeam(Team team);

	@Query(value = "delete from finance where team_id = :team_id and trvl_day = :day", nativeQuery = true)
	void deleteByTeamAndDay(@Param(value = "team_id") int team_id, @Param(value = "day") int day);

	Finance findById(int id);

	@Query(value = "select * from finance where team_id = :team_id and trvl_day = :day", nativeQuery = true)
	List<Finance> findByTeamAndDay(@Param(value = "team_id") int team_id, @Param(value = "day") int day);

}
