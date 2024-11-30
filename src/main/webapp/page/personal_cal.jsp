<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.repository.AccountInfoRepository" %>
<%@ page import="org.talent.donation.entity.AccountInfo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>정산 정보 관리 | Talent Sharing Platform</title>
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

    .account-management {
      padding: 4rem 0;
    }

    .page-title {
      font-size: 2.5rem;
      font-weight: 700;
      text-align: center;
      margin-bottom: 3rem;
      color: var(--text-color);
    }

    .account-card {
      background: white;
      border-radius: 15px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      padding: 2rem;
      max-width: 800px;
      margin: 0 auto;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-label {
      font-weight: 500;
      margin-bottom: 0.5rem;
      color: var(--text-color);
    }

    .form-control {
      border-radius: 10px;
      padding: 0.8rem 1rem;
      border: 1px solid #dee2e6;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
    }

    .form-select {
      border-radius: 10px;
      padding: 0.8rem 1rem;
      border: 1px solid #dee2e6;
    }

    .btn-save {
      background: var(--primary-color);
      color: white;
      border: none;
      padding: 0.8rem 2rem;
      border-radius: 25px;
      font-weight: 500;
      transition: all 0.3s ease;
      width: 100%;
      margin-top: 1rem;
    }

    .btn-save:hover {
      background: #2980b9;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .info-text {
      font-size: 0.9rem;
      color: #666;
      margin-top: 0.5rem;
    }

    .bank-logo {
      width: 24px;
      height: 24px;
      margin-right: 8px;
      vertical-align: middle;
    }

    .success-message {
      display: none;
      background-color: #d4edda;
      color: #155724;
      padding: 1rem;
      border-radius: 10px;
      margin-bottom: 1rem;
    }
  </style>
</head>
<body>
<%@include file="/includePage/header.jsp"%>

<%

  Member member = (Member) session.getAttribute("loggedInUser");

  AccountInfoRepository repository = new AccountInfoRepository();
  AccountInfo result = repository.findByMemberId(member.getMno());

  if (result == null) {
    result = new AccountInfo();
  }


  String successMessage = (String) request.getAttribute("successMessage");

  if (successMessage != null) {
%>
<script>
  alert("<%=successMessage%>")
</script>

<%
  }
%>

<main class="account-management">
  <div class="container">
    <h1 class="page-title">정산 정보 관리</h1>

    <div class="account-card">
      <div class="success-message" id="successMessage">
        정산 정보가 성공적으로 저장되었습니다.
      </div>

      <form id="accountForm" action="/action/personal_calAction.jsp" method="post" onsubmit="return validateForm(event)">
        <div class="form-group">
          <label for="bankName" class="form-label">은행 선택</label>
          <select class="form-select" id="bankName" name="bankName" required>
            <option value="" <%= result.getBankName() == null ? "selected" : ""%>>은행을 선택하세요</option>
            <option value="KB" <%= "KB".equals(result.getBankName()) ? "selected" : "" %>>KB국민은행</option>
            <option value="신한" <%= "신한".equals(result.getBankName()) ? "selected" : "" %>>신한은행</option>
            <option value="우리" <%= "우리".equals(result.getBankName()) ? "selected" : "" %>>우리은행</option>
            <option value="하나" <%= "하나".equals(result.getBankName()) ? "selected" : "" %>>하나은행</option>
            <option value="농협" <%= "농협".equals(result.getBankName()) ? "selected" : "" %>>NH농협은행</option>
            <option value="카카오" <%= "카카오".equals(result.getBankName()) ? "selected" : "" %>>카카오뱅크</option>
            <option value="토스" <%= "토스".equals(result.getBankName()) ? "selected" : "" %>>토스뱅크</option>
          </select>
        </div>


        <div class="form-group">
          <label for="accountNumber" class="form-label">계좌번호</label>
          <input type="text" class="form-control" id="accountNumber" name="accountNumber" value="<%= result.getAccountNumber() == null ? "" : result.getAccountNumber() %>"
                 placeholder="숫자만 입력해주세요" required pattern="\d*">
          <div class="info-text">'-' 없이 숫자만 입력해주세요.</div>
        </div>

        <div class="form-group">
          <label for="accountHolder" class="form-label">예금주명</label>
          <input type="text" class="form-control" id="accountHolder" name="accountHolder" value="<%=result.getAccountHolder() == null ? "" : result.getAccountHolder()%>"
                 placeholder="예금주명을 입력해주세요" required>
          <div class="info-text">실명을 정확히 입력해주세요.</div>
        </div>

        <input type="hidden" name="accountId" value="<%=result.getAccountId()%>">

        <button type="submit" class="btn btn-save">정산 정보 저장</button>
      </form>
    </div>
  </div>
</main>

<%@ include file="/includePage/footer.jsp" %>

<script>
  function validateForm(event) {
    event.preventDefault();

    const accountNumber = document.getElementById('accountNumber').value;
    const accountHolder = document.getElementById('accountHolder').value;
    const bankName = document.getElementById('bankName').value;

    if (!bankName) {
      alert('은행을 선택해주세요.');
      return false;
    }

    if (!accountNumber.match(/^\d+$/)) {
      alert('계좌번호는 숫자만 입력해주세요.');
      return false;
    }

    if (!accountHolder.trim()) {
      alert('예금주명을 입력해주세요.');
      return false;
    }

    document.getElementById("accountForm").submit();
  }

</script>
</body>
</html>