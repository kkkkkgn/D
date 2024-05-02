package com.example.triptable.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.triptable.entity.Spot;
import com.example.triptable.entity.Team;

import java.util.List;

public interface SpotRepository extends JpaRepository<Spot, Integer> {

	@Query(value = "select * from spot where team_id = :team_id and trvl_day = :day", nativeQuery = true)
	List<Spot> findByTeamAndDay(@Param(value = "team_id") int team_id, @Param(value = "day") int day);

	List<Spot> findByTeam(Team team);

	Spot findById(int id);

	@Query(value = "delete from spot where team_id = :team_id and trvl_day = :day", nativeQuery = true)
	void deleteByTeamAndDay(@Param(value = "team_id") int team_id, @Param(value = "day") int day);

	@Query(value = "select * from spot where team_id = :team_id order by spot_order", nativeQuery = true)
	List<Spot> findByTeamOrderByTime(@Param(value = "team_id") int team_id);

	List<Spot> findByTeamIdAndDayAndIdInOrderBySpotOrderAsc(int team_id, int day, List<Integer> ids);
}
