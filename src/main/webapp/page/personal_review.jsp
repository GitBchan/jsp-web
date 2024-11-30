<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.talent.donation.repository.ReviewRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="java.util.List" %>
<%@ page import="org.talent.donation.dto.ReviewDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>내 리뷰 관리 | Talent Sharing Platform</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-color: #4A90E2;
      --secondary-color: #FF6B6B;
      --background-color: #F5F7FA;
      --text-color: #333333;
      --border-color: #E1E8ED;
      --success-color: #2ECC71;
      --star-color: #FFD700;
      --hover-color: #F8F9FA;
    }

    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: var(--background-color);
      color: var(--text-color);
      line-height: 1.6;
    }

    .review-management {
      padding: 3rem 0;
    }

    .page-title {
      font-size: 2.25rem;
      font-weight: 700;
      color: var(--text-color);
      text-align: center;
      margin-bottom: 2.5rem;
      position: relative;
    }

    .page-title:after {
      content: '';
      display: block;
      width: 60px;
      height: 4px;
      background: var(--primary-color);
      margin: 1rem auto;
      border-radius: 2px;
    }

    .review-container {
      max-width: 900px;
      margin: 0 auto;
    }

    .review-card {
      background: white;
      border-radius: 12px;
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
      margin-bottom: 1.5rem;
      transition: all 0.3s ease;
      border: 1px solid var(--border-color);
      overflow: hidden;
    }

    .review-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.12);
    }

    .review-header {
      padding: 1.25rem;
      border-bottom: 1px solid var(--border-color);
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: white;
    }

    .review-info {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .talent-title {
      font-weight: 500;
      color: var(--text-color);
      margin: 0;
      font-size: 1.1rem;
    }

    .review-date {
      color: #666;
      font-size: 0.9rem;
    }

    .star-rating {
      display: flex;
      gap: 0.25rem;
    }

    .star-rating i {
      color: var(--star-color);
      font-size: 1.1rem;
    }

    .review-content {
      padding: 1.5rem;
      background: white;
    }

    .review-text {
      color: var(--text-color);
      font-size: 1rem;
      margin-bottom: 1.5rem;
      line-height: 1.7;
    }

    .review-actions {
      display: flex;
      gap: 0.75rem;
      justify-content: flex-end;
    }

    .btn {
      padding: 0.5rem 1.25rem;
      border-radius: 8px;
      font-weight: 500;
      font-size: 0.95rem;
      transition: all 0.2s ease;
    }

    .btn-edit {
      background-color: var(--primary-color);
      color: white;
      border: none;
    }

    .btn-edit:hover {
      background-color: #357ABD;
      transform: translateY(-1px);
    }

    .btn-delete {
      background-color: white;
      color: var(--secondary-color);
      border: 1px solid var(--secondary-color);
    }

    .btn-delete:hover {
      background-color: var(--secondary-color);
      color: white;
    }

    .empty-state {
      background: white;
      border-radius: 12px;
      padding: 3rem 2rem;
      text-align: center;
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    }

    .empty-state-icon {
      font-size: 4rem;
      color: var(--primary-color);
      margin-bottom: 1.5rem;
    }

    .empty-state h3 {
      font-weight: 600;
      margin-bottom: 1rem;
    }

    .empty-state-text {
      color: #666;
      margin-bottom: 2rem;
    }

    /* 모달 스타일 개선 */
    .modal-content {
      border-radius: 12px;
      border: none;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }



    .modal-body {
      padding: 2rem;
    }

    .form-label {
      font-weight: 500;
      color: var(--text-color);
      margin-bottom: 0.5rem;
    }

    .form-control {
      border-radius: 8px;
      border: 1px solid var(--border-color);
      padding: 0.75rem;
    }

    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.1);
    }

    .modal-footer {
      padding: 1.25rem;
      border-top: 1px solid var(--border-color);
    }

    .star-rating-input {
      display: flex;
      align-items: center;
      margin-bottom: 1rem;
      position: relative;
      width: 250px;
      height: 50px;
      user-select: none;
    }

    .star-container {
      display: flex;
      width: 100%;
      height: 100%;
    }

    .star {
      width: 20%;
      height: 100%;
      cursor: pointer;
    }

    .star-fill {
      transition: clip-path 0.3s ease-in-out;
    }

    .rating-slider {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      opacity: 0;
      cursor: pointer;
    }

    .current-rating {
      margin-left: 15px;
      font-size: 24px;
      font-weight: bold;
    }


  </style>
