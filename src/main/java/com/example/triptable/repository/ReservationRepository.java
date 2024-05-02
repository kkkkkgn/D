package com.example.triptable.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.triptable.entity.RefundStatus;
import com.example.triptable.entity.Reservation;
import com.example.triptable.entity.User;

//** 예약 REPOSITORY - 박수진 **//
@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    // 모든 예약을 조회하는 기본 메서드
    List<Reservation> findAll();

    @Query("select r from Reservation r where r.user.name like %:username%")
    List<Reservation> findByUserNameContaining(@Param("username") String username);

    @Query("SELECT r FROM Reservation r WHERE r.user.name LIKE %:username% AND r.refundStatus = :refundStatus")
    List<Reservation> findByUserAndRefundStatus(@Param("username") String username, @Param("refundStatus") RefundStatus refundStatus);
    
    // 유저에 따른 예약내역 조회
    List<Reservation> findAllByUser(User user);
    
    // 유저에 따른 예약내역 역순 출력
    List<Reservation> findAllByUserOrderByIdDesc(User user);

    // 유저에 따른 상태별 예약내역 조회
    List<Reservation> findAllByUserAndRefundStatusOrderByIdDesc(User user, RefundStatus status);
    
    Reservation findById(int resId);
    
    // scheduler에서 사용할 메서드
    // 예약 현황과 여행 날짜조회
    List<Reservation> findAllByRefundStatusAndResstart(RefundStatus status, String today);
    
    Page<Reservation> findByUser_nameContaining(String username, Pageable pageable);
    
    Page<Reservation> findByUser_nameContainingAndRefundStatus(String username, RefundStatus status, Pageable pageable);
    
    Reservation findByTid(String tid);
    
}