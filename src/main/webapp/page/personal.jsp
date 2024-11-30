<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  // 세션에 loggedInUser가 없으면 로그인 페이지로 리다이렉트
  if (session.getAttribute("loggedInUser") == null) {
    response.sendRedirect("login.jsp");
    return; // 이후 코드 실행을 방지하기 위해 return 추가
  }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>마이페이지 - 재능 공유 플랫폼</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #F9FAFB;
    }

    .dashboard-card {
      transition: all 0.2s ease;
    }

    .dashboard-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body>
<%@ include file="/includePage/header.jsp" %>

<div class="container mx-auto px-4 py-8 max-w-6xl">
  <!-- 프로필 요약 -->
  <div class="bg-white rounded-2xl shadow-lg p-6 mb-8">
    <div class="flex items-center gap-6">
      <img src="/uploads/${sessionScope.loggedInUser.fileName}" alt="프로필"
           class="w-24 h-24 rounded-full object-cover border-4 border-white shadow">
      <div>
        <h2 class="text-2xl font-bold mb-2">${sessionScope.loggedInUser.name}</h2>
        <p class="text-gray-600">${sessionScope.loggedInUser.id}</p>
      </div>
    </div>
  </div>

  <!-- 대시보드 그리드 -->
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    <!-- 프로필 관리 -->
    <a href="/page/personal_modify.jsp" class="dashboard-card bg-white rounded-xl shadow-lg p-6 cursor-pointer">
      <div class="flex items-center justify-between mb-4">
        <div class="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center">
          <i class="fas fa-user text-blue-600 text-xl"></i>
        </div>
        <i class="fas fa-chevron-right text-gray-400"></i>
      </div>
      <h3 class="text-lg font-bold mb-2">프로필 관리</h3>
      <p class="text-gray-600">기본 정보 및 프로필 설정을 관리합니다</p>
    </a>

    <!-- 재능 관리 -->
    <a href="/page/personal_talent.jsp" class="dashboard-card bg-white rounded-xl shadow-lg p-6 cursor-pointer">
      <div class="flex items-center justify-between mb-4">
        <div class="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center">
          <i class="fas fa-lightbulb text-purple-600 text-xl"></i>
        </div>
        <span class="bg-purple-100 text-purple-600 px-3 py-1 rounded-full text-sm font-medium">
            ${registeredTalents.size()}개
          </span>
      </div>
      <h3 class="text-lg font-bold mb-2">재능 관리</h3>
      <p class="text-gray-600">등록한 재능을 관리하고 새로운 재능을 등록합니다</p>
    </a>

    <!-- 구매 내역 -->
    <a href="/page/personal_purchase.jsp" class="dashboard-card bg-white rounded-xl shadow-lg p-6 cursor-pointer">
      <div class="flex items-center justify-between mb-4">
        <div class="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center">
          <i class="fas fa-shopping-bag text-green-600 text-xl"></i>
        </div>
        <span class="bg-green-100 text-green-600 px-3 py-1 rounded-full text-sm font-medium">
            ${purchases.size()}건
          </span>
      </div>
      <h3 class="text-lg font-bold mb-2">구매 내역</h3>
      <p class="text-gray-600">구매한 재능과 이용 내역을 확인합니다</p>
    </a>

    <!-- 문의/알림 -->
    <a href="/page/personal_inquiry.jsp" class="dashboard-card bg-white rounded-xl shadow-lg p-6 cursor-pointer">
      <div class="flex items-center justify-between mb-4">
        <div class="w-12 h-12 bg-yellow-100 rounded-xl flex items-center justify-center">
          <i class="fas fa-bell text-yellow-600 text-xl"></i>
        </div>
        <c:if test="${newInquiries > 0}">
            <span class="bg-red-100 text-red-600 px-3 py-1 rounded-full text-sm font-medium">
              새 알림 ${newInquiries}
            </span>
        </c:if>
      </div>
      <h3 class="text-lg font-bold mb-2">문의/알림</h3>
      <p class="text-gray-600">문의 내역과 알림을 확인합니다</p>
    </a>

    <!-- 리뷰 관리 -->
    <a href="/page/personal_review.jsp" class="dashboard-card bg-white rounded-xl shadow-lg p-6 cursor-pointer">
      <div class="flex items-center justify-between mb-4">
        <div class="w-12 h-12 bg-pink-100 rounded-xl flex items-center justify-center">
          <i class="fas fa-star text-pink-600 text-xl"></i>
        </div>
        <c:if test="${pendingReviews > 0}">
            <span class="bg-pink-100 text-pink-600 px-3 py-1 rounded-full text-sm font-medium">
              ${pendingReviews}건 작성 가능
            </span>
        </c:if>
      </div>
      <h3 class="text-lg font-bold mb-2">리뷰 관리</h3>
      <p class="text-gray-600">받은 리뷰와 작성할 리뷰를 관리합니다</p>
    </a>

    <!-- 정산 정보 -->
    <a href="/page/personal_cal.jsp" class="dashboard-card bg-white rounded-xl shadow-lg p-6 cursor-pointer">
      <div class="flex items-center justify-between mb-4">
        <div class="w-12 h-12 bg-indigo-100 rounded-xl flex items-center justify-center">
          <i class="fas fa-wallet text-indigo-600 text-xl"></i>
        </div>
        <i class="fas fa-chevron-right text-gray-400"></i>
      </div>
      <h3 class="text-lg font-bold mb-2">정산 정보</h3>
      <p class="text-gray-600">수익 현황과 정산 정보를 관리합니다</p>
    </a>
  </div>
</div>

<%@ include file="/includePage/footer.jsp" %>
</body>
</html>
