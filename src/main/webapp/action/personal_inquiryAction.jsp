<%@ page import="org.talent.donation.repository.InquiryRepository" %><%--
  Created by IntelliJ IDEA.
  User: kimbyungchan
  Date: 24. 11. 12.
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String responseContent = request.getParameter("responseContent");
  String inquiryId = request.getParameter("inquiryId");

  InquiryRepository repository = new InquiryRepository();
  try {
    repository.answerInquiry(Long.parseLong(inquiryId), responseContent);
    request.setAttribute("successMessage", "답변이 성공적으로 저장되었습니다!");
  } catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "오류가 발생했습니다. 답변을 다시 입력해주세요!");
  }
  request.getRequestDispatcher("/page/personal_inquiry.jsp").forward(request, response); // 로그인 페이지로 이동하여 오류 메시지 표시

%>