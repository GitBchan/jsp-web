<%@ page import="org.talent.donation.repository.ReviewRepository" %>
<%@ page import="org.talent.donation.entity.Review" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="java.math.BigDecimal" %><%--
  Created by IntelliJ IDEA.
  User: kimbyungchan
  Date: 24. 11. 8.
  Time: 오후 5:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String transactionId = request.getParameter("transactionId");
  String talentId = request.getParameter("talentId");
  String rating = request.getParameter("rating");
  Member member = (Member) session.getAttribute("loggedInUser");

  Review review = Review.builder()
          .transactionId(Long.parseLong(transactionId))
          .talentId(Long.parseLong(talentId))
          .memberId(member.getMno())
          .rating(new BigDecimal(rating))
          .build();

  ReviewRepository repository = new ReviewRepository();
  try {
    repository.save(review);
    request.setAttribute("successMessage", "리뷰가 등록되었습니다!");
  } catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "리뷰를 다시 작성해 주세요!");
  }

  request.getRequestDispatcher("/page/personal_purchase.jsp").forward(request, response);
%>
