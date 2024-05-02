package com.example.triptable.valueobject;

import com.example.triptable.entity.Reservation;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class KakaoPayCancelVO {
    private String cid;
    
    private String tid;
    private int cancel_amount;
    private int cancel_tax_free_amount;
}
 

