<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String sno = request.getParameter("sno");
  TalentRepository repository = new TalentRepository();
  try {
    repository.updateStatusToConfirmed(Long.parseLong(sno));
    response.sendRedirect("/page/personal_talent.jsp");
  } catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("/page/personal_talent.jsp");
  }
%>