package com.example.triptable.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.triptable.entity.Accommodation;
import com.example.triptable.entity.CourseRecommendation;
import com.example.triptable.entity.Manager;
import com.example.triptable.entity.ManagerRole;
import com.example.triptable.entity.Notice;
import com.example.triptable.entity.PayLog;
import com.example.triptable.repository.AccommodationRepository;
import com.example.triptable.repository.CourseRecommendationRepository;
import com.example.triptable.repository.ManagerRepository;
import com.example.triptable.repository.NoticeRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
@Transactional
public class ManagerService {

	@Autowired
	private ManagerRepository managerRepository;

	@Autowired
	private NoticeRepository noticeRepository;

	@PersistenceContext
	private EntityManager entityManager;

	@Autowired
	private AccommodationRepository accommodationRepository;

	@Autowired
	private CourseRecommendationRepository courseRecommendationRepository;

	/** 관리자 로그인 기록 업데이트 **/
	public void updateLastLogin(Manager manager) {

		// 로그인 할 때 현재시간 업데이트
		manager.setLastlogin(new Timestamp(System.currentTimeMillis()));
		managerRepository.save(manager);
	}

	/* 검색어 없이 모든 매니저 출력 */
	public List<Manager> findAllManager() {
		return managerRepository.findAll();
	}

	// ***** 공지사항 Service ******//

	/* 공지사항 내용 select 메서드 */
	public Notice setNotice(int noticenum) {
		return noticeRepository.findById(noticenum);
	}

	/* 공지사항 추가하는 메서드 */
	public int insertNotice(String title, String manager, String content, String category, String start, String end,
			JSONArray fileLists) {

		Notice notice = new Notice();

		// file json으로 저장
		String strExistData = notice.getFile();

		JSONArray jsonArray = new JSONArray();

		if (strExistData == null) {
			jsonArray = fileLists;
		} else {
			jsonArray = (JSONArray) JSONValue.parse(strExistData);
			jsonArray.addAll(fileLists);
		}

		notice.setName(title);
		notice.setManager(manager);
		notice.setContent(content);
		notice.setCategory(category);
		notice.setNoticestart(start);
		notice.setNoticeend(end);
		notice.setFile(jsonArray.toJSONString());
		notice.setHit(0);

		noticeRepository.save(notice);

		return 1;
	}

	/* 공지사항 수정하는 메서드 */
	public int updateNotice(int noticenum, String title, String category, String start, String end, String content,
			JSONArray newFiles) {
		Notice notice = noticeRepository.findById(noticenum);

		if (notice != null) {
			// 새로운 파일 목록을 JSON 형식으로 변환
			JSONArray newFilesArray = new JSONArray();
			for (Object fileObject : newFiles) {
				if (fileObject instanceof JSONObject) {
					JSONObject fileJSONObject = (JSONObject) fileObject;
					String fileName = (String) fileJSONObject.get("fileName");
					String size = (String) fileJSONObject.get("size");

					JSONObject newFileObject = new JSONObject();
					newFileObject.put("fileName", fileName);
					newFileObject.put("size", size);
					newFilesArray.add(newFileObject);
				}
			}

			// 공지사항 업데이트
			notice.setId(noticenum);
			notice.setName(title);
			notice.setContent(content);
			notice.setCategory(category);
			notice.setNoticestart(start);
			notice.setNoticeend(end);
			notice.setFile(newFilesArray.toJSONString()); // 새로운 파일 목록으로 대체
			notice.setDate(notice.getDate());
			notice.setHit(notice.getHit());
			notice.setManager(notice.getManager());
			noticeRepository.save(notice);

			return 1;
		} else {
			return 0;
		}
	}

	// ***** 숙소(Accommodation) Service ******//
	/* 숙소 추가 */
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

