package com.example.triptable.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.triptable.entity.Notice;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Integer>{

	Notice findById(int id);
	
	List<Notice> findAll();

	// 관리자 페이지에서 공지사항 띄울때 사용
	Page<Notice> findByNameContaining(String noticename, Pageable pageable);
	Page<Notice> findByNameContainingAndCategory(String noticename, String category, Pageable pageable);

	// 회원 페이지에서 공지사항 띄울때 사용	
	Page<Notice> findByNameContainingAndNoticestartBeforeAndNoticeendAfterAndState(String noticename, String start, String end, Boolean state, Pageable pageable);	
	Page<Notice> findByNameContainingAndCategoryAndNoticestartBeforeAndNoticeendAfterAndState(String noticename, String category, String start, String end, Boolean state,Pageable pageable);
	
	
	Page<Notice> findByNameContainingAndManagerContaining(String searchTitle, String searchManager, Pageable pageable);
		
	List<Notice> findByCategoryAndState(String category, Boolean state);
	
	List<Notice> findByState(Boolean state);
	
	List<Notice> findByNoticestartBeforeAndNoticeendAfterAndState( String start, String end, Boolean state);
}
