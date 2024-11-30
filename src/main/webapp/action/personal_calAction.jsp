<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.talent.donation.repository.AccountInfoRepository" %>
<%@ page import="org.talent.donation.entity.AccountInfo" %>
<%@ page import="org.talent.donation.entity.Member" %>

<%
  // 폼에서 전달된 파라미터 수신
  String bankName = request.getParameter("bankName");
  String accountNumber = request.getParameter("accountNumber");
  String accountHolder = request.getParameter("accountHolder");
  String result = request.getParameter("accountId");

  // 현재 세션에서 사용자 ID (memberId)를 가져오기
  Member member = (Member) session.getAttribute("loggedInUser");
  Long memberId = member.getMno();

  if (memberId != null && bankName != null && accountNumber != null && accountHolder != null) {
    try {
      AccountInfoRepository accountRepo = new AccountInfoRepository();

      // AccountInfo 객체 생성
      AccountInfo accountInfo = AccountInfo.builder()
              .memberId(memberId)
              .bankName(bankName)
              .accountNumber(accountNumber)
              .accountHolder(accountHolder)
              .build();


      if (result == null || result.equals("null") || result.isEmpty()) {
        accountRepo.save(accountInfo);
      } else {
        Long accountId = Long.parseLong(result);

        accountInfo.setAccountId(accountId);

        accountRepo.update(accountInfo);
      }
      // 저장 또는 수정

      // 성공 메시지를 세션에 저장 후 리다이렉트
      session.setAttribute("successMessage", "정산 정보가 성공적으로 저장되었습니다.");
      response.sendRedirect("/page/personal_cal.jsp");

    } catch (Exception e) {
      e.printStackTrace();
      request.setAttribute("errorMessage", "정산 정보 저장에 실패했습니다. 다시 시도해주세요.");
      request.getRequestDispatcher("/page/personal_cal.jsp").forward(request, response);
    }
  } else {
    request.setAttribute("errorMessage", "모든 정보를 입력해주세요.");
    request.getRequestDispatcher("/page/accountManagement.jsp").forward(request, response);
  }
%>
