package com.example.triptable.userinfo;

import java.util.Map;

import lombok.AllArgsConstructor;

//** 구글 로그인 시 사용자 정보 불러오는 클래스 - 조민희 **//
@AllArgsConstructor
public class GoogleUserInfo implements OAuth2UserInfo{

    private Map<String, Object> attributes;

    @Override
    public String getProviderId() {
        return (String) attributes.get("sub");
    }

    @Override
    public String getProvider() {
        return "google";
    }

    @Override
    public String getEmail() {
        return (String) attributes.get("email");
    }

    @Override
    public String getName() {
        return (String) attributes.get("name");
    }
}