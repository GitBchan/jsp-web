<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page import="org.talent.donation.entity.Talent" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>재능 등록 - Talent Sharing Platform</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #e74c3c;
      --background-color: #f8f9fa;
      --text-color: #2c3e50;
      --card-bg-color: #ffffff;
    }

    body {
      font-family: 'Noto Sans KR', sans-serif;
      color: var(--text-color);
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      background-attachment: fixed;
    }

    .page-header {
      background: linear-gradient(
              to right bottom,
              #2980b9,
              #3498db,
              #5dade2
      );
      padding: 4rem 0;
      color: white;
      position: relative;
      overflow: hidden;
    }

    .page-header::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.08'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
      opacity: 0.1;
    }

    .page-header h1 {
      font-size: 2.5rem;
      font-weight: 700;
      margin-bottom: 1rem;
      position: relative;
      z-index: 1;
    }

    .form-container {
      background: white;
      border-radius: 15px;
      padding: 2rem;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
      margin: -50px auto 3rem;
      position: relative;
      z-index: 2;
      max-width: 800px;
    }

    .form-label {
      font-weight: 500;
      color: var(--text-color);
      margin-bottom: 0.5rem;
    }

    .form-control {
      border: 1px solid rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      padding: 0.75rem;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
    }

    textarea.form-control {
      min-height: 150px;
    }

    .error-message {
      color: var(--secondary-color);
      font-size: 0.875rem;
      margin-top: 0.25rem;
      display: none;
    }

    .btn {
      padding: 0.75rem 1.5rem;
      font-weight: 500;
      border-radius: 8px;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background: linear-gradient(135deg, #3498db, #2980b9);
      border: none;
      box-shadow: 0 4px 6px rgba(52, 152, 219, 0.2);
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 12px rgba(52, 152, 219, 0.3);
    }

    .btn-secondary {
      background: var(--background-color);
      color: var(--text-color);
      border: 1px solid rgba(0, 0, 0, 0.1);
    }

    .btn-secondary:hover {
      background: var(--text-color);
      color: white;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .file-upload {
      background: var(--background-color);
      border: 2px dashed rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      padding: 2rem;
      text-align: center;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .file-upload:hover {
      border-color: var(--primary-color);
    }

    .file-upload-text {
      color: #666;
      margin-top: 1rem;
    }
  </style>
</head>
<body>
<%@include file="/includePage/header.jsp"%>

<%
  String tno = request.getParameter("tno");

  TalentRepository repository = new TalentRepository();
  Talent talent = repository.findById(Long.parseLong(tno));

  if (session.getAttribute("loggedInUser") == null) {
    response.sendRedirect("login.jsp");
    return; // 이후 코드 실행을 방지하기 위해 return 추가
  }
%>
<div class="page-header">
  <div class="container text-center">
    <h1>재능 수정하기</h1>
    <p>당신의 특별한 재능을 공유해보세요</p>
  </div>
</div>

<div class="container">
  <div class="form-container">
    <form action="/upload/register_process.jsp" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
      <div class="form-group">
        <label for="title" class="form-label">제목</label>
        <input type="text" id="title" name="title" class="form-control" value="<%=talent.getTitle()%>" required placeholder="재능을 잘 표현할 수 있는 제목을 입력해주세요">
        <div class="error-message" id="titleError">제목을 입력해주세요.</div>
      </div>

      <div class="form-group">
        <label for="category" class="form-label">카테고리</label>
        <select id="category" name="category" class="form-control" required>
          <option value="">카테고리 선택</option>
          <option value="design">디자인</option>
          <option value="programming">프로그래밍</option>
          <option value="marketing">마케팅</option>
          <option value="writing">글쓰기</option>
          <option value="music">음악</option>
          <option value="etc">기타</option>
        </select>
        <div class="error-message" id="categoryError">카테고리를 선택해주세요.</div>
      </div>

      <div class="form-group">
        <label for="description" class="form-label">상세 설명</label>
        <textarea id="description" name="description" class="form-control"  required placeholder="제공하실 재능에 대해 상세히 설명해주세요"><%=talent.getDescription()%></textarea>
        <div class="error-message" id="descriptionError">설명을 입력해주세요.</div>
      </div>

      <div class="form-group">
        <label for="price" class="form-label">가격 (원)</label>
        <input type="number" id="price" name="price" class="form-control" value="<%=talent.getPrice().intValue()%>" required min="0" placeholder="제공하실 재능의 가격을 입력해주세요">
        <div class="error-message" id="priceError">올바른 가격을 입력해주세요.</div>
      </div>

      <div class="form-group">
        <label class="form-label">이미지 업로드</label>
        <div class="file-upload">
          <input type="file" id="image" name="image" accept="image/*" class="d-none">
          <label for="image">
            <i class="bi bi-cloud-upload"></i>
            <div class="file-upload-text">클릭하여 이미지를 업로드하세요</div>
          </label>
        </div>
        <div class="error-message" id="imageError">이미지 파일만 업로드 가능합니다.</div>
      </div>

      <input type="hidden" name="creationDate" value="<%= new java.util.Date() %>">

      <div class="d-flex justify-content-center gap-3 mt-4">
        <button type="submit" class="btn btn-primary">등록하기</button>
        <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
      </div>
    </form>
  </div>
</div>

<%@ include file="/includePage/footer.jsp" %>

<script>
  function validateForm() {
    let isValid = true;
    const title = document.getElementById('title').value;
    const description = document.getElementById('description').value;
    const price = document.getElementById('price').value;
    const category = document.getElementById('category').value;
    const image = document.getElementById('image').value;

    // 제목 검증
    if (title.trim() === '') {
      document.getElementById('titleError').style.display = 'block';
      isValid = false;
    } else {
      document.getElementById('titleError').style.display = 'none';
    }

    // 설명 검증
    if (description.trim() === '') {
      document.getElementById('descriptionError').style.display = 'block';
      isValid = false;
    } else {
      document.getElementById('descriptionError').style.display = 'none';
    }

    // 가격 검증
    if (price <= 0) {
      document.getElementById('priceError').style.display = 'block';
      isValid = false;
    } else {
      document.getElementById('priceError').style.display = 'none';
    }

    // 카테고리 검증
    if (category === '') {
      document.getElementById('categoryError').style.display = 'block';
      isValid = false;
    } else {
      document.getElementById('categoryError').style.display = 'none';
    }

    // 이미지 검증
    if (image !== '') {
      const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
      const fileInput = document.getElementById('image');
      const file = fileInput.files[0];

      if (!allowedTypes.includes(file.type)) {
        document.getElementById('imageError').style.display = 'block';
        isValid = false;
      } else {
        document.getElementById('imageError').style.display = 'none';
      }
    }

    return isValid;
  }

  // 파일 업로드 미리보기
  document.getElementById('image').addEventListener('change', function(e) {
    const fileName = e.target.files[0]?.name ?? '선택된 파일 없음';
    document.querySelector('.file-upload-text').textContent = fileName;
  });
</script>
</body>
</html>