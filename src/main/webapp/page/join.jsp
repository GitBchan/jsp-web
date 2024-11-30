<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입 - Talent Sharing Platform</title>
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
      min-height: 100vh;
      padding-top: 60px;
    }

    .register-container {
      max-width: 450px;
      margin: 8rem auto 4rem;
      padding: 2rem;
    }

    .register-card {
      background: white;
      border-radius: 15px;
      padding: 2.5rem;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(0, 0, 0, 0.05);
    }

    .register-header {
      text-align: center;
      margin-bottom: 2.5rem;
    }

    .register-header h1 {
      font-size: 2rem;
      font-weight: 700;
      color: var(--text-color);
      margin-bottom: 1rem;
    }

    .register-form .form-control {
      padding: 0.8rem 1.2rem;
      border-radius: 10px;
      border: 1px solid #dee2e6;
      margin-bottom: 1rem;
    }

    .register-form .form-control:focus {
      box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.25);
      border-color: var(--primary-color);
    }

    .register-form .btn-primary {
      background: linear-gradient(
              to right bottom,
              #2980b9,
              #3498db
      );
      border: none;
      padding: 0.8rem;
      font-weight: 500;
      border-radius: 10px;
      width: 100%;
      margin-top: 1.5rem;
      transition: all 0.3s ease;
    }

    .register-form .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(41, 128, 185, 0.35);
    }

    .login-link {
      text-align: center;
      margin-top: 2rem;
      padding-top: 2rem;
      border-top: 1px solid #dee2e6;
    }

    .login-link a {
      color: var(--primary-color);
      text-decoration: none;
      font-weight: 500;
    }

    /* 반응형 조정 */
    @media (max-height: 800px) {
      .register-container {
        margin: 6rem auto 3rem;
      }
    }

    @media (max-height: 600px) {
      .register-container {
        margin: 4rem auto 2rem;
      }
    }
  </style>
</head>
<body>
<%@include file="/includePage/header.jsp"%>

<main>
  <div class="register-container">
    <div class="register-card">
      <div class="register-header">
        <h1>회원가입</h1>
        <p class="text-muted">새로운 재능 공유의 시작</p>
      </div>

      <form class="register-form" method="post" action="/action/joinAction.jsp">
        <div class="mb-3">
          <input type="text" class="form-control" id="name" name="name" placeholder="이름" required>
        </div>
        <div class="mb-3">
          <input type="email" class="form-control" id="id" name="id" placeholder="이메일 주소" required>
        </div>
        <div class="mb-3">
          <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
        </div>

        <button type="submit" class="btn btn-primary">회원가입</button>
      </form>

      <div class="login-link">
        이미 계정이 있으신가요? <a href="login.jsp">로그인</a>
      </div>
    </div>
  </div>
</main>

</body>
</html>