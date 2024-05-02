package com.example.triptable.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.CourseRecommendation;
import com.example.triptable.repository.CourseRecommendationRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

//** COURSE_RECOMMENDATION SERVICE 클래스 (DAO) - 손수빈 **//
@Service
public class CourseRecommendationService {

	@Autowired
	private CourseRecommendationRepository courseRecommendationRepository;

	@PersistenceContext
	private EntityManager entityManager;

	// 화면에 띄울 여행지 추천 (id값으로 구분)
	public CourseRecommendation getBylistCourseId(int courseId) {
		CourseRecommendation courseRecommendation = courseRecommendationRepository.getById(courseId);
		return courseRecommendation;
	}

	public List<CourseRecommendation> getAllCourseList() {
		return courseRecommendationRepository.findAll();
	}

	public Page<CourseRecommendation> getCourseList(String coursedest, Pageable pageable) {
		return courseRecommendationRepository.findByCoursedestContaining(coursedest, pageable);
	}

	// 모달 클릭 시 hit(조회수) + 1
	@Transactional
	public void incrementHitForCourse(int coursenum) {
		CourseRecommendation course = entityManager.find(CourseRecommendation.class, coursenum);
		if (course != null) {
			course.setHit(course.getHit() + 1);
			entityManager.merge(course);
		}
	}

	// 관리자 페이지 - 추천코스 조회수 랭킹 순위 엑셀파일 다운로드에 사용
	public List<Map<String, String>> courseExcelDownload() {

		List<Map<String, String>> courseList = new ArrayList<Map<String, String>>();

		// 팀 여행지역 많은 순서로 랭킹을 가져옴
		List<Object[]> courseRank = courseRecommendationRepository.findRankCourse();

		for (int i = 0; i < courseRank.size(); i++) {

			// 랭킹리스트의 i번째 코스정보를 가져옴
			Object[] courseObj = courseRank.get(i);
			Map<String, String> course = new HashMap<String, String>();

			// 순위 넣기
			course.put("rank", (i + 1) + "");
			// 코스이름 넣기
			course.put("name", courseObj[0].toString());
			// 코스 지역 넣기
			course.put("dest", courseObj[1].toString());
			// 코스 조회수 넣기
			course.put("hit", courseObj[2].toString());
			// 코스 소요시간 넣기
			course.put("duration", courseObj[3] != null ? courseObj[3].toString() : "정보 없음");

			courseList.add(course);

		}
		return courseList;
	}

	public int courseCheck(int courseId) {
		CourseRecommendation courseRecommendation = courseRecommendationRepository.findById(courseId);

		try {
			List<CourseRecommendation> courseList = courseRecommendationRepository.findAllById(courseId);

			String coursedest = null;
			String coursedetail = null;
			String coursedis = null;
			String coursedur = null;
			String courseimage = null;
			String coursename = null;
			String coursesum = null;

			for (CourseRecommendation course : courseList) {
				coursedest = course.getCoursedest();
				coursedetail = course.getCoursedetail();
				coursedis = course.getCoursedis();
				coursedur = course.getCoursedur();
				courseimage = course.getCourseimage();
				coursename = course.getCoursename();
				coursesum = course.getCoursesum();
			}

			if (courseRecommendation != null && coursedest != null && coursedetail != null && coursedis != null
					&& coursedur != null && courseimage != null && coursename != null && coursesum != null) {
				courseRecommendation.setApprove(true);
				courseRecommendationRepository.save(courseRecommendation);
				return 0;
			}

			return 1;
		} catch (Exception e) {
			// TODO: handle exception

			return 2;
		}

	}

	public void courseUncheck(int courseId) {
		CourseRecommendation courseRecommendation = courseRecommendationRepository.findById(courseId);
		courseRecommendation.setApprove(false);

		courseRecommendationRepository.save(courseRecommendation);
	}
}