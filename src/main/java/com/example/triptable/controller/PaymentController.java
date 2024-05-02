package com.example.triptable.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.triptable.entity.Accommodation;
import com.example.triptable.entity.Reservation;
import com.example.triptable.entity.User;
import com.example.triptable.repository.AccommodationRepository;
import com.example.triptable.repository.ReservationRepository;
import com.example.triptable.service.KakaoPayService;
import com.example.triptable.valueobject.KakaoPayApprovalVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.java.Log;
 
@Log
@Controller
public class PaymentController {
    
    @Autowired
    private KakaoPayService kakaopayService;
    
    @Autowired
    private AccommodationRepository accommodationRepository;
    
    @Autowired
    private ReservationRepository reservationRepository;
    
    @PostMapping("/user/kakaoPay.do")
    public String kakaoPay(HttpSession session, HttpServletRequest request) {
        log.info("kakaoPay post............................................");
        
        User user = (User)session.getAttribute("user");
        
        String res_fee = request.getParameter("acc_fee");
		String res_guests = request.getParameter("res_guests");

		int acc_id = Integer.parseInt( request.getParameter("acc_id") );
		String orderNumber = request.getParameter("orderNumber");
		
		log.info("orderNumber Made : " + orderNumber);
	
		String res_start = request.getParameter("res_start");
		String res_end = request.getParameter("res_end");
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy. M. d.(E)", Locale.KOREAN);
		// LocalDate 객체로 파싱
		LocalDate startDate = LocalDate.parse(res_start, formatter);
		LocalDate endDate = LocalDate.parse(res_end, formatter);

		// 여행일차 = 여행 끝날짜 - 여행 시작날짜 + 1
		int daysBetween = (int) ChronoUnit.DAYS.between(startDate, endDate);
				
		Reservation res = new Reservation();
		Accommodation acc = accommodationRepository.findById(acc_id);
		res.setAccommodation(acc);
		res.setFee( (Integer.parseInt(res_fee) * daysBetween) + "");
		res.setGuests(res_guests);
		res.setResstart(res_start);
		res.setResend(res_end);
		res.setUser(user);
		res.setOrderNumber(Long.parseLong(orderNumber));
		
		return "redirect:" + kakaopayService.kakaoPayReady(res, request);
 
    }
    
    @GetMapping("/kakaoPaySuccess")
    public String kakaoPaySuccess(
    		@RequestParam("pg_token") String pg_token, 
    		Model model) {
    	// 결제 여부에 따른 pg_token 카카오서버에서 생성
        log.info("kakaoPaySuccess get............................................");
        log.info("kakaoPaySuccess pg_token : " + pg_token);
       
        KakaoPayApprovalVO kakaoPayApprovalVO = kakaopayService.kakaoPayInfo(pg_token);
        
        if(kakaoPayApprovalVO != null) {
        	Date date = kakaoPayApprovalVO.getApproved_at();

        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
            
        	Reservation res = reservationRepository.findByTid(kakaoPayApprovalVO.getTid());
            // 날짜를 문자열로 변환
            String formattedDate = sdf.format(date);
            model.addAttribute("reservation", res);
            model.addAttribute("info", kakaoPayApprovalVO);
            model.addAttribute("formattedDate", formattedDate);
            
            return "kakaoPaySuccess";
        } else {
        	return "redirect:/user/acc_reservation.do";  
        }
        
    }
    
    @GetMapping("/manager/managerCancelReservation.do")
	public ModelAndView cancelReservation(HttpServletRequest request, HttpSession session) {
		System.out.println("cancelReservation.do 호출 성공");

		int resId = Integer.parseInt(request.getParameter("resId"));
		
		Reservation res = reservationRepository.findById(resId);
		
		int flag = kakaopayService.kakaoPayCancel(res);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("flag", flag);
		modelAndView.setViewName("manager/maccommodation_res_delete_Ok");
		return modelAndView;
	}
    
    
}
 