package com.example.triptable;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
@ComponentScan(basePackages = "com.example.triptable")
public class Triptable1Application extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(Triptable1Application.class, args);
	}

}