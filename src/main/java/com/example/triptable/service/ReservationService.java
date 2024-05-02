package com.example.triptable.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Accommodation;
import com.example.triptable.entity.PayLog;
import com.example.triptable.entity.RefundStatus;
import com.example.triptable.entity.Reservation;
import com.example.triptable.entity.User;
import com.example.triptable.repository.AccommodationRepository;
import com.example.triptable.repository.PayLogRepository;
import com.example.triptable.repository.ReservationRepository;

@Service
public class ReservationService {

	@Autowired
	private AccommodationRepository accommodationRepository;

	@Autowired
	private ReservationRepository reservationRepository;
	
	@Autowired
	private PayLogRepository payLogRepository;

	public String loadAccsByDosi(String address) {

		List<Accommodation> accList = accommodationRepository.findByAddressContaining(address);

		JSONArray accArray = new JSONArray();

		if (accList.size() == 0) {

			return null;
		} else {

			for (int i = 0; i < accList.size(); i++) {

				JSONObject accObject = new JSONObject();

				accObject.put("acc_id", accList.get(i).getId());
				accObject.put("acc_name", accList.get(i).getName());
				accObject.put("acc_latitude", accList.get(i).getLatitude());
				accObject.put("acc_longitude", accList.get(i).getLongitude());
				accObject.put("acc_category", accList.get(i).getCategory());
				accObject.put("acc_rooms", accList.get(i).getRooms());
				accObject.put("acc_address", accList.get(i).getAddress());
				accObject.put("acc_url", accList.get(i).getUrl());
				accObject.put("acc_image", accList.get(i).getImage());

				accArray.add(accObject);
			}

			return accArray.toString();
		}
	}

	public List<Reservation> findAllReservation() {
		List<Reservation> resList = reservationRepository.findAll();
		System.out.println("loadReservation() 호출 성공 ");
		return resList;
	}

	public List<Reservation> findUserReservation(@Param(value = "username") String username) {
		return reservationRepository.findByUserNameContaining(username);
	}

	public List<Reservation> findByUserAndRefundStatus(@Param(value = "username") String username,
			RefundStatus refundStatus) {
		return reservationRepository.findByUserAndRefundStatus(username, refundStatus);
	}

	public String loadAccById(int id) {
		Accommodation acc= accommodationRepository.findById(id);

		JSONObject accObject = new JSONObject();
		
		accObject.put("acc_id", acc.getId());
		accObject.put("acc_name", acc.getName());
		accObject.put("acc_fee", acc.getFee());
		accObject.put("acc_summary", acc.getSummary());
		accObject.put("acc_latitude", acc.getLatitude());
		accObject.put("acc_longitude", acc.getLongitude());
		accObject.put("acc_category", acc.getCategory());
		accObject.put("acc_rooms", acc.getRooms());
		accObject.put("acc_address", acc.getAddress());
		accObject.put("acc_url", acc.getUrl());
		accObject.put("acc_image", acc.getImage());
		
		return accObject.toString();
	}
	
	public String findByNameContaining(String name) {
		List<Accommodation> accList = accommodationRepository.findByNameContaining(name);
		
		JSONArray accArray = new JSONArray();
		
		if(accList.size() == 0) {
			
			return null;
		} else {
			
			for(int i=0; i<accList.size(); i++) {
				
				JSONObject accObject = new JSONObject();
				
				accObject.put("acc_id", accList.get(i).getId());
				accObject.put("acc_name", accList.get(i).getName());
				accObject.put("acc_latitude", accList.get(i).getLatitude());
				accObject.put("acc_longitude", accList.get(i).getLongitude());
				accObject.put("acc_fee", accList.get(i).getFee());
				accObject.put("acc_summary", accList.get(i).getSummary());
				accObject.put("acc_category", accList.get(i).getCategory());
				accObject.put("acc_rooms", accList.get(i).getRooms());
				accObject.put("acc_address", accList.get(i).getAddress());
				accObject.put("acc_url", accList.get(i).getUrl());
				accObject.put("acc_image", accList.get(i).getImage());
				
				accArray.add(accObject);
			}

			return accArray.toString();
		}
	}
	
	public String findByNameContainingAndAddressContaining(String name, String sido) {
		List<Accommodation> accList = accommodationRepository.findByNameContainingAndAddressContaining(name, sido);
		
		JSONArray accArray = new JSONArray();
		
		if(accList.size() == 0) {
			
			return null;
		} else {
			
			for(int i=0; i<accList.size(); i++) {
				
				JSONObject accObject = new JSONObject();
				
				accObject.put("acc_id", accList.get(i).getId());
				accObject.put("acc_name", accList.get(i).getName());
				accObject.put("acc_latitude", accList.get(i).getLatitude());
				accObject.put("acc_longitude", accList.get(i).getLongitude());
				accObject.put("acc_fee", accList.get(i).getFee());
				accObject.put("acc_summary", accList.get(i).getSummary());
				accObject.put("acc_category", accList.get(i).getCategory());
				accObject.put("acc_rooms", accList.get(i).getRooms());
				accObject.put("acc_address", accList.get(i).getAddress());
				accObject.put("acc_url", accList.get(i).getUrl());
				accObject.put("acc_image", accList.get(i).getImage());
				
				accArray.add(accObject);
			}
			return accArray.toString();
		}
	}
	
