package com.example.triptable.entity;

public enum RefundStatus {
    BEFORE_USE, // 이용 전
    AFTER_USE, // 이용 후
    CANCELING, // 취소 진행중 
    CANCELED; // 취소 됨

    @Override
    public String toString() {
        return name();
    }

}
