<%@ page import="org.talent.donation.repository.MemberRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  session.removeAttribute("loggedInUser");

  session.invalidate();

  Cookie[] cookies = request.getCookies();

  for (Cookie cookie : cookies) {
    if ("login_token".equals(cookie.getName())) {
      String token = cookie.getValue();

      MemberRepository repository = new MemberRepository();
      repository.deleteLoginToken(token);
    }
  }

  response.sendRedirect("/page/main.jsp"); // 메인 페이지로 리디렉션
%>
