package com.example.triptable.controller;

import java.io.IOException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import com.example.triptable.entity.RefundStatus;
import com.example.triptable.entity.Reservation;
import com.example.triptable.entity.User;
import com.example.triptable.repository.RegionRepository;
import com.example.triptable.repository.ReservationRepository;
import com.example.triptable.service.ReservationService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//** 숙소 예약 CONTROLLER **//

@Controller
public class AccommodationController {
	
	@Autowired
	private RegionRepository regionRepository;
	
	@Autowired
	private ReservationRepository reservationRepository;
	
	@Autowired
	private ReservationService reservationService;
	
	/* 숙소 예약 현황 페이지 */
	@GetMapping("/user/res_status.do")
	public ModelAndView resstatus(HttpServletRequest request, HttpSession session) {
		System.out.println("res-status.do 호출 성공");
		
		User user = (User)session.getAttribute("user");
		
		List<Reservation> reservation = reservationRepository.findAllByUserOrderByIdDesc(user);
		
		session.removeAttribute("team_id");
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("reservation", reservation);
		modelAndView.setViewName("user/res_status");
		return modelAndView;
	}
	
	@PostMapping("/user/filterReservations.do")
	public void filterReservations(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException {
		System.out.println("res-status.do 호출 성공");
		
		User user = (User)session.getAttribute("user");
		
		String statusParam = request.getParameter("status");
		
		if(statusParam.equals("ALL")) {
			String reservation = reservationService.loadReservationStatus(user);
			response.setCharacterEncoding("utf-8");
			
			// AJAX에 여행지역 반환
			if(reservation==null) {
				response.getWriter().write("");		
			} else {
				response.getWriter().write(reservation);				
			}
		} else {
			try {
				// 문자열을 Enum으로 변환
				RefundStatus status = RefundStatus.valueOf(statusParam);
				
				System.out.println(status);
				String reservation = reservationService.loadReservationByRefundStatus(user, status);
				
				
				response.setCharacterEncoding("utf-8");
				
				// AJAX에 여행지역 반환 
				if(reservation==null) {
					response.getWriter().write("");		
				} else {
					response.getWriter().write(reservation);				
				}
				
			} catch (IllegalArgumentException e) {
				// Enum으로 변환할 수 없는 경우 예외 처리
			}	
		}
		
	}
	
	
	@GetMapping("/user/cancelRequest.do")
	public ModelAndView cancelRequest(HttpServletRequest request, HttpSession session) {
		System.out.println("cancelRequest.do 호출 성공");
		
		User user = (User)session.getAttribute("user");
		String orderNumber = request.getParameter("orderNumber");
		String resId = request.getParameter("resid");
		
		int id = Integer.parseInt(resId);
		
		System.out.println(id);
		
		int flag = reservationService.cancelRequest(user, orderNumber, id);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("flag", flag);
		modelAndView.setViewName("user/cancelRequest_Ok");
		return modelAndView;
	}

	/* 숙소 예약 페이지 */
	@GetMapping("/user/acc_reservation.do")
	public ModelAndView accReservation(HttpServletRequest request, HttpSession session) {
		System.out.println("acc_reservation() 호출성공");

		//session.removeAttribute("flag");
		session.removeAttribute("team_id");
		
		ModelAndView modelAndView = new ModelAndView();
		// 도/시 중복값 제외 list
		List<String> listDosi = regionRepository.findDistinctDosi();
		request.setAttribute("listDosi", listDosi);

		modelAndView.setViewName("user/acc_reservation");
		return modelAndView;
	}

	
	
	
	/************* 예약페이지 ajax *************/
	
	/* [초기]지역 설정시 보여지는 숙소 list */
	@PostMapping("/user/accListByDosi.do")
	public void accListByDosi(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String dosi = request.getParameter("dosi");
		
		String accList = reservationService.loadAccsByDosi(dosi);
		response.setCharacterEncoding("utf-8");
		
		// AJAX에 여행지역 반환 
		response.getWriter().write(accList);
	}
	
	/* 숙소 선택시 보여지는 모달 */
	@PostMapping("/user/accById.do")
	public void accById(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		
		String acc = reservationService.loadAccById(id);
		response.setCharacterEncoding("utf-8");
		
		// AJAX에 여행지역 반환 
		response.getWriter().write(acc);
	}
	
	@PostMapping("/user/accByName.do")
	public void accByName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String name = request.getParameter("keyword");
		
		String acc = reservationService.findByNameContaining(name);
		response.setCharacterEncoding("utf-8");
		
		if(acc == null) {
			response.getWriter().write("");	
		} else {
			response.getWriter().write(acc);
		}
		// AJAX에 여행지역 반환 
	}
	
	
	@PostMapping("/user/accByNameAndSido.do")
	public void accByNameAndSido(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String name = request.getParameter("keyword");
		String sido = request.getParameter("sido");
		
		String acc = reservationService.findByNameContainingAndAddressContaining(name, sido);
		response.setCharacterEncoding("utf-8");
		
		if(acc == null) {
			response.getWriter().write("");	
		} else {
			response.getWriter().write(acc);
		}
		// AJAX에 여행지역 반환 
	}
}
