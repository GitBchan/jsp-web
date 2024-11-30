<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.repository.TransactionRepository" %>
<%@ page import="org.talent.donation.entity.Transaction" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="org.talent.donation.dto.TransactionDTO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>구매 내역 | Talent Sharing Platform</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
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

    .purchase-history {
      padding: 4rem 0;
    }

    .page-title {
      font-size: 2.5rem;
      font-weight: 700;
      text-align: center;
      margin-bottom: 3rem;
      color: var(--text-color);
    }

    .purchase-card {
      background: white;
      border-radius: 15px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      margin-bottom: 1.5rem;
      overflow: hidden;
    }

    .purchase-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    }

    .purchase-header {
      background: linear-gradient(135deg, var(--primary-color), #2980b9);
      color: white;
      padding: 1rem 1.5rem;
    }

    .purchase-date {
      font-size: 0.9rem;
      opacity: 0.9;
    }

    .purchase-content {
      padding: 1.5rem;
    }

    .purchase-title {
      font-size: 1.25rem;
      font-weight: 500;
      margin-bottom: 1rem;
      color: var(--text-color);
    }

    .purchase-info {
      color: #666;
      margin-bottom: 0.5rem;
    }

    .btn-review {
      background: var(--primary-color);
      color: white;
      border: none;
      padding: 0.5rem 1.5rem;
      border-radius: 25px;
      transition: all 0.3s ease;
    }

    .btn-review:hover {
      background: #2980b9;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      color: white;
    }

    .btn-details {
      background: transparent;
      color: var(--primary-color);
      border: 2px solid var(--primary-color);
      padding: 0.5rem 1.5rem;
      border-radius: 25px;
      transition: all 0.3s ease;
    }

    .btn-details:hover {
      background: var(--primary-color);
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .review-status {
      font-size: 0.9rem;
      color: #666;
      padding: 0.5rem 1rem;
      border-radius: 20px;
      background: #f8f9fa;
      display: inline-block;
    }

    .action-buttons {
      display: flex;
      gap: 1rem;
      margin-top: 1.5rem;
    }

    .empty-state {
      text-align: center;
      padding: 4rem 2rem;
      background: white;
      border-radius: 15px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .empty-state-icon {
      font-size: 4rem;
      color: var(--primary-color);
      margin-bottom: 1.5rem;
    }

    .empty-state-text {
      font-size: 1.2rem;
      color: #666;
      margin-bottom: 2rem;
    }


    .transaction-card {
      background: white;
      border-radius: 16px;
      box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      overflow: hidden;
      position: relative;
    }

    .transaction-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 4px 25px rgba(0, 0, 0, 0.12);
    }

    .transaction-status-bar {
      padding: 1rem 1.5rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #f0f0f0;
    }

    .status-indicator {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      font-weight: 500;
      font-size: 0.9rem;
    }

    .status-dot {
      width: 8px;
      height: 8px;
      border-radius: 50%;
    }

    .status-indicator.pending .status-dot {
      background-color: #ffc107;
    }

    .status-indicator.confirmed .status-dot {
      background-color: #28a745;
    }

    .status-indicator.completed .status-dot {
      background-color: #0d6efd;
    }

    .status-indicator.available .status-dot {
      background-color: #dc3545;
    }

    .transaction-date {
      color: #6c757d;
      font-size: 0.9rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .transaction-content {
      padding: 1.5rem;
    }

    .talent-info {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 1.25rem;
    }

    .talent-title {
      font-size: 1.25rem;
      font-weight: 600;
      color: #2c3e50;
      margin: 0;
      flex: 1;
      padding-right: 1rem;
    }

    .price-tag {
      background: #f8f9fa;
      padding: 0.5rem 1rem;
      border-radius: 8px;
      color: #2c3e50;
      font-weight: 500;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .schedule-info {
      display: flex;
      align-items: flex-start;
      gap: 1rem;
      padding: 1rem;
      background: #f8f9fa;
      border-radius: 12px;
    }

    .schedule-info i {
      font-size: 1.25rem;
      color: #6c757d;
    }

    .schedule-details {
      flex: 1;
    }

    .schedule-date {
      font-weight: 500;
      color: #2c3e50;
      margin-bottom: 0.25rem;
    }

    .schedule-time {
      color: #6c757d;
      font-size: 0.9rem;
    }

    .transaction-footer {
      padding: 1rem 1.5rem;
      background: #f8f9fa;
      border-top: 1px solid #f0f0f0;
      display: flex;
      justify-content: flex-end;
    }

    .review-button {
      background: #0d6efd;
      color: white;
      border: none;
      padding: 0.5rem 1.25rem;
      border-radius: 8px;
      font-weight: 500;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      transition: background-color 0.2s ease;
    }

    .review-button:hover {
      background: #0b5ed7;
    }

    .completed-label, .review-complete {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      color: #6c757d;
      font-size: 0.9rem;
    }

    .completed-label i, .review-complete i {
      color: #28a745;
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
<%
  Member loggedInUser = (Member) session.getAttribute("loggedInUser");

  if (loggedInUser == null) {
    response.sendRedirect("/page/login.jsp");
    return;
  }

  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
  Long id = loggedInUser.getMno();

  TransactionRepository repository = new TransactionRepository();
  List<TransactionDTO> purchaseList = repository.findAllByBuyerId(id);
%>
<body>
<%@include file="/includePage/header.jsp" %>

<main class="purchase-history">
  <div class="container">
    <h1 class="page-title">구매 내역</h1>

    <%
      if (purchaseList == null || purchaseList.isEmpty()) {
    %>
    <div class="empty-state">
      <div class="empty-state-icon">🛍️</div>
      <h3>아직 구매 내역이 없습니다</h3>
      <p class="empty-state-text">다양한 전문가들의 재능을 둘러보고 새로운 경험을 시작해보세요!</p>
      <a href="/page/list.jsp" class="btn btn-primary btn-lg rounded-pill">재능 둘러보기</a>
    </div>
    <%
    } else {
    %>
    <div class="row">
      <% for (TransactionDTO purchase : purchaseList) { %>
      <div class="col-md-6 mb-4">
        <div class="transaction-card">
          <div class="transaction-status-bar">
            <div class="status-indicator <%= purchase.getStatus().toLowerCase() %>">
              <div class="status-dot"></div>
              <%
                String statusText = "";
                switch (purchase.getStatus()) {
                  case "PENDING":
                    statusText = "대기 중";
                    break;
                  case "CONFIRMED":
                    statusText = "확정";
                    break;
                  case "COMPLETED":
                    statusText = "완료";
                    break;
                  case "AVAILABLE":
                    statusText = "취소";
                    break;
                  default:
                    statusText = "알 수 없음";
                }
              %>
              <span><%= statusText %></span>
            </div>
            <div class="transaction-date">
              <i class="bi bi-calendar3"></i>
              <%= ((LocalDateTime) purchase.getTransactionDate()).format(formatter) %>
            </div>
          </div>

          <div class="transaction-content">
            <div class="talent-info">
              <h3 class="talent-title"><%= purchase.getTalentTitle() %>
              </h3>
              <div class="price-tag">
                <i class="bi bi-cash"></i>
                <%= purchase.getAmount().intValue() %>원
              </div>
            </div>

            <% if (purchase.getScheduledDate() != null) {
              String timeSlot = "";
              switch (purchase.getTimeSlot()) {
                case "1":
                  timeSlot = "09:00 - 11:00";
                  break;
                case "2":
                  timeSlot = "11:00 - 13:00";
                  break;
                case "3":
                  timeSlot = "13:00 - 15:00";
                  break;
                case "4":
                  timeSlot = "15:00 - 17:00";
                  break;
                case "5":
                  timeSlot = "17:00 - 19:00";
                  break;
              }
            %>
            <div class="schedule-info">
              <i class="bi bi-clock"></i>
              <div class="schedule-details">
                <div class="schedule-date"><%= ((LocalDateTime) purchase.getScheduledDate()).format(formatter) %>
                </div>
                <div class="schedule-time"><%= timeSlot %>
                </div>
              </div>
            </div>
            <% } %>
          </div>

          <div class="transaction-footer">
            <% if (!purchase.getScheduledDate().isAfter(LocalDateTime.now())) { %>
            <div class="completed-label">
              <i class="bi bi-check-circle-fill"></i>
              거래 완료
            </div>
            <% if (purchase.getReviewId() == null) { %>
            <button class="review-button" data-bs-toggle="modal" data-bs-target="#ReviewModal"
                    data-transaction-id="<%=purchase.getTransactionId()%>"
                    data-talent-id="<%=purchase.getTalentId()%>">
              <i class="bi bi-star"></i>
              리뷰 작성하기
            </button>
            <% } else { %>
            <div class="review-complete">
              <i class="bi bi-check2-circle"></i>
              리뷰 작성 완료
            </div>
            <% } %>

            <%
              }
            %>

          </div>
        </div>
      </div>
      <% } %>
    </div>
    <%
      }
    %>
  </div>


  <div class="modal fade" id="ReviewModal" tabindex="-1" aria-labelledby="editReviewModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editReviewModalLabel">리뷰 작성</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form id="editReviewForm" method="post" action="/action/personal_purchaseAction.jsp">
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
              <input type="hidden" name="transactionId" id="transactionIdField">
              <input type="hidden" name="talentId" id="talentIdField">
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            <button type="submit" class="btn btn-primary" id="submitReview">작성하기</button>
          </div>
        </form>

      </div>
    </div>
  </div>

</main>

<%@ include file="/includePage/footer.jsp" %>
</body>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

<script>
  document.addEventListener('DOMContentLoaded', function () {

    const reviewButtons = document.querySelectorAll(".review-button");
    reviewButtons.forEach(button => {
      button.addEventListener("click", function () {
        const transactionId = button.getAttribute("data-transaction-id");
        const talentId = button.getAttribute("data-talent-id");
        document.getElementById("transactionIdField").value = transactionId;
        document.getElementById("talentIdField").value = talentId;
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
  });

</script>
</html>