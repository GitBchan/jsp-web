<%@ page import="org.talent.donation.repository.MemberRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - Talent Sharing Platform</title>
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
            padding-top: 60px; /* 헤더 높이만큼 상단 패딩 추가 */
        }

        .login-container {
            max-width: 450px;
            margin: 8rem auto 4rem; /* 상단 여백 증가 */
            padding: 2rem;
        }

        .login-card {
            background: white;
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .login-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-color);
            margin-bottom: 1rem;
        }

        .login-form .form-control {
            padding: 0.8rem 1.2rem;
            border-radius: 10px;
            border: 1px solid #dee2e6;
            margin-bottom: 1rem;
        }

        .login-form .form-control:focus {
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.25);
            border-color: var(--primary-color);
        }

        .login-form .btn-primary {
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

        .login-form .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(41, 128, 185, 0.35);
        }

        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .login-options a {
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .login-options a:hover {
            color: #2980b9;
        }

        .register-link {
            text-align: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #dee2e6;
        }

        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        /* 반응형 조정 */
        @media (max-height: 800px) {
            .login-container {
                margin: 6rem auto 3rem; /* 화면이 작을 때는 여백 줄임 */
            }
        }

        @media (max-height: 600px) {
            .login-container {
                margin: 4rem auto 2rem; /* 더 작은 화면에서 추가 조정 */
            }
        }
    </style>
</head>
<body>
<%@include file="/includePage/header.jsp"%>

<%
    String successMessage = (String) request.getAttribute("success");
    String errorMessage = (String) request.getAttribute("errorMessage");

    if (successMessage != null) {
%>
<script>
    alert("<%=successMessage%>")
</script>

<%
    }

    if (errorMessage != null) {
%>
<script>
    alert("<%=errorMessage%>")
</script>
<%
    }

    if (session.getAttribute("loggedInUser") == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("login_token".equals(cookie.getName())) {
                    String token = cookie.getValue();

                    // 토큰을 통해 사용자를 조회하여 세션에 로그인 정보 설정
                    MemberRepository repository = new MemberRepository();
                    Member member = repository.findByToken(token);
                    if (member != null) {
                        session.setAttribute("loggedInUser", member);
                    }

                    response.sendRedirect("/page/main.jsp");
                }
            }
        }
    }


%>
<main>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1>로그인</h1>
                <p class="text-muted">재능 공유 플랫폼에 오신 것을 환영합니다</p>
            </div>

            <form class="login-form" method="post" action="/action/loginAction.jsp">
                <div class="mb-3">
                    <input type="email" class="form-control" name="id" placeholder="이메일 주소" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="password" placeholder="비밀번호" required>
                </div>

                <div class="login-options">
                    <div class="form-check">
                        <input type="checkbox" name="checked" class="form-check-input" id="remember">
                        <label class="form-check-label" for="remember">로그인 상태 유지</label>
                    </div>
                    <a href="/forgot-password">비밀번호 찾기</a>
                </div>

                <button type="submit" class="btn btn-primary">로그인</button>
            </form>

            <div class="register-link">
                아직 회원이 아니신가요? <a href="/register">회원가입</a>
            </div>
        </div>
    </div>
</main>

</body>
</html>