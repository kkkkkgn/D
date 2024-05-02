package com.example.triptable.excel;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

@Component
public class ExcelUtil {

	@Autowired
	private AmazonS3Client amazonS3Client;

	@Value("${cloud.aws.s3.bucket}")
	private String bucket;

	public void download(HttpServletRequest request, HttpServletResponse response, Map<String, Object> beans,
			String filename, String templateFile) throws InvalidFormatException {

		S3Object s3Object = amazonS3Client.getObject(new GetObjectRequest(bucket, "excel/" + templateFile));

		S3ObjectInputStream ois = null;
		BufferedReader br = null;

		try {
			ois = s3Object.getObjectContent();
			br = new BufferedReader(new InputStreamReader(ois, "UTF-8"));

			XLSTransformer transformer = new XLSTransformer();
			Workbook resultWorkbook = transformer.transformXLS(ois, beans);
			response.setHeader("Content-Disposition",
					"attachment; filename=" + filename + System.currentTimeMillis() + ".xlsx");
			OutputStream os = response.getOutputStream();
			resultWorkbook.write(os);

		} catch (ParsePropertyException | IOException e) {
			e.printStackTrace();
		}

	}
}
