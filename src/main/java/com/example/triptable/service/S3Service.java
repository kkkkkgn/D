package com.example.triptable.service;

import java.io.InputStream;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.S3Object;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class S3Service {

	private final AmazonS3Client amazonS3Client;

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    public String getFilePath(String path) {
        return amazonS3Client.getUrl(bucket, path).toString();
    }
    
    // S3 버킷에서 파일 다운로드
    public InputStream downloadFile(String fileName) {
    	S3Object s3Object = amazonS3Client.getObject(bucket, fileName);
    	return s3Object.getObjectContent();
    }
    
}