</head>
<body>
<%@include file="/includePage/header.jsp"%>

<%
  Member member = (Member) session.getAttribute("loggedInUser");
  ReviewRepository repository = new ReviewRepository();
  List<ReviewDTO> reviewList = repository.getAllReviews(member.getMno());
  if (reviewList.isEmpty()) {
    System.out.println("empty");
  }else {
    System.out.println("not empty");
  }
  request.setAttribute("reviewList", reviewList);
%>

<main class="review-management">
  <div class="container review-container">
    <h1 class="page-title">내 리뷰 관리</h1>

    <!-- Empty State -->
    <c:if test="${empty reviewList}">
      <div class="empty-state">
        <div class="empty-state-icon">
          <i class="fas fa-pen-to-square"></i>
        </div>
        <h3>작성한 리뷰가 없습니다</h3>
        <p class="empty-state-text">구매하신 재능에 대한 리뷰를 작성하고<br>다른 사용자들과 경험을 공유해보세요!</p>
        <a href="/page/personal_purchase.jsp" class="btn btn-primary btn-lg">구매 내역 보기</a>
      </div>
    </c:if>

    <!-- Review List -->
    <c:forEach var="review" items="${reviewList}">
      <div class="review-card shadow-sm rounded-lg p-4 mb-4 bg-white">
        <div class="d-flex justify-content-between align-items-start">
          <div class="review-info">
            <h3 class="talent-title h5 mb-1 fw-bold">${review.title}</h3>
            <div class="d-flex align-items-center gap-3">
              <span class="review-date text-muted small">${review.createdAt}</span>
              <div class="star-rating">
                <c:forEach begin="1" end="5" var="i">
                  <c:choose>
                    <c:when test="${i <= review.rating.intValue()}">
                      <!-- 정수 부분에 해당하는 전체 별 -->
                      <i class="fas fa-star text-warning"></i>
                    </c:when>
                    <c:when test="${i == review.rating.intValue() + 1 && review.rating.floatValue() - review.rating.intValue() >= 0.5}">
                      <!-- 소수 부분이 .5 이상일 때 반개 별 -->
                      <i class="fas fa-star-half-alt text-warning"></i>
                    </c:when>
                    <c:otherwise>
                      <!-- 나머지 빈 별 -->
                      <i class="far fa-star text-muted"></i>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
                  ${review.rating.floatValue()}
              </div>
            </div>
          </div>
          <div class="review-actions d-flex gap-2">
            <button class="modify-button btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#ReviewModal"
                    data-review-id="${review.reviewId}" data-rating="${review.rating}">
              <i class="fas fa-pencil-alt me-1"></i>수정하기
            </button>
            <button class="btn btn-outline-danger btn-sm" onclick="">
              <i class="fas fa-trash-alt me-1"></i>삭제하기
            </button>
          </div>
        </div>
      </div>

    </c:forEach>
  </div>
</main>

