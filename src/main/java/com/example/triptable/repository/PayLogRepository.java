package com.example.triptable.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.triptable.entity.PayLog;

//** 결제 로그 REPOSITORY - 박수진 **//
public interface PayLogRepository extends JpaRepository<PayLog, Integer> {
	Page<PayLog> findByLogDataContaining(String logStartWith, Pageable pageable);
}