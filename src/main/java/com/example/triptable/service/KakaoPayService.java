package com.example.triptable.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.example.triptable.entity.PayLog;
import com.example.triptable.entity.RefundStatus;
import com.example.triptable.entity.Reservation;
import com.example.triptable.repository.PayLogRepository;
import com.example.triptable.repository.ReservationRepository;
import com.example.triptable.valueobject.KakaoPayApprovalVO;
import com.example.triptable.valueobject.KakaoPayCancelVO;
import com.example.triptable.valueobject.KakaoPayReadyVO;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
 
@Service
@Slf4j
public class KakaoPayService {
 
    private static final String HOST = "https://kapi.kakao.com";
    
    private KakaoPayReadyVO kakaoPayReadyVO;
    
    private KakaoPayApprovalVO kakaoPayApprovalVO;
    
    private KakaoPayCancelVO kakaoPayCancelVO;
    
    @Autowired
    private PayLogRepository payLogRepository;
    
    @Autowired
    private ReservationRepository reservationRepository;
    
    
	public String kakaoPayReady(Reservation res, HttpServletRequest request) {
		log.info("KakaoPayReady............................................");
        log.info("-----------------------------");
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "f2a8e906baa4e6c5b1adab0b046ac6a3");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME"); // 가맹정 코드 (카카오에서 제공하는 샘플 코드 사용)
        params.add("partner_order_id", res.getOrderNumber() + "") ; // 주문 번호
        params.add("partner_user_id", res.getUser().getName()); // 주문자명
        params.add("item_name", res.getAccommodation().getName()); // 상품 이름
        params.add("quantity", "1"); // 상품 수량
        params.add("total_amount", res.getFee()+""); // 결제 금액
        params.add("tax_free_amount", "0"); // 부가세 = 0
        
        StringBuffer sbDomain = new StringBuffer();
		sbDomain.append(request.getScheme()).append("://").append(request.getServerName()).append(":").append(request.getServerPort()).append(request.getContextPath());
        		
        // 추후 배포시 링크 수정 바랍니다.
        params.add("approval_url", sbDomain.toString() + "/kakaoPaySuccess"); //결제 완료 시 이동 페이지
        params.add("cancel_url", sbDomain.toString() + "/user/acc_reservation.do"); // 결제 취소 시 이동 페이지
        
        params.add("fail_url", sbDomain.toString() + "/index.do"); // 결제 실패 시 이동 페이지
 
        // 카카오페이 양식 구현
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
        	// VO객체로 
            kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
            kakaoPayReadyVO.setReservation(res);
            
            
            // 로그 출력
            log.info("ready for KakaoPay : " + kakaoPayReadyVO);
            
            //return kakaoPayReadyVO.getNext_redirect_pc_url();
            return kakaoPayReadyVO.getNext_redirect_pc_url();
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
        	System.out.println("error : " + e);
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
        	System.out.println("error : " + e);
            e.printStackTrace();
        }
        
        return "/error";
        
    }
    
    public KakaoPayApprovalVO kakaoPayInfo(String pg_token) {

        log.info("KakaoPayInfoVO............................................");
        log.info("-----------------------------");
        
        RestTemplate restTemplate = new RestTemplate();

        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "f2a8e906baa4e6c5b1adab0b046ac6a3");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
       
        // body 구현
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", kakaoPayReadyVO.getReservation().getOrderNumber()+"");
        params.add("partner_user_id", kakaoPayReadyVO.getReservation().getUser().getName());
        params.add("pg_token", pg_token);
        params.add("total_amount", kakaoPayReadyVO.getReservation().getFee());
        params.add("res_start", kakaoPayReadyVO.getReservation().getResstart());
        params.add("res_end", kakaoPayReadyVO.getReservation().getResend());
        
        Reservation res = kakaoPayReadyVO.getReservation();
        res.setTid(kakaoPayReadyVO.getTid());	
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        
        try {
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            PayLog payLog = new PayLog();
            log.info("kakaoPayApprovalVO : " + kakaoPayApprovalVO);
            payLog.setLogData("kakaoPayApproval : " + kakaoPayApprovalVO  + ", userId=" + res.getUser().getId() + ", userName=" + res.getUser().getName() + ", accId=" + res.getAccommodation().getId() + ", accName=" + res.getAccommodation().getName());
            
            reservationRepository.save(res);
            payLogRepository.save(payLog);
            
            return kakaoPayApprovalVO;
        
        } catch (RestClientException e) {
        	PayLog payLog = new PayLog();
            payLog.setLogData("kakaoPayApproval error : " + e );
            
            payLogRepository.save(payLog);
        } catch (URISyntaxException e) {
        	PayLog payLog = new PayLog();
            payLog.setLogData("kakaoPayApproval error : " + e );
            
            payLogRepository.save(payLog);
        }
        
        return null;
    }
    
    public int kakaoPayCancel(Reservation res) {
    	log.info("KakaoPayCancelReady............................................");
        log.info("-----------------------------");
        RestTemplate restTemplate = new RestTemplate();
        
        int flag = 1;
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "f2a8e906baa4e6c5b1adab0b046ac6a3");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME"); // 가맹정 코드 (카카오에서 제공하는 샘플 코드 사용)
        params.add("tid", res.getTid());
        params.add("partner_user_id", res.getUser().getName()); // 주문자명
        params.add("cancel_amount", res.getFee()+""); // 결제 금액
        params.add("cancel_tax_free_amount", "0"); // 부가세 = 0
        
        
        // 카카오페이 양식 구현
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
        	// VO객체로 
            kakaoPayCancelVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/cancel"), body, KakaoPayCancelVO.class);
            
            if(res.getRefundStatus()==RefundStatus.CANCELING || res.getRefundStatus()==RefundStatus.BEFORE_USE) {
    			
				res.setRefundStatus(RefundStatus.CANCELED);
				PayLog payLog = new PayLog();
				payLog.setLogData("kakaoPayCanceled : " + kakaoPayCancelVO + ", userId=" + res.getUser().getId() + ", userName=" + res.getUser().getName() + ", accId=" + res.getAccommodation().getId() + ", accName=" + res.getAccommodation().getName());
				reservationRepository.save(res);				
				payLogRepository.save(payLog);
            }
            
            return 0;
           
        } catch (RestClientException e) {
        	PayLog payLog = new PayLog();
            payLog.setLogData("KakaoPay Refunded error : " + e);
            
            payLogRepository.save(payLog);
        } catch (URISyntaxException e) {
        	PayLog payLog = new PayLog();
            payLog.setLogData("KakaoPay Refunded error : " + e);
            
            payLogRepository.save(payLog);
        }
        
    	return 1;
    }
}