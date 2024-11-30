<%@ page import="org.talent.donation.repository.TalentRepository" %><%--
  Created by IntelliJ IDEA.
  User: kimbyungchan
  Date: 24. 11. 9.
  Time: 오전 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String sno = request.getParameter("sno");
  TalentRepository repository = new TalentRepository();
  try {
    repository.updateStatusToAvailable(Long.parseLong(sno));
    response.sendRedirect("/page/personal_talent.jsp");
  } catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("/page/personal_talent.jsp");
  }
%>
