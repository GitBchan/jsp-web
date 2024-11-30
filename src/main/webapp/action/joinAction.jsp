<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.repository.MemberRepository" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  request.setCharacterEncoding("UTF-8"); // POST 데이터 인코딩 설정

  // 폼 데이터 가져오기
  String name = request.getParameter("name");
  String id = request.getParameter("id");
  String password = request.getParameter("password");

  // Member 객체 생성 및 설정
  Member member = new Member().builder()
          .name(name)
          .id(id)
          .password(password)
          .fileName(null)
          .build();

  // MemberRepository를 통해 회원 정보 저장
  MemberRepository repository = new MemberRepository();

  try {
    repository.save(member);
    request.setAttribute("success", "회원 가입에 성공하셨습니다!");
    request.getRequestDispatcher("/page/login.jsp").forward(request, response);
  } catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.'); history.back();</script>");
  }
%>
