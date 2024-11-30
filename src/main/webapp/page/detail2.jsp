<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page import="org.talent.donation.entity.Talent" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.repository.MemberRepository" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>디지털 일러스트레이션 재능 상세</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">

  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #2980b9;
      --accent-color: #e8f4fc;
      --text-color: #2c3e50;
      --light-text-color: #7f8c8d;
    }

    body {
      font-family: 'Inter', sans-serif;
      background-color: #f9fafb;
      color: var(--text-color);
    }

    .talent-header {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      padding: 4rem 0;
    }

    /* .talent-header::before 스타일 제거 */

    .talent-content {
      background: white;
      border-radius: 1rem;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
      padding: 2rem;
      margin-top: -4rem;
      position: relative;
    }

    .portfolio-image {
      border-radius: 0.5rem;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .portfolio-image:hover {
      transform: scale(1.02);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }


    .price-badge {
      background-color: var(--secondary-color);
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 2rem;
      font-weight: 600;
    }

    .star-rating {
      display: inline-flex;
      align-items: center;
      color: #fbbf24;
    }

    .booking-container {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 2rem;
      background-color: var(--accent-color);
      border-radius: 0.5rem;
      padding: 2rem;
      margin-top: 2rem;
    }

    .provider-profile {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .provider-profile img {
      width: 64px;
      height: 64px;
      border-radius: 50%;
      object-fit: cover;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-primary:hover {
      background-color: var(--secondary-color);
      border-color: var(--secondary-color);
    }

    .btn-outline-primary {
      color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-outline-primary:hover {
      background-color: var(--primary-color);
      color: white;
    }

    .btn-group-vertical .btn {
      text-align: left;
      padding: 0.5rem 1rem;
      border-radius: 0.25rem !important;
      margin-bottom: 0.5rem;
    }
  </style>
</head>

<%
  Long tno = Long.parseLong(request.getParameter("tno"));
  TalentRepository repository = new TalentRepository();
  Talent talent = repository.findById(tno);

  MemberRepository memberRepository = new MemberRepository();
  Member talentOwner = memberRepository.findByMno(talent.getMemberId());

  request.setAttribute("talent", talent);
  request.setAttribute("talentOwner", talentOwner);
%>
<body>
<!-- 재능 헤더 -->
<header class="talent-header text-center">
  <div class="container position-relative">
    <h1 class="display-4 fw-bold mb-3">프로페셔널 디지털 일러스트레이션</h1>
    <div class="d-flex justify-content-center align-items-center">
      <div class="star-rating me-2">
        <i class="bi bi-star-fill"></i>
        <i class="bi bi-star-fill"></i>
        <i class="bi bi-star-fill"></i>
        <i class="bi bi-star-fill"></i>
        <i class="bi bi-star-half"></i>
      </div>
      <span class="text-white">(4.5/5점, 128개의 평가)</span>
    </div>
  </div>
</header>

<div class="container">
  <div class="talent-content">
    <div class="row g-4">
      <!-- 포트폴리오 이미지 -->
      <div class="col-lg-6">
        <div id="portfolioCarousel" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img src="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80" class="d-block w-100 portfolio-image" alt="포트폴리오 이미지 1">
            </div>
            <div class="carousel-item">
              <img src="https://images.unsplash.com/photo-1620121692029-d088224ddc74?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2832&q=80" class="d-block w-100 portfolio-image" alt="포트폴리오 이미지 2">
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#portfolioCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">이전</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#portfolioCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">다음</span>
          </button>
        </div>
      </div>

      <!-- 재능 정보 -->
      <div class="col-lg-6">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <span class="badge bg-primary rounded-pill px-3 py-2"><%=talent.getCategory()%></span>
          <span class="price-badge">₩<%=talent.getPrice().intValue()%>부터</span>
        </div>

        <h2 class="h3 mb-4"><%=talent.getTitle()%>></h2>
        <p class="lead mb-4"><%=talent.getDescription()%></p>
      </div>
    </div>

    <!-- 예약 및 제공자 섹션 -->
    <div class="booking-container mt-5">
      <!-- 제공자 정보 -->
      <div class="provider-profile">
        <img src="/uploads/<%=talentOwner.getFileName()%>" alt="제공자 프로필">
        <div>
          <h4 class="mb-1"><%=talentOwner.getName()%></h4>
        </div>
      </div>

      <!-- 예약 섹션 -->
      <div class="calendar-section">
        <h3 class="h4 mb-3">날짜 및 시간 선택</h3>
        <div class="mb-3">
          <label for="datePicker" class="form-label">날짜 선택</label>
          <input type="date" class="form-control" id="datePicker">
        </div>
        <div>
          <label class="form-label d-block mb-2">시간 선택</label>
          <div class="btn-group-vertical w-100" role="group">
            <input type="radio" class="btn-check" name="timeOption" id="time-09-11" value="1" autocomplete="off">
            <label class="btn btn-outline-primary text-start" for="time-09-11">09:00 - 11:00</label>

            <input type="radio" class="btn-check" name="timeOption" id="time-11-13" value="2" autocomplete="off">
            <label class="btn btn-outline-primary text-start" for="time-11-13">11:00 - 13:00</label>

            <input type="radio" class="btn-check" name="timeOption" id="time-13-15" value="3" autocomplete="off">
            <label class="btn btn-outline-primary text-start" for="time-13-15">13:00 - 15:00</label>

            <input type="radio" class="btn-check" name="timeOption" id="time-15-17" value="4" autocomplete="off">
            <label class="btn btn-outline-primary text-start" for="time-15-17">15:00 - 17:00</label>

            <input type="radio" class="btn-check" name="timeOption" id="time-17-19" value="5" autocomplete="off">
            <label class="btn btn-outline-primary text-start" for="time-17-19">17:00 - 19:00</label>
          </div>
        </div>
      </div>
    </div>


    <!-- 문의하기 모달 -->
    <div class="modal fade" id="inquiryModal" tabindex="-1" aria-labelledby="inquiryModalLabel" aria-hidden="true">
      <form method="post" action="/action/detail_modalAction.jsp">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="inquiryModalLabel">재능에 대해 문의하기</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form>
                <div class="mb-3">
                  <label for="inquiryMessage" class="form-label">문의 내용</label>
                  <textarea class="form-control" name="inquiryMessage" id="inquiryMessage" rows="3" placeholder="문의 내용을 작성해주세요."></textarea>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
              <button type="button" class="btn btn-primary">제출</button>
            </div>
          </div>
        </div>
      </form>
    </div>

    <!-- 문의 및 구매 버튼 -->
    <div class="mt-5 text-center">
      <button class="btn btn-primary btn-lg me-3 px-4 py-2" data-bs-toggle="modal" data-bs-target="#inquiryModal" data-bs-backdrop="static">
        <i class="bi bi-chat-dots me-2"></i>문의하기
      </button>
      <button class="btn btn-success btn-lg px-4 py-2">
        <i class="bi bi-cart me-2"></i>구매하기
      </button>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

</body>
</html>
