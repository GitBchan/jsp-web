<%@ page import="org.talent.donation.repository.TalentRepository" %><%--
  Created by IntelliJ IDEA.
  User: kimbyungchan
  Date: 24. 11. 13.
  Time: 오후 1:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String tno = request.getParameter("tno");

  TalentRepository talentRepository = new TalentRepository();
  try {
    talentRepository.delete(Long.parseLong(tno));
    request.setAttribute("successMessage", "성공적으로 삭제되었습니다");

  } catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "삭제에 실패했습니다.");
  }
  request.getRequestDispatcher("/page/personal_talent.jsp").forward(request, response);
%>