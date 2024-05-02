package com.example.triptable.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Notice;
import com.example.triptable.repository.NoticeRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

//** 공지사항 Service - 손수빈 **//
@Service
@Transactional
public class NoticeService {

	@Autowired
	private NoticeRepository noticeRepository;
	
	@PersistenceContext
	private EntityManager entityManager;
	
	//모든 공지사항 내용을 확인할 수 있도록 하는 메서드 (필요할 때 사용)
	public List<Notice> getAllNoticeList(){
		return noticeRepository.findAll();
	}
	
	//id값에 따른 공지사항 세부내용을 출력
	@SuppressWarnings("deprecation")
	public Notice findNoticeById(int id) {
		return noticeRepository.getById(id);
	}
	
	/* 관리자 페이지 - 공지사항 List를 페이징으로 나타내는 메서드 */
	public Page<Notice> getMnoticeListByTitle(String searchTitle, Pageable pageable){
				
		return noticeRepository.findByNameContaining(searchTitle, pageable);
	}

	/* 관리자 페이지 - 공지사항 List를 페이징으로 나타내는 메서드 */
	public Page<Notice> getMnoticeListByTitleAndCategory(String searchTitle, String category, Pageable pageable){
				
		return noticeRepository.findByNameContainingAndCategory(searchTitle,  category, pageable);
	}
	
	/* 회원 페이지 - 공지사항 List를 페이징으로 나타내는 메서드 */
	public Page<Notice> getNoticeListByTitle(String searchTitle, Pageable pageable){
		
		LocalDate tommorow = LocalDate.now().plusDays(1);	
		
		LocalDate yesterday = LocalDate.now().minusDays(1);		
		
		return noticeRepository.findByNameContainingAndNoticestartBeforeAndNoticeendAfterAndState(searchTitle, tommorow.toString(), yesterday.toString(), true, pageable);
	}
	
	/* 회원 페이지 - 공지사항 List를 페이징으로 나타내는 메서드 */
	public Page<Notice> getNoticeListByTitleAndCategory(String searchTitle, String category, Pageable pageable){
		
		LocalDate tommorow = LocalDate.now().plusDays(1);	
		
		LocalDate yesterday = LocalDate.now().minusDays(1);
		
		return noticeRepository.findByNameContainingAndCategoryAndNoticestartBeforeAndNoticeendAfterAndState(searchTitle,  category, tommorow.toString(), yesterday.toString(), true, pageable);
	}
	
	/* 공지사항 List를 페이징으로 나타내는 메서드 */
	public Page<Notice> getNoticeList(String searchTitle, String searchManager, Pageable pageable){
		return noticeRepository.findByNameContainingAndManagerContaining(searchTitle, searchManager, pageable);
	}

	
	/* view 페이지에서 이전 공지사항이 있는지 확인 */
	public boolean checkForPreviousNotice(int currentNoticeId, List<Integer> noticeIdList) {
		
		int previousNoticeId = 0;
		int currentIndex = noticeIdList.indexOf(currentNoticeId);

		if (currentIndex > 0) {
		    // 현재 공지사항 ID를 받아 이전 공지사항 ID로 변수 설정
		    previousNoticeId = noticeIdList.get(currentIndex - 1);
		}

		// 이전 공지사항 ID가 있을 경우 - true, 없을 경우 - false
		boolean existResult = noticeRepository.existsById(previousNoticeId);

		// System.out.println("이전 노티스 번호: " + previousNoticeId);
		return existResult;
	}
	
	//view 페이지에서 다음 공지사항이 있는지 확인해주는 메서드
	public boolean checkForNextNotice(int currentNoticeId, List<Integer> noticeIdList) {
		int nextNoticeId = 0;
		int currentIndex = noticeIdList.indexOf(currentNoticeId);

		if (currentIndex >= 0 && currentIndex < noticeIdList.size() - 1) {
		    // 현재 공지사항 ID를 받아 다음 공지사항 ID로 변수 설정
		    nextNoticeId = noticeIdList.get(currentIndex + 1);
		}

		// 다음 공지사항 ID가 있을 경우 - true, 없을 경우 - false
		boolean existResult = noticeRepository.existsById(nextNoticeId);

		// System.out.println("다음 노티스 번호: " + nextNoticeId);
		return existResult;

	}
	
	//view 페이지 들어갈 때 hit(조회수) + 1
	public void incrementHitForNotice(int noticenum) {
		Notice notice = entityManager.find(Notice.class, noticenum);
        if (notice != null) {
            notice.setHit(notice.getHit() + 1);
            entityManager.merge(notice);
        }
	}
	
	// 팝업 공지 반환
	public Notice getPopUpNotice() {
		List<Notice> noticeList = noticeRepository.findByCategoryAndState("팝업 공지", true);
		
		if(noticeList.size() != 0) {
			Notice notice = noticeList.get(0);
			
			LocalDate today = LocalDate.now();
			
			String strNoticeStart = notice.getNoticestart();
			String strNoticeEnd = notice.getNoticeend();
		
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			
			LocalDate noticeStart = LocalDate.parse(strNoticeStart, formatter);
			LocalDate noticeEnd = LocalDate.parse(strNoticeEnd, formatter);
			
		
			if(noticeEnd.isBefore(today) || noticeStart.isAfter(today)) {
				return null;
				
			} else {
				return notice;
			}
			
		} else {
			return null;
		}		

	}
	
	// 긴급 공지 반환
	public List<Notice> getUrgentNotice() {
		
		List<Notice> noticeList = noticeRepository.findByCategoryAndState("긴급 공지", true);
		List<Notice> activeNoticeList = new ArrayList<>();
		
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		
		if(noticeList != null) {
			
			for(int i=0; i<noticeList.size(); i++) {
				
				Notice notice = noticeList.get(i);
				
				String strNoticeEnd = notice.getNoticeend();
				LocalDate noticeEnd = LocalDate.parse(strNoticeEnd, formatter);
				
				if(!noticeEnd.isBefore(today)) {
					activeNoticeList.add(notice);
				}
			}	
			return activeNoticeList;
		}
		
		else {
			return null;
		}		
	}
	
	public void noticeCheck(int noticeId) {
		
		Notice notice = noticeRepository.findById(noticeId);
		
		notice.setState(true);
		noticeRepository.save(notice);
		
	}
	
	public void noticeUncheck(int noticeId) {
		
		Notice notice = noticeRepository.findById(noticeId);
		
		notice.setState(false);
		noticeRepository.save(notice);
		
	}	
	
}
