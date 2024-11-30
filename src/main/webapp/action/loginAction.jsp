<%@ page import="org.talent.donation.repository.MemberRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="java.util.UUID" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  // 로그인 폼 데이터 가져오기
  String id = request.getParameter("id");
  String password = request.getParameter("password");
  String rememberMe = request.getParameter("checked");  // 체크박스 값 확인

  MemberRepository repository = new MemberRepository();
  Member member = repository.findByIdAndPassword(id, password); // 이메일과 비밀번호로 회원 찾기

  if (member != null) {
    // 로그인 성공
    session.setAttribute("loggedInUser", member); // 세션에 사용자 정보 저장

    if ("on".equals(rememberMe)) {
      // '로그인 상태 유지'가 선택된 경우
      String token = UUID.randomUUID().toString();  // 랜덤한 토큰 생성
      repository.saveLoginToken(member.getMno(), token);  // 데이터베이스에 토큰 저장

      // 쿠키 생성 및 응답에 추가
      Cookie loginCookie = new Cookie("login_token", token);
      loginCookie.setMaxAge(60 * 60 * 24 * 30); // 30일 동안 유효
      loginCookie.setHttpOnly(true); // JavaScript를 통해 쿠키에 접근하지 못하게 설정
      loginCookie.setPath("/");
      response.addCookie(loginCookie);
    }

    response.sendRedirect("/page/main.jsp"); // 로그인 성공 후 메인 페이지로 이동
  } else {
    // 로그인 실패
    request.setAttribute("errorMessage", "이메일 또는 비밀번호가 일치하지 않습니다.");
    request.getRequestDispatcher("/page/login.jsp").forward(request, response); // 로그인 페이지로 이동하여 오류 메시지 표시
  }
%>
