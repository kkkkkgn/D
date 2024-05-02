package com.example.triptable.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;

import java.text.DecimalFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.example.triptable.entity.CourseRecommendation;
import com.example.triptable.entity.Manager;
import com.example.triptable.entity.Notice;
import com.example.triptable.repository.CourseRecommendationRepository;
import com.example.triptable.repository.NoticeRepository;
import com.example.triptable.service.ManagerService;
import com.example.triptable.service.S3Service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class AwsS3Controller {

	@Autowired
	private ManagerService managerService;

	@Autowired
	private NoticeRepository noticeRepository;

	@Autowired
	private CourseRecommendationRepository courseRecommendationRepository;

	private final AmazonS3Client amazonS3Client;;
	@Autowired
	private S3Service s3Service;

	// 저장할 bucket의 이름을 가져옴 (application.properties에 있음)
	@Value("${cloud.aws.s3.bucket}")
	private String bucket;

	// 다중 파일,이미지 업로드
	// Key는 File로 통일
	@PostMapping("/insert")
	public ResponseEntity<String> uploadFile(@RequestParam("notice_title") String title,
			@RequestParam("notice_content") String content,
			@RequestParam("notice_category") String category,
			@RequestParam("notice_start") String start,
			@RequestParam("notice_end") String end,
			@RequestPart(value = "files", required = false) MultipartFile[] files, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		// System.out.println("files : " + files.length);

		JSONArray fileLists = new JSONArray();

		if (files != null && files.length > 0) {
			for (MultipartFile file : files) {
				// 원본 파일 이름 가져오기
				String Original_fileName = file.getOriginalFilename();
				// 타임스탬프를 포함한 새로운 파일 이름 생성
				String timestamp = String.valueOf(System.currentTimeMillis());
				String fileName = timestamp + "_" + Original_fileName;

				// 바이트를 킬로바이트(KB)로 변환
				DecimalFormat df = new DecimalFormat("#.#");
				String fileSize = df.format(file.getSize() / 1024.0);

				// 업로드할 파일의 메타데이터 설정
				ObjectMetadata metadata = new ObjectMetadata();
				metadata.setContentType(file.getContentType());
				metadata.setContentLength(file.getSize());

				// Amazon S3에 파일 업로드
				amazonS3Client.putObject(bucket, fileName, file.getInputStream(), metadata);

				JSONObject fileObject = new JSONObject();

				fileObject.put("fileName", fileName);
				fileObject.put("size", fileSize);

				fileLists.add(fileObject);
			}
		}
		System.out.println(fileLists);

		Manager manager = (Manager) session.getAttribute("manager");
		String managerName = manager.getName();

		managerService.insertNotice(title, managerName, content, category, start, end, fileLists);

		return ResponseEntity.ok("완료");
	}

	/**
	 * 파일 삭제 엔드포인트
	 *
	 * @param fileName 삭제할 파일의 이름
	 * @return 삭제 결과 메시지
	 */

	@PostMapping("/mnotice_update.do")
	@ResponseBody
	public ResponseEntity<String> UpdateFile(
			@RequestParam("notice_title") String title,
			@RequestParam("notice_content") String content,
			@RequestParam("notice_id") int noticeId,
			@RequestParam("notice_category") String category,
			@RequestParam("notice_start") String start,
			@RequestParam("notice_end") String end,
			@RequestPart(value = "ufile", required = false) MultipartFile[] ufile,
			HttpServletRequest request,
			HttpServletResponse response) {

		try {
			// 클라이언트에서 전송한 notice_id를 사용하여 공지사항을 찾음
			Notice notice = noticeRepository.findById(noticeId);

			System.out.println(noticeId);
			// System.out.println(ufile.length);

			if (notice != null) {
				if (ufile != null && ufile.length > 0) {
					// 새로운 파일이 업로드되었을 경우
					JSONArray newFiles = new JSONArray();

					// 각 파일에 대해 처리
					for (MultipartFile file : ufile) {
						// 업로드할 파일의 메타데이터 설정
						ObjectMetadata metadata = new ObjectMetadata();
						metadata.setContentType(file.getContentType());
						metadata.setContentLength(file.getSize());

						// 타임스탬프를 포함한 새로운 파일 이름 생성
						String timestamp = String.valueOf(System.currentTimeMillis());
						String newFile = timestamp + "_" + file.getOriginalFilename();

						// 바이트를 킬로바이트(KB)로 변환
						DecimalFormat df = new DecimalFormat("#.#");
						String fileSize = df.format(file.getSize() / 1024.0);
						
						JSONObject fileObj = new JSONObject();

						fileObj.put("fileName", newFile);
						fileObj.put("size", fileSize);
						newFiles.add(fileObj);

						// Amazon S3에 파일 업로드
						amazonS3Client.putObject(bucket, newFile, file.getInputStream(), metadata);
					}

					JSONParser parser = new JSONParser();

					// 기존 파일이 있다면 기존 파일 삭제
					if (notice.getFile() != null) {
						JSONArray existingFiles = (JSONArray) parser.parse(notice.getFile());

						for (int i = 0; i < existingFiles.size(); i++) {
							JSONObject existingFile = (JSONObject) existingFiles.get(i);
							String fileName = existingFile.get("fileName").toString();
							
							System.out.println(fileName);

							// Amazon S3에서 기존 파일 삭제
							amazonS3Client.deleteObject(bucket, fileName);
						}
					}

					// 업데이트된 파일 정보를 사용하여 공지사항 업데이트
					managerService.updateNotice(noticeId, title, category, start, end, content, newFiles);

					// 파일 삭제 및 업로드 성공 메시지 반환
					return ResponseEntity.ok("Files updated successfully: " + newFiles);
				} else {
					// 파일이 업로드되지 않았을 경우

					String strOldFiles = notice.getFile();

					JSONParser parser = new JSONParser();

					JSONArray oldFiles = (JSONArray) parser.parse(strOldFiles);

					JSONArray oldFileList = new JSONArray();
					for (int i = 0; i < oldFiles.size(); i++) {
						JSONObject oldFileInfo = (JSONObject) oldFiles.get(i);
						String fileName = oldFileInfo.get("fileName").toString();
						String size = oldFileInfo.get("size").toString();

						JSONObject oldFileObj = new JSONObject();
						oldFileObj.put("fileName", fileName);
						oldFileObj.put("size", size);
						oldFileList.add(oldFileObj);
					}

					managerService.updateNotice(noticeId, title, category, start, end, content, oldFileList);

					// 파일 업로드가 없는 경우에 대한 메시지 반환
					return ResponseEntity.ok("No files updated");
				}

			} else {
				return ResponseEntity.notFound().build();
			}
		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		} catch (ParseException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	// 파일 다운로드
	@GetMapping("/download/{fileName}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {

		InputStream inputStream = s3Service.downloadFile(fileName);

		String fileNameDisposition = "attachment; filename=" + fileName;

		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, fileNameDisposition)
				.body(new InputStreamResource(inputStream));
	}

	/****** 코스 추천 *******/

	@PostMapping("/rec_insert")
	public ModelAndView rec_uploadFile(@RequestPart(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mRequest)
			throws Exception {
		ModelAndView modelAndView = new ModelAndView();

		String idest = request.getParameter("idest");
		String iname = request.getParameter("iname");
		String idis = request.getParameter("idis");
		String idur = request.getParameter("idur");
		String imanager = request.getParameter("imanager");
		String isum = request.getParameter("isum") == null ? "" : request.getParameter("isum").replaceAll("\n", "");
		String idetail = request.getParameter("idetail") == null ? ""
				: request.getParameter("idetail").replaceAll("\n", "");

		// 원본 파일 이름 가져오기
		String Original_fileName = file.getOriginalFilename();
		// 타임스탬프를 포함한 새로운 파일 이름 생성
		String timestamp = String.valueOf(System.currentTimeMillis());
		String fileName = timestamp + "_" + Original_fileName;

		// 업로드할 파일의 메타데이터 설정
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentType(file.getContentType());
		metadata.setContentLength(file.getSize());

		int flag = managerService.recInsert(idest, iname, fileName, idis, idur, imanager, isum, idetail);

		// 파일 업로드하면 uploadPath로 저장됨
		if (!file.isEmpty()) {
			if (flag == 0) {
				// Amazon S3에 파일 업로드
				amazonS3Client.putObject(bucket, fileName, file.getInputStream(), metadata);
			}
		}

		modelAndView.addObject("flag", flag);
		modelAndView.setViewName("manager/mrecommendation_Ok");
		return modelAndView;
	}

	/* 코스 수정 */
	@PostMapping("manager/rec_update.do")
	public ModelAndView rec_update(@RequestParam("uupload") MultipartFile file, HttpServletRequest request)
			throws IllegalStateException, IOException {
		System.out.println("accDB_update.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();

		int uid = Integer.parseInt(request.getParameter("uid"));

		System.out.println("uid : " + uid);
		
		CourseRecommendation rec = courseRecommendationRepository.findById(uid);

		// 기존 파일
		String oldFile = rec.getCourseimage();

		Timestamp udate = rec.getDate();

		String udest = request.getParameter("udest");
		String uname = request.getParameter("uname");
		String udis = request.getParameter("udis");
		String udur = request.getParameter("udur");
		String umanager = request.getParameter("umanager");
		String usummary = request.getParameter("usum") == null ? ""
				: request.getParameter("usum").replaceAll("\n", "");
		String udetail = request.getParameter("udetail") == null ? ""
				: request.getParameter("udetail").replaceAll("\n", "");

		String fileName = file.getOriginalFilename();
		// 타임스탬프를 포함한 새로운 파일 이름 생성
		String timestamp = String.valueOf(System.currentTimeMillis());
		String newFile = timestamp + "_" + fileName;

		System.out.println(newFile);
		int flag;

		if (!file.isEmpty()) {
			// 파일 수정한 경우 :
			// 업로드할 파일의 메타데이터 설정
			ObjectMetadata metadata = new ObjectMetadata();
			metadata.setContentType(file.getContentType());
			metadata.setContentLength(file.getSize());

			// Amazon S3에 파일 업로드
			amazonS3Client.putObject(bucket, newFile, file.getInputStream(), metadata);

			// 기존 파일이 있다면 기존 파일 삭제
			if (oldFile != null && !oldFile.contains("http")) {
			    // Amazon S3에서 파일 삭제
			    amazonS3Client.deleteObject(bucket, oldFile);
			}

			flag = managerService.recUpdate(uid, udate, udest, uname, newFile, udis, udur, umanager, usummary, udetail);

		} else {
			// 파일 수정을 하지 않는 경우 : 기존 파일로
			flag = managerService.recUpdate(uid, udate, udest, uname, oldFile, udis, udur, umanager, usummary, udetail);
		}

		
		modelAndView.addObject("flag", flag);
		modelAndView.setViewName("manager/mrecommendation_Ok");
		return modelAndView;

	}

	/* 코스 삭제 */
	@PostMapping("manager/rec_delete.do")
	public ModelAndView rec_delete(HttpServletRequest request) {
		System.out.println("rec_delete.do 호출 성공");
		ModelAndView modelAndView = new ModelAndView();

		String courseIdString = request.getParameter("courseId");

		try {
			if (courseIdString != null && !courseIdString.isEmpty()) {
				int courseId = Integer.parseInt(courseIdString);
				// System.out.println(courseId);

				CourseRecommendation rec = courseRecommendationRepository.findById(courseId);
				// 기존 파일도 같이 삭제
				String oldFile = rec.getCourseimage();
				// Amazon S3에서 파일 삭제
				amazonS3Client.deleteObject(bucket, oldFile);

				courseRecommendationRepository.deleteById(courseId);
				modelAndView.setViewName("manager/mrecommendation_delete");
			} else {
				// couseId가 null 또는 빈 문자열일 경우 처리
				modelAndView.setViewName("manager/mrecommendation_delete");
			}
		} catch (Exception e) {

			e.printStackTrace();
			modelAndView.setViewName("manager/error_page");
		}

		return modelAndView;
	}
}