package com.example.triptable.Component;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.triptable.service.ReservationService;

@Component
public class ReservationScheduler {
	
	@Autowired
	ReservationService reservationService;
	
	// 매일 오후 3시에 실행시킨다.
	@Scheduled(cron = "0 00 15 * * ?")
	public void updateTodayReservationStatus() {
		
		reservationService.updateReservationStatus();
	}
}
