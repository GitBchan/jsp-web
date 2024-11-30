<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재능 교환 플랫폼</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4A90E2;
            --secondary-color: #F7F9FC;
            --text-color: #333333;
            --light-gray: #F5F5F5;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        .header {
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary-color);
            text-decoration: none;
        }

        .nav-menu {
            display: flex;
            gap: 2rem;
            list-style: none;
        }

        .nav-menu a {
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-menu a:hover {
            color: var(--primary-color);
        }

        .auth-buttons {
            display: flex;
            gap: 1rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-login {
            background-color: var(--secondary-color);
            color: var(--primary-color);
        }

        .btn-register {
            background-color: var(--primary-color);
            color: white;
        }

        .hamburger {
            display: none;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .nav-menu {
                display: none;
            }

            .auth-buttons {
                display: none;
            }

            .hamburger {
                display: block;
            }

            .mobile-menu {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background-color: white;
                padding: 1rem;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .mobile-menu.active {
                display: block;
            }
        }
    </style>
</head>
<body>
<header class="header">
    <div class="header-container">
        <a href="/page/main.jsp" class="logo">
            <i class="fas fa-exchange-alt"></i> 사고팜!
        </a>
        <nav>
            <ul class="nav-menu">
                <li><a href="/page/list.jsp">목록</a></li>
                <li><a href="/page/register.jsp">등록하기</a></li>
                <li><a href="/page/personal.jsp">프로필</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <%
                // 세션에 loggedInUser가 존재하는지 확인
                if (session.getAttribute("loggedInUser") != null) {
            %>
            <!-- 로그아웃 버튼 -->
            <button class="btn btn-register">
                <a href="/action/logoutAction.jsp" style="text-decoration: none; color: white;">로그아웃</a>
            </button>
            <%
            } else {
            %>
            <!-- 로그인 및 회원가입 버튼 -->
            <button class="btn btn-login">
                <a href="/page/login.jsp" style="text-decoration: none; color: var(--primary-color);">로그인</a>
            </button>
            <button class="btn btn-register">
                <a href="/page/join.jsp" style="text-decoration: none; color: white;">회원가입</a>
            </button>
            <%
                }
            %>
        </div>
        <div class="hamburger">
            <i class="fas fa-bars"></i>
        </div>
    </div>
</header>
<div style="margin-top: 80px;"></div>
</body>
</html>
