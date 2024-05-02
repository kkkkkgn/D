package com.example.triptable.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.triptable.entity.CourseRecommendation;


//** COURSERECOMMENDATION REPOSITORY : <TO클래스이름, 기본키의 타입> - 손수빈 **//
@Repository
public interface CourseRecommendationRepository extends JpaRepository<CourseRecommendation, Integer> {

	CourseRecommendation findById(int courseId);

	List<CourseRecommendation> findAll();

	// 코스추천페이지
	Page<CourseRecommendation> findAllByApprove(boolean approve, Pageable pageable);

	// 코스추천페이지
	Page<CourseRecommendation> findByCoursedestContainsAndApproveOrCoursenameContainsAndApprove( String coursedest, boolean dapprove,  String coursename, boolean napprove, Pageable pageable);
	
	Page<CourseRecommendation> findByCoursedestContainsOrCoursenameContains(String coursedest, String coursename, Pageable pageable);
	
	// 코스추천페이지
	Page<CourseRecommendation> findByCoursedestContainingAndApprove(String coursedest, boolean approve, Pageable pageable);

	// 관리자 코스추천 관리
	Page<CourseRecommendation> findByCoursedestContaining(String coursedest, Pageable pageable);

	List<CourseRecommendation> findAllById(int courseId);

	// 코스 즐겨찾기(마이페이지)
	Page<CourseRecommendation> findByCoursedestContainingAndId(String keyword, int courseId, Pageable pageable);

	
	@Query(value = "select * from course_recommendation order by c_hit desc limit 6", nativeQuery = true)
	List<CourseRecommendation> findOrderByHit();

	
	Page<CourseRecommendation> findByIdIn(List<Integer> lists, Pageable pageable);

	
	Page<CourseRecommendation> findByCoursedestContainingAndIdIn(String keyword, List<Integer> lists, Pageable pageable);

	Page<CourseRecommendation> findByCoursedestContainingAndIdInOrCoursenameContainingAndIdIn(String coursedest, List<Integer> lists1, String coursename, List<Integer> lists2, Pageable pageable);
	@Query(value = "select c_name, c_dest, c_hit, c_dur from course_recommendation order by c_hit desc limit 30", nativeQuery = true)
	List<Object[]> findRankCourse();
}