	/* 숙소 업데이트 */
	public int accDBUpdate(int id, String name, Timestamp date, Double latitude, Double longitude, String summary,
			String category,
			int rooms, String address, int fee, String link, String image) {
		Accommodation accUpdate = new Accommodation();
		try {
			accUpdate.setId(id);
			accUpdate.setName(name);
			accUpdate.setDate(date);
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

	// ***** 추천 코스(CourseRecomendation) Service ******//

	/* 추천 코스 추가 */
	public int recInsert(String dest, String name, String image, String dis, String dur, String manager, String sum,
			String detail) {
		CourseRecommendation recInsert = new CourseRecommendation();
		try {
			// recInsert.setId(id);
			// recInsert.setHit(hit);;
			recInsert.setCoursedest(dest);
			recInsert.setCoursename(name);
			recInsert.setCourseimage(image);
			recInsert.setCoursedis(dis);
			recInsert.setCoursedur(dur);
			recInsert.setCoursemanager(manager);
			recInsert.setCoursesum(sum);
			recInsert.setCoursedetail(detail);

			courseRecommendationRepository.save(recInsert);

			return 0;
		} catch (Exception e) {
			System.out.println("[에러] " + e.getMessage());
			return 1;
		}
	}

	/* 추천 코스 수정 */
	public int recUpdate(int id, Timestamp date, String dest, String name, String image, String dis, String dur,
			String manager, String summary, String detail) {
		CourseRecommendation recUpdate = new CourseRecommendation();

		CourseRecommendation course = (CourseRecommendation) courseRecommendationRepository.findById(id);
		String oldImage = course.getCourseimage();

		try {

			recUpdate.setId(id);
			recUpdate.setDate(date);
			recUpdate.setCoursedest(dest);
			recUpdate.setCoursename(name);
			recUpdate.setCourseimage(image);
			recUpdate.setCoursedis(dis);
			recUpdate.setCoursedur(dur);
			recUpdate.setCoursemanager(manager);
			recUpdate.setCoursesum(summary);
			recUpdate.setCoursedetail(detail);

			courseRecommendationRepository.save(recUpdate);

			return 0;
		} catch (Exception e) {
			System.out.println("[에러] " + e.getMessage());
			return 1;
		}
	}

	/* 여행 코스 승인 받는 메서드 */
	public int recApprove(int id, boolean approve) {

		CourseRecommendation courseData = courseRecommendationRepository.findById(id);
		try {
			courseData.setId(id);
			List<CourseRecommendation> courseList = courseRecommendationRepository.findAllById(id);


			String coursedest = null;
			String coursedetail = null;
			String coursedis = null;
			String coursedur = null;
			String courseimage = null;
			String coursename = null;
			String coursesum = null;

			for (CourseRecommendation course : courseList) {
				coursedest = course.getCoursedest();
				coursedetail = course.getCoursedetail();
				coursedis = course.getCoursedis();
				coursedur = course.getCoursedur();
				courseimage = course.getCourseimage();
				coursename = course.getCoursename();
				coursesum = course.getCoursesum();
			}

			if (courseData != null && coursedest != null && coursedetail != null && coursedis != null
					&& coursedur != null && courseimage != null && coursename != null && coursesum != null) {
				courseData.setApprove(approve);
				courseRecommendationRepository.save(courseData);
				return 0;
			}

			return 1;
		} catch (Exception e) {
			System.out.println("[에러] " + e.getMessage());
			return 2;
		}

	}

	/* 매니저 승인 받는 메서드 */
	public int managerApprove(int id, int approve) {

		Manager manager = managerRepository.findById(id);
		try {
			ManagerRole managerRole = new ManagerRole();

			managerRole.setRolecode(approve);
			manager.setManagerRole(managerRole);

			managerRepository.save(manager);

			return 0;
		} catch (Exception e) {
			System.out.println("[에러] " + e.getMessage());
			return 1;
		}

	}
	
	public String formatLog(PayLog payLog) {
		
		String log = payLog.getLogData();
		
		if(log.startsWith("kakaoPayApproval")) {
			String tid = extractValue(log, "tid=(.*?),");
	        String partnerOrderId = extractValue(log, "partner_order_id=(.*?),");
	        String amount = extractValue(log, "amount=AmountVO\\(total=(.*?),");
	        String createdAt = extractValue(log, "created_at=(.*?),");
	        String approvedAt = extractValue(log, "approved_at=(.*?),");
	        String provider = extractValue(log, "provider=(.*?),");
	        String userName = extractValue(log, "user=User\\(name=(.*?),");
	        String accName = extractValue(log, "accommodation=Accommodation\\(name=(.*?),");
		} else if(log.startsWith("client Request Refund")) {
			
		} else if(log.startsWith("KakaoPay Refunded")) {
			
		}
		
		return null;
	}
	
	private static String extractValue(String input, String regex) {
		try {
	        Pattern pattern = Pattern.compile(regex);
	        Matcher matcher = pattern.matcher(input);

	        if (matcher.find()) {
	            return matcher.group(1);
	        } else {
	            return null;
	        }
	    } catch (PatternSyntaxException e) {
	        // 정규식이 유효하지 않은 경우 처리
	        System.err.println("Invalid regex pattern: " + regex);
	        e.printStackTrace();
	        return null;
	    } 
	}
}