package com.example.triptable.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Accommodation;
import com.example.triptable.repository.AccommodationRepository;

@Service
public class AccommodationService {
	
	@Autowired
	private AccommodationRepository accommodationRepository; 
	

    public int accDBInsert(String name, Double latitude, Double longitude, String summary, String category,
        int rooms, String address, int fee, String link, String image) {
			try {
				Accommodation accInsert = new Accommodation();
				accInsert.setName(name);
				accInsert.setLatitude(latitude);
				accInsert.setLongitude(longitude);
				accInsert.setSummary(summary);
				accInsert.setCategory(category);
				accInsert.setRooms(rooms);
				accInsert.setAddress(address);
				accInsert.setFee(fee);
				accInsert.setUrl(link);
				accInsert.setImage(image);
				
				accommodationRepository.save(accInsert);
				return 0;
			} catch (Exception e) {
				System.out.println("[에러] " + e.getMessage());
				
				return 1; // 예외 발생 시 flag 값을 1로 설정
			}
		}
    
    public int accUpdate(int id, String name, Double latitude, Double longitude, String summary, String category,
            int rooms, String address, int fee, String link, String image) {
    	Accommodation accUpdate = new Accommodation();
		try {
			accUpdate.setId(id);
			accUpdate.setName(name);
			accUpdate.setLatitude(latitude);
			accUpdate.setLongitude(longitude);
			accUpdate.setSummary(summary);
			accUpdate.setCategory(category);
			accUpdate.setRooms(rooms);
			accUpdate.setAddress(address);
			accUpdate.setFee(fee);
			accUpdate.setUrl(link);
			accUpdate.setImage(image);
			
			accommodationRepository.save(accUpdate);
			return 0;
		} catch (Exception e) {
			System.out.println("[에러] " + e.getMessage());
			
			return 1; // 예외 발생 시 flag 값을 1로 설정
		}
    }
}
