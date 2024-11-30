<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.entity.Talent" %>
<%@ page import="java.util.List" %>
<%@ page import="org.talent.donation.dto.TalentTimeSlotDTO" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>재능 관리</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
  <link rel="stylesheet" href="/css/talent-management.css">
</head>

  <%
  Member member = (Member) session.getAttribute("loggedInUser");
  TalentRepository repository = new TalentRepository();

  List<Talent> allByMemberId = repository.findAllByMemberId(member.getMno());
  request.setAttribute("allByMemberId", allByMemberId);

  List<TalentTimeSlotDTO> pending = repository.findPendingTimeSlotsWithTransactions(member.getMno());
  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
  request.setAttribute("pending", pending);

  String successMessage = request.getParameter("successMessage");
  String errorMessage = request.getParameter("errorMessage");


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

%>

<body>
<%@include file="/includePage/header.jsp"%>

<main class="py-5">
  <div class="container">
    <h1 class="section-title">재능 관리</h1>

    <ul class="nav nav-tabs mb-4" id="talentTabs" role="tablist">
      <li class="nav-item">
        <a class="nav-link active" id="registered-tab" data-bs-toggle="tab" href="#registered" role="tab">
          등록한 재능
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" id="requests-tab" data-bs-toggle="tab" href="#requests" role="tab">
          구매 요청 <span class="badge bg-primary"><%=pending.size()%></span>
        </a>
      </li>
    </ul>

    <div class="tab-content" id="talentTabsContent">
      <!-- 등록한 재능 탭 -->
      <div class="tab-pane fade show active" id="registered" role="tabpanel">
        <div class="row">

          <c:if test="${empty allByMemberId}">
            <div class="text-center py-5">
              <i class="bi bi-inbox fs-1 text-muted"></i>
              <h5 class="mt-3 text-muted">등록한 재능이 없습니다.</h5>
              <p class="text-muted">당신의 재능을 등록해 보세요!</p>
              <a href="/page/register.jsp" class="btn btn-primary btn-lg rounded-pill">재능 등록하기</a>
            </div>
          </c:if>


          <c:forEach items="${allByMemberId}" var="talent">
            <div class="col-md-6 col-lg-4 mb-4">
              <a href="/page/detail.jsp?tno=${talent.tno}">
                <div class="talent-card shadow-sm">
                  <div class="talent-info p-4">
                    <h3 class="talent-title mb-2">${talent.title}</h3>
                    <p class="talent-category text-muted mb-2">${talent.category}</p>
                    <div class="talent-details d-flex justify-content-between align-items-center mb-3">
                      <p class="talent-price mb-0 text-primary font-weight-bold">
                        <fmt:formatNumber value="${talent.price}" type="currency" currencySymbol="₩" />
                      </p>
                    </div>
                    <div class="talent-date text-muted mb-3">
                      등록일: ${talent.getFormatCreateDate()}
                    </div>
                    <div class="action-buttons">
                      <a href="/talent/edit/${talent.tno}" class="btn btn-outline-primary btn-sm me-2">수정</a>
                      <button class="btn btn-outline-danger btn-sm" onclick="window.location.href='/action/personal_talentDeleteAction.jsp?tno=${talent.tno}'">삭제</button>
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </c:forEach>
        </div>
      </div>

      <!-- 구매 요청 탭 -->
      <div class="tab-pane fade" id="requests" role="tabpanel">
        <c:choose>
          <c:when test="${empty pending}">
            <div class="text-center py-5">
              <i class="bi bi-inbox fs-1 text-muted"></i>
              <h5 class="mt-3 text-muted">새로운 구매 요청이 없습니다.</h5>
              <p class="text-muted">새로운 구매 요청이 들어오면 이곳에서 확인하실 수 있습니다.</p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="container py-4">
              <h2 class="mb-4 text-center">승인 대기 중인 요청</h2>
              <div class="row g-4">
                <c:forEach items="${pending}" var="request">
                  <div class="col-md-6 col-lg-4">
                    <div class="card h-100 shadow-sm hover-shadow transition">
                      <div class="card-body">
                        <h5 class="card-title mb-3">${request.title}</h5>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                          <span class="badge bg-warning text-dark px-3 py-2 rounded-pill">승인 대기중</span>
                          <p class="text-muted mb-0 fs-5 fw-bold">
                            <fmt:formatNumber value="${request.amount}" type="currency" currencySymbol="₩" />
                          </p>
                        </div>
                        <ul class="list-unstyled mb-4">
                          <li class="mb-2">
                            <i class="bi bi-calendar3 me-2 text-primary"></i>
                            예약 날짜: ${request.scheduledDate}
                          </li>
                          <li class="mb-2">
                            <i class="bi bi-clock me-2 text-primary"></i>
                            시간대:
                            <c:choose>
                              <c:when test="${request.timeSlot == 1}">09:00 - 11:00</c:when>
                              <c:when test="${request.timeSlot == 2}">11:00 - 13:00</c:when>
                              <c:when test="${request.timeSlot == 3}">13:00 - 15:00</c:when>
                              <c:when test="${request.timeSlot == 4}">15:00 - 17:00</c:when>
                              <c:when test="${request.timeSlot == 5}">17:00 - 19:00</c:when>
                              <c:otherwise>시간대 정보 없음</c:otherwise>
                            </c:choose>
                          </li>
                          <c:if test="${not empty request.remarks}">
                            <li>
                              <i class="bi bi-chat-left-text me-2 text-primary"></i>
                              요청사항: ${request.remarks}
                            </li>
                          </c:if>
                        </ul>
                      </div>
                      <div class="card-footer bg-transparent border-top-0">
                        <div class="d-flex justify-content-between">
                          <button class="btn btn-outline-success flex-grow-1 me-2" onclick="window.location.href='/action/personal_talentAcceptAction.jsp?sno=${request.sno}'">
                            <i class="bi bi-check-circle me-2"></i>수락
                          </button>
                          <button class="btn btn-outline-danger flex-grow-1" onclick="window.location.href='/action/personal_talentDenyAction.jsp?sno=${request.sno}'">
                            <i class="bi bi-x-circle me-2"></i>거절
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </div>

          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</main>

<%@ include file="/includePage/footer.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    // 탭 클릭 이벤트 리스너 등록
    const tabs = document.querySelectorAll('#talentTabs .nav-link');
    tabs.forEach(tab => {
      tab.addEventListener('click', function(event) {
        event.preventDefault();
        const targetTab = event.target;
        const targetTabId = targetTab.getAttribute('href');

        // 탭 활성화 표시 변경
        document.querySelectorAll('#talentTabs .nav-link').forEach(tab => tab.classList.remove('active'));
        targetTab.classList.add('active');

        // 탭 콘텐츠 영역 변경
        document.querySelectorAll('#talentTabsContent .tab-pane').forEach(pane => pane.classList.remove('show', 'active'));
        document.querySelector(targetTabId).classList.add('show', 'active');
      });
    });
  });

</script>