<!-- Edit Review Modal -->
<div class="modal fade" id="ReviewModal" tabindex="-1" aria-labelledby="editReviewModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editReviewModalLabel">리뷰 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="editReviewForm" method="post" action="/action/personal_reviewAction.jsp">
        <div class="modal-body">
          <div class="mb-3">
            <label for="starRating" class="form-label">평점</label>
            <div class="d-flex align-items-center">
              <div class="star-rating-input" id="starRating">
                <div class="star-container">
                  <svg class="star" viewBox="0 0 51 48" data-rating="1">
                    <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    <path class="star-fill" fill="#ffc107"
                          d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                  </svg>
                  <svg class="star" viewBox="0 0 51 48" data-rating="2">
                    <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    <path class="star-fill" fill="#ffc107"
                          d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                  </svg>
                  <svg class="star" viewBox="0 0 51 48" data-rating="3">
                    <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    <path class="star-fill" fill="#ffc107"
                          d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                  </svg>
                  <svg class="star" viewBox="0 0 51 48" data-rating="4">
                    <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    <path class="star-fill" fill="#ffc107"
                          d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                  </svg>
                  <svg class="star" viewBox="0 0 51 48" data-rating="5">
                    <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    <path class="star-fill" fill="#ffc107"
                          d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                  </svg>
                </div>
                <input type="range" class="rating-slider" id="ratingSlider" min="0" max="5"
                       step="0.1" value="0">
              </div>
              <span class="current-rating" aria-live="polite">0.0</span>
            </div>
            <input type="hidden" name="rating" id="ratingInput" value="0">
            <input type="hidden" name="reviewId" id="reviewIdField">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="submit" class="btn btn-primary" id="submitReview">수정하기</button>
        </div>
      </form>

    </div>
  </div>
</div>

<%@ include file="/includePage/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script>
  // 별점 입력 처리
  const stars = document.querySelectorAll('.star-rating-input i');
  stars.forEach(star => {
    star.addEventListener('click', (e) => {
      const rating = e.target.dataset.rating;
      document.getElementById('ratingInput').value = rating;

      stars.forEach(s => {
        const sRating = s.dataset.rating;
        s.className = `fas fa-star ${sRating <= rating ? 'active' : ''}`;
      });
    });
  });


  document.addEventListener('DOMContentLoaded', function () {

    const reviewButtons = document.querySelectorAll(".modify-button");

    reviewButtons.forEach(button => {
      button.addEventListener("click", function () {
        const reviewId = button.getAttribute("data-review-id");
        const rating = parseFloat(button.getAttribute("data-rating"));

        document.getElementById("reviewIdField").value = reviewId;
        document.getElementById("ratingInput").value = rating;

        updateRating(rating)
      });
    });

    const starRating = document.getElementById('starRating');
    const ratingInput = document.getElementById('ratingInput');
    const ratingSlider = document.getElementById('ratingSlider');
    const starFills = starRating.querySelectorAll('.star-fill');
    const currentRating = document.querySelector('.current-rating');

    // 별의 채우기 상태를 업데이트하는 함수 (반개 단위로 조정)
    function updateStars(rating) {
      const fullStars = Math.floor(rating); // 채워야 할 전체 별 개수
      const isHalfStar = (rating - fullStars) >= 0.5; // 반개 채울지 여부

      starFills.forEach((starFill, index) => {
        if (index < fullStars) {
          starFill.style.clipPath = 'inset(0 0 0 0)'; // 100% 채움
        } else if (index === fullStars && isHalfStar) {
          starFill.style.clipPath = 'inset(0 50% 0 0)'; // 반개 채움
        } else {
          starFill.style.clipPath = 'inset(0 100% 0 0)'; // 빈 상태
        }
      });
    }

    function updateRating(rating) {
      rating = Math.max(0, Math.min(5, parseFloat(rating)));
      ratingInput.value = rating;
      ratingSlider.value = rating;
      currentRating.textContent = rating.toFixed(1);
      updateStars(rating);
    }

    // 슬라이더로 드래그할 때 별 채우기 업데이트
    ratingSlider.addEventListener('input', function () {
      updateRating(this.value);
    });

    // 별 클릭으로 평점 설정
    starFills.forEach((star, index) => {
      star.parentElement.addEventListener('click', function () {
        const rating = index + 1;
        updateRating(rating);
      });
    });

    document.getElementById('submitReview').addEventListener('click', function () {
      const rating = parseFloat(ratingInput.value);
      const content = document.getElementById('reviewContent').value;
      console.log(`제출된 평점: ${rating}, 내용: ${content}`);
      // 여기에 서버로 데이터를 보내는 코드를 추가할 수 있습니다.
      // 예: fetch('/api/reviews', { method: 'POST', body: JSON.stringify({ rating, content }) })
    });
  })


</script>
</body>
</html>