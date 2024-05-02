package com.example.triptable.service;

import java.io.IOException;
import java.util.Properties;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.stereotype.Service;

@Service
public class MapService {

    // 카카오 JavaScript 키를 가져오는 메서드
    public String getKakao_javaScript_key() {
        // Properties 파일에서 키를 읽어오기
        try {
            // ClassPathResource를 사용하여 파일을 로드
            ClassPathResource resource = new ClassPathResource("application.properties");
            Properties properties = PropertiesLoaderUtils.loadProperties(resource);

            // 파일에서 키 값 읽어오기
            String kakaoJavaScriptKey = properties.getProperty("kakao-javaScript-key");

            // 가져온 키 값 반환
            return kakaoJavaScriptKey;
        } catch (IOException e) {
            e.printStackTrace();

            return null;
        }
    }
    
}
