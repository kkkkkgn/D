package com.example.triptable.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.triptable.entity.CourseRecommendation;
import com.example.triptable.entity.User;
import com.example.triptable.repository.CourseRecommendationRepository;
import com.example.triptable.repository.RegionRepository;
import com.example.triptable.service.CourseRecommendationService;
import com.example.triptable.service.S3Service;
import com.example.triptable.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//** 코스 추천 CONTROLLER **//

@Controller
public class CourseRecommendationController {

	@Autowired
	private CourseRecommendationService courseRecommendationService;

	@Autowired
	private RegionRepository regionRepository;

	@Autowired
	private CourseRecommendationRepository courseRecommendationRepository;

	@Autowired
	private UserService userService;

	@Autowired
	private S3Service s3Service;

	/* 코스 추천 매핑 - 여소라 */
	@GetMapping("/course.do")
	public ModelAndView course(@RequestParam(name = "region", defaultValue = "") String region,
			@RequestParam(name = "keyword", defaultValue = "") String keyword,
			// 페이징 및 정렬
			@PageableDefault(page = 0, size = 12) Pageable pageable,
			@RequestParam(name = "sort", defaultValue = "hit") String sort,
			HttpSession session) {

		System.out.println("course.do 호출 성공");

		session.removeAttribute("team_id");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("course");

		Page<CourseRecommendation> lists = null;
		
		// 정렬 방식에 따라 Pageable 객체 생성
	    Pageable sortedPageable = PageRequest.of(
	            pageable.getPageNumber(),
	            pageable.getPageSize(),
	            Sort.by(sort.equals("latest") ? "date" : "hit").descending()
	    );

		if (StringUtils.isEmpty(keyword) && StringUtils.isEmpty(region)) {
			lists = courseRecommendationRepository.findAllByApprove(true, sortedPageable);
		} else if (!StringUtils.isEmpty(keyword)) {
			lists = courseRecommendationRepository.findByCoursedestContainsAndApproveOrCoursenameContainsAndApprove(
					keyword, true, keyword, true, sortedPageable);
		} else if (!StringUtils.isEmpty(region)) {
			lists = courseRecommendationRepository.findByCoursedestContainingAndApprove(region, true, sortedPageable);
		}

		// Page.map() 메서드를 사용하여 엔티티를 가공
		Page<CourseRecommendation> dtoCourse = lists.map(courseRecommendation -> {
			// 엔티티를 DTO로 변환
			String courseImage = null;
			if (courseRecommendation.getCourseimage() != null) {
				courseImage = courseRecommendation.getCourseimage().contains("http")
						? courseRecommendation.getCourseimage()
						: s3Service.getFilePath(courseRecommendation.getCourseimage());
			}
			// 새로운 DTO 객체를 생성하고 필요한 필드 설정
			return new CourseRecommendation(
					courseRecommendation.getId(),
					courseImage,
					courseRecommendation.getCoursename(),
					courseRecommendation.getCoursedest(),
					courseRecommendation.getHit());
		});

		int nowPage = dtoCourse.getNumber() + 1;
		int blockPerPage = 5;

		int startPage = Math.max(nowPage - (nowPage - 1) % blockPerPage, 1);
		int endPage = Math.min(nowPage - (nowPage - 1) % blockPerPage + blockPerPage - 1, dtoCourse.getTotalPages());
		
		modelAndView.addObject("sort", sort);
		modelAndView.addObject("region", region);
		modelAndView.addObject("lists", dtoCourse);
		modelAndView.addObject("selectedRegion", region);
		modelAndView.addObject("keyword", keyword);
		modelAndView.addObject("nowPage", nowPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);

		return modelAndView;
	}

	/* 코스 추천 모달 AJAX - 여소라 */
	@PostMapping("/course_modal.do")
	public void course_modal(@RequestParam("courseId") int courseenum, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		List<String> listDosi = regionRepository.findDistinctDosi();

		request.setAttribute("listDosi", listDosi);

		courseRecommendationService.incrementHitForCourse(courseenum);

		int courseId = Integer.parseInt(request.getParameter("courseId"));

		CourseRecommendation courseRecommendation = (CourseRecommendation) courseRecommendationRepository
				.findById(courseId);
		String coursedest = courseRecommendation.getCoursedest();
		String coursename = courseRecommendation.getCoursename();
		String coursedur = courseRecommendation.getCoursedur();
		String coursedis = courseRecommendation.getCoursedis();
		String coursemanager = courseRecommendation.getCoursemanager();
		Timestamp coursedate = courseRecommendation.getDate();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String coursedateString = dateFormat.format(coursedate);
		
		//System.out.println(coursedateString);
		
		String coursedetail = courseRecommendation.getCoursedetail() == null ? ""
				: courseRecommendation.getCoursedetail().replaceAll("\n", "<br />");
		String coursesum = courseRecommendation.getCoursesum();
		String courseimage = courseRecommendation.getCourseimage().contains("http") == true
				? courseRecommendation.getCourseimage()
				: s3Service.getFilePath(courseRecommendation.getCourseimage());
		int coursehit = courseRecommendation.getHit();
		response.setCharacterEncoding("UTF-8");

		// JSONObject를 사용하여 JSON 문자열 생성
		JSONObject jsonObject = new JSONObject();

		jsonObject.put("courseDateString", coursedateString);
		jsonObject.put("courseDest", coursedest);
		jsonObject.put("courseName", coursename);
		jsonObject.put("courseDur", coursedur);
		jsonObject.put("courseDis", coursedis);
		jsonObject.put("courseManager", coursemanager);
		jsonObject.put("courseDetail", coursedetail);
		jsonObject.put("courseImage", courseimage);
		jsonObject.put("courseSum", coursesum);
		jsonObject.put("courseHit", coursehit);

		// JSON 문자열 출력
		String result = jsonObject.toString();

		response.getWriter().write(result);
	}

	// 코스 추천 즐겨찾기 추가
	@PostMapping("/user/favorite_insert.do")
	public void course_fav_insert(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {
		String courseId = request.getParameter("courseId");
		User user = (User) session.getAttribute("user");

		String result = userService.updateFavorite(user, courseId);

		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);
	}

	// 코스 추천 즐겨찾기 취소
	@PostMapping("/user/favorite_delete.do")
	public void course_fav_delete(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException {
		String courseId = request.getParameter("courseId");
		User user = (User) session.getAttribute("user");

		String result = userService.deleteFavorite(user, courseId);

		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result);
	}

	// 코스 추천 버튼 활성화
	@PostMapping("/user/show_favorite.do")
	public void getUserFavCourses(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws IOException {
		User user = (User) session.getAttribute("user");

		String favCourses = user.getFavorite();

		response.setCharacterEncoding("utf-8");
		response.getWriter().write(favCourses);
	}

}
