<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>리뷰 수정 | Talent Sharing Platform</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
  <style>
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
<div class="container mt-5">
  <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editReviewModal">
    리뷰 수정하기
  </button>

  <!-- 리뷰 수정 모달 -->
  <div class="modal fade" id="editReviewModal" tabindex="-1" aria-labelledby="editReviewModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editReviewModalLabel">리뷰 수정</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="editReviewForm">
            <div class="mb-3">
              <label for="starRating" class="form-label">평점</label>
              <div class="d-flex align-items-center">
                <div class="star-rating-input" id="starRating">
                  <div class="star-container">
                    <svg class="star" viewBox="0 0 51 48" data-rating="1">
                      <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                      <path class="star-fill" fill="#ffc107" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    </svg>
                    <svg class="star" viewBox="0 0 51 48" data-rating="2">
                      <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                      <path class="star-fill" fill="#ffc107" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    </svg>
                    <svg class="star" viewBox="0 0 51 48" data-rating="3">
                      <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                      <path class="star-fill" fill="#ffc107" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    </svg>
                    <svg class="star" viewBox="0 0 51 48" data-rating="4">
                      <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                      <path class="star-fill" fill="#ffc107" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    </svg>
                    <svg class="star" viewBox="0 0 51 48" data-rating="5">
                      <path fill="#ddd" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                      <path class="star-fill" fill="#ffc107" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
                    </svg>
                  </div>
                  <input type="range" class="rating-slider" id="ratingSlider" min="0" max="5" step="0.1" value="0">
                </div>
                <span class="current-rating" aria-live="polite">0.0</span>
              </div>
              <input type="hidden" name="rating" id="ratingInput" value="0">
            </div>
            <div class="mb-3">
              <label for="reviewContent" class="form-label">리뷰 내용</label>
              <textarea class="form-control" id="reviewContent" name="content" rows="5" required></textarea>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary" id="submitReview">수정하기</button>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const starRating = document.getElementById('starRating');
    const ratingInput = document.getElementById('ratingInput');
    const ratingSlider = document.getElementById('ratingSlider');
    const starFills = starRating.querySelectorAll('.star-fill');
    const currentRating = document.querySelector('.current-rating');
    const stars = starRating.querySelectorAll('.star');

    function updateRating(rating) {
      rating = Math.max(0, Math.min(5, parseFloat(rating)));
      const percent = (rating / 5) * 100;
      starFills.forEach((starFill, index) => {
        const starPercent = Math.max(0, Math.min(100, percent - index * 20));
        starFill.style.clipPath = `inset(0 ${100 - starPercent}% 0 0)`;
      });
      ratingInput.value = rating;
      ratingSlider.value = rating;
      currentRating.textContent = rating.toFixed(1);
    }

    ratingSlider.addEventListener('input', function() {
      updateRating(this.value);
    });

    ratingSlider.addEventListener('change', function() {
      updateRating(this.value);
    });

    stars.forEach(star => {
      star.addEventListener('click', function() {
        const rating = this.getAttribute('data-rating');
        updateRating(rating);
      });
    });

    document.getElementById('submitReview').addEventListener('click', function() {
      const rating = parseFloat(ratingInput.value);
      const content = document.getElementById('reviewContent').value;
      console.log(`제출된 평점: ${rating}, 내용: ${content}`);
      // 여기에 서버로 데이터를 보내는 코드를 추가할 수 있습니다.
      // 예: fetch('/api/reviews', { method: 'POST', body: JSON.stringify({ rating, content }) })
    });
  });
</script>
</body>
</html>