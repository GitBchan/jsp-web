<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  .footer {
    background-color: var(--secondary-color);
    padding: 3rem 0;
    margin-top: 4rem;
  }

  .footer-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
  }

  .footer-section h3 {
    color: var(--primary-color);
    margin-bottom: 1rem;
    font-size: 1.2rem;
  }

  .footer-section p,
  .footer-section a {
    color: var(--text-color);
    text-decoration: none;
    line-height: 1.6;
  }

  .footer-section ul {
    list-style: none;
  }

  .footer-section ul li {
    margin-bottom: 0.5rem;
  }

  .social-links {
    display: flex;
    gap: 1rem;
    margin-top: 1rem;
  }

  .social-links a {
    color: var(--primary-color);
    font-size: 1.5rem;
  }

  .bottom-footer {
    text-align: center;
    padding-top: 2rem;
    margin-top: 2rem;
    border-top: 1px solid #eee;
  }
</style>

<footer class="footer">
  <div class="footer-container">
    <div class="footer-section">
      <h3>재능교환 플랫폼</h3>
      <p>서로의 재능을 나누며 성장하는 공간</p>
      <div class="social-links">
        <a href="#"><i class="fab fa-facebook"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
        <a href="#"><i class="fab fa-instagram"></i></a>
      </div>
    </div>
    <div class="footer-section">
      <h3>바로가기</h3>
      <ul>
        <li><a href="/about">소개</a></li>
        <li><a href="/how-it-works">이용방법</a></li>
        <li><a href="/talents">재능 목록</a></li>
        <li><a href="/success-stories">성공사례</a></li>
      </ul>
    </div>
    <div class="footer-section">
      <h3>고객지원</h3>
      <ul>
        <li><a href="/faq">자주묻는질문</a></li>
        <li><a href="/contact">문의하기</a></li>
        <li><a href="/terms">이용약관</a></li>
        <li><a href="/privacy">개인정보처리방침</a></li>
      </ul>
    </div>
  </div>
  <div class="bottom-footer">
    <p>&copy; 2024 재능교환 플랫폼. All rights reserved.</p>
  </div>
</footer>

<script>
  // 모바일 메뉴 토글
  document.querySelector('.hamburger').addEventListener('click', function() {
    const mobileMenu = document.querySelector('.mobile-menu');
    mobileMenu.classList.toggle('active');
  });
</script>
</body>
</html>