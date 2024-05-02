package com.example.triptable.userinfo;

//** 소셜 로그인 INTERFACE - 조민희 **//
public interface OAuth2UserInfo {
    String getProviderId();
    String getProvider();
    String getEmail();
    String getName();
}