	public String loadReservationStatus(User user) {
		List<Reservation> res = reservationRepository.findAllByUser(user);
				
		JSONArray resStatusArray = new JSONArray();
		
		if(res.size() == 0) {
			return resStatusArray.toString();
		} else {
			for(int i=0; i<res.size(); i++) {
				
				JSONObject resObject = new JSONObject();
				
				resObject.put("id", res.get(i).getId());
				resObject.put("date", res.get(i).getDate());
				resObject.put("fee", res.get(i).getFee());
				resObject.put("guests", res.get(i).getGuests());
				resObject.put("refundstatus", res.get(i).getRefundStatus());
				resObject.put("resend", res.get(i).getResend());
				resObject.put("resstart", res.get(i).getResstart());
				resObject.put("accid", res.get(i).getAccommodation());
				resObject.put("ordernumber", res.get(i).getOrderNumber());
				resObject.put("userid", res.get(i).getUser());
				
				resStatusArray.add(resObject);
			}

			return resStatusArray.toString();
		}
	}
	
	public String loadReservationByRefundStatus(User user, RefundStatus status) {
		
		List<Reservation> res = reservationRepository.findAllByUserAndRefundStatusOrderByIdDesc(user, status);
				
		JSONArray resStatusArray = new JSONArray();
		
		if(res.size() == 0) {
			return null;
		} else {
			for(int i=0; i<res.size(); i++) {
				
				JSONObject resObject = new JSONObject();
				
				resObject.put("id", res.get(i).getId());
				resObject.put("date", res.get(i).getDate().toString());
				resObject.put("fee", res.get(i).getFee());
				resObject.put("guests", res.get(i).getGuests());
				resObject.put("refundstatus", res.get(i).getRefundStatus().toString());
				resObject.put("resend", res.get(i).getResend());
				resObject.put("resstart", res.get(i).getResstart());
				resObject.put("accImg", res.get(i).getAccommodation().getImage().toString());
				resObject.put("accName", res.get(i).getAccommodation().getName());
				resObject.put("ordernumber", res.get(i).getOrderNumber());
				
				resStatusArray.add(resObject);
			}

			return resStatusArray.toString();
		}
	}
	
	public int cancelReservation(int resId) {
		Reservation res = reservationRepository.findById(resId);
		
		int flag = 1;
		if(res.getRefundStatus()==RefundStatus.CANCELING || res.getRefundStatus()==RefundStatus.BEFORE_USE) {
			res.setRefundStatus(RefundStatus.CANCELED);
			reservationRepository.save(res);
			flag = 0;
		}
		
		return flag;
	}
	
	public int cancelRequest(User user, String orderNumber, int resId) {
		Reservation res = reservationRepository.findById(resId);
		
		int flag = 1;
		if(res.getRefundStatus()!=RefundStatus.BEFORE_USE) {
			flag = 2;
		} else if(orderNumber.equals(res.getOrderNumber()+"")) {
			res.setRefundStatus(RefundStatus.CANCELING);
			
			reservationRepository.save(res);
			PayLog payLog = new PayLog();
			payLog.setLogData("clientRequestRefund : " + "orderNumber=" + orderNumber + ", userId=" + user.getId() + ", userName=" + user.getName() + ", AccId=" + res.getAccommodation().getId() + ", AccName=" + res.getAccommodation().getName() + ", requested_at=" + LocalDateTime.now());
			
			payLogRepository.save(payLog);
			
			flag = 0;
		}
			
		return flag;
	}
	
	// scheduler에서 쓸 메서드. 매일 3시 업데이트
	public void updateReservationStatus() {
		//refundStatus 기준
		RefundStatus rsStatus = RefundStatus.BEFORE_USE;
		
		// 현재 날짜를 가져옴
        LocalDate currentDate = LocalDate.now();
		
        // 날짜 조회할 양식 설립
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy. M. d.(E)");
		
		String today = currentDate.format(formatter);
		
		List<Reservation> resList = reservationRepository.findAllByRefundStatusAndResstart(rsStatus, today);
		
		for(Reservation rs : resList) {
			rs.setRefundStatus(RefundStatus.AFTER_USE);
			
			reservationRepository.save(rs);
		}
	}
}
