<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.talent.donation.repository.InquiryRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.entity.Inquiry" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>문의 내역 | Talent Sharing Platform</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
</head>
<style>
    .inquiry-card {
        border: 1px solid #e9ecef;
        border-radius: 12px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        background-color: #fff;
        transition: transform 0.2s ease-in-out;
    }

    .inquiry-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }

    .inquiry-header {
        padding: 1rem 1.5rem;
        border-bottom: 1px solid #e9ecef;
        background-color: #f8f9fa;
        border-radius: 12px 12px 0 0;
    }

    .inquiry-header .date {
        color: #6c757d;
        font-size: 0.9rem;
    }

    .inquiry-content {
        padding: 1.5rem !important;
    }

    .inquiry-content h5 {
        color: #343a40;
        font-size: 1.1rem;
        margin-bottom: 1rem;
    }

    .inquiry-content p {
        color: #495057;
        line-height: 1.6;
        margin-bottom: 1rem;
    }

    .badge {
        padding: 0.5rem 1rem;
        font-weight: 500;
        border-radius: 20px;
    }

    .badge.bg-success {
        background-color: #d4edda !important;
        color: #155724;
    }

    .badge.bg-warning {
        background-color: #fff3cd !important;
        color: #856404;
    }

    .alert-info {
        background-color: #e3f2fd;
        border: none;
        border-radius: 8px;
        padding: 1rem 1.25rem;
    }

    .inquiry-response-form {
        background-color: #f8f9fa;
        padding: 1.5rem;
        border-radius: 8px;
        margin-top: 1.5rem;
    }

    .form-control {
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 0.75rem;
    }

    .btn-primary {
        padding: 0.5rem 1.5rem;
        border-radius: 8px;
    }

    .inquiry-card {
        border: 1px solid #e9ecef;
        border-radius: 12px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        background-color: #fff;
        transition: transform 0.2s ease-in-out;
    }

    .inquiry-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }

    .inquiry-header {
        padding: 1rem 1.5rem;
        border-bottom: 1px solid #e9ecef;
        background-color: #f8f9fa;
        border-radius: 12px 12px 0 0;
    }

    .inquiry-header .date {
        color: #6c757d;
        font-size: 0.9rem;
    }

    .inquiry-content {
        padding: 1.5rem !important;
    }

    .inquiry-content h5 {
        color: #343a40;
        font-size: 1.1rem;
        margin-bottom: 1rem;
    }

    .inquiry-content p {
        color: #495057;
        line-height: 1.6;
        margin-bottom: 1rem;
    }

    .badge {
        padding: 0.5rem 1rem;
        font-weight: 500;
        border-radius: 20px;
    }

    .badge.bg-success {
        background-color: #d4edda !important;
        color: #155724;
    }

    .badge.bg-warning {
        background-color: #fff3cd !important;
        color: #856404;
    }

    .alert-info {
        background-color: #e3f2fd;
        border: none;
        border-radius: 8px;
        padding: 1rem 1.25rem;
    }

    .inquiry-response-form {
        background-color: #f8f9fa;
        padding: 1.5rem;
        border-radius: 8px;
        margin-top: 1.5rem;
    }

    .form-control {
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 0.75rem;
    }

    .btn-primary {
        padding: 0.5rem 1.5rem;
        border-radius: 8px;
    }
</style>
<body>

<%@ include file="/includePage/header.jsp" %>

<%
  Member member = (Member) session.getAttribute("loggedInUser");

  InquiryRepository repository = new InquiryRepository();
  List<Inquiry> allInquiries = repository.findAnsweredInquiriesByWriter(member.getMno());
  List<Inquiry> pendingInquiries = repository.findPendingInquiriesByOwner(member.getMno());
  request.setAttribute("allInquiries", allInquiries);
  request.setAttribute("pendingInquiries", pendingInquiries);
%>

<main class="container py-5">
  <h1 class="text-center mb-5">문의 관리</h1>

  <ul class="nav nav-tabs mb-4" id="inquiryTabs" role="tablist">
    <li class="nav-item">
      <a class="nav-link active" id="all-inquiries-tab" data-bs-toggle="tab" href="#all-inquiries" role="tab">
        문의 내역
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" id="pending-inquiries-tab" data-bs-toggle="tab" href="#pending-inquiries" role="tab">
        답변해야하는 문의 <span class="badge bg-primary"><%=pendingInquiries.size()%></span>
      </a>
    </li>
  </ul>

  <div class="tab-content" id="inquiryTabsContent">
    <!-- 전체 문의 내역 -->
    <div class="tab-pane fade show active" id="all-inquiries" role="tabpanel">
      <c:if test="${empty allInquiries}">
        <div class="text-center py-5">
          <i class="bi bi-inbox fs-1 text-muted"></i>
          <h5 class="mt-3 text-muted">문의 내역이 없습니다.</h5>
        </div>
      </c:if>

        <c:forEach var="inquiry" items="${allInquiries}">
            <div class="inquiry-card mb-4">
                <div class="inquiry-header d-flex justify-content-between align-items-center">
                    <span class="date">${inquiry.createdAt}</span>
                    <span class="badge
            <c:choose>
              <c:when test="${inquiry.status == 'answered'}">bg-success</c:when>
              <c:otherwise>bg-warning</c:otherwise>
            </c:choose>">
                            ${inquiry.status == 'answered' ? '답변 완료' : '답변 대기'}
                    </span>
                </div>
                <div class="inquiry-content">
                    <h5>문의 번호: ${inquiry.inquiryId}</h5>
                    <p>내용: ${inquiry.content}</p>
                    <c:if test="${not empty inquiry.responseContent}">
                        <div class="alert alert-info mt-3">
                            <strong>답변:</strong> ${inquiry.responseContent}
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 답변해야하는 문의 -->
    <div class="tab-pane fade" id="pending-inquiries" role="tabpanel">
      <c:if test="${empty pendingInquiries}">
        <div class="text-center py-5">
          <i class="bi bi-inbox fs-1 text-muted"></i>
          <h5 class="mt-3 text-muted">답변해야하는 문의가 없습니다.</h5>
        </div>
      </c:if>

      <c:forEach var="inquiry" items="${pendingInquiries}">
        <div class="inquiry-card mb-4">
          <div class="inquiry-header d-flex justify-content-between align-items-center">
            <span>${inquiry.createdAt}</span>
            <span class="badge bg-warning">답변 대기</span>
          </div>
          <div class="inquiry-content p-3">
            <h5>문의 번호: ${inquiry.inquiryId}</h5>
            <p>내용: ${inquiry.content}</p>
            <div class="inquiry-response-form mt-3">
              <form action="/action/personal_inquiryAction.jsp" method="post">
                <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />
                <label for="responseContent" class="form-label"><strong>답변 작성:</strong></label>
                <textarea id="responseContent" name="responseContent" class="form-control mb-2" rows="3" placeholder="답변을 입력하세요..."></textarea>
                <button type="submit" class="btn btn-primary">답변 제출</button>
              </form>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</main>

<%@ include file="/includePage/footer.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const tabs = document.querySelectorAll('#inquiryTabs .nav-link');
    tabs.forEach(tab => {
      tab.addEventListener('click', function(event) {
        event.preventDefault();
        const targetTab = event.target.getAttribute('href');
        tabs.forEach(t => t.classList.remove('active'));
        tab.classList.add('active');
        document.querySelectorAll('#inquiryTabsContent .tab-pane').forEach(pane => pane.classList.remove('show', 'active'));
        document.querySelector(targetTab).classList.add('show', 'active');
      });
    });
  });
</script>
</body>
</html>
