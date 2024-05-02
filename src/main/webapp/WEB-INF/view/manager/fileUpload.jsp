<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
     <title>자바스크립트를 사용한 파일 업로드 폼 다루기</title>
</head>
<body>
     <h1>파일 업로드 예제</h1>
     <form id="uploadForm">
     <input type="file" id="fileInput" accept="image/*">
     <img id="preview" src="#" alt="이미지 미리보기" style="display:none;">
     <button type="submit">업로드</button>
     </form>

     <script>
     
     const fileInput = document.getElementById('fileInput');
     const preview = document.getElementById('preview');
     const uploadForm = document.getElementById('uploadForm');

     // 파일 미리보기 기능 구현
     fileInput.addEventListener('change', (event) => {
     const file = event.target.files[0];
     const reader = new FileReader();

     reader.onload = (e) => {
          preview.src = e.target.result;
          preview.style.display = 'block';
     };

     reader.readAsDataURL(file);
     });

     // 파일 업로드 기능 구현
     uploadForm.addEventListener('submit', (event) => {
     event.preventDefault();

     // 이 부분에서 서버로 파일을 전송하는 로직을 구현해야 합니다.
     // 예를 들어, FormData 객체를 사용하여 AJAX 요청을 보낼 수 있습니다.
     const formData = new FormData(uploadForm);
     formData.append('file', fileInput.files[0]);

     // 이후 서버로 formData를 전송하는 AJAX 요청을 작성하십시오.
     });

     </script>
</body>
</html>