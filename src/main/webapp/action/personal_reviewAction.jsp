<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.entity.Review" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.talent.donation.repository.ReviewRepository" %><%--
  Created by IntelliJ IDEA.
  User: kimbyungchan
  Date: 24. 11. 13.
  Time: 오후 12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String reviewId = request.getParameter("reviewId");
  String rating = request.getParameter("rating");
  Member member = (Member) session.getAttribute("loggedInUser");

  Review review = Review.builder()
          .reviewId(Long.parseLong(reviewId))
          .memberId(member.getMno())
          .rating(new BigDecimal(rating))
          .build();

  ReviewRepository repository = new ReviewRepository();
  try {
    repository.update(review);
    request.setAttribute("successMessage", "리뷰가 수정되었습니다!");
  } catch (Exception e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "리뷰를 다시 작성해 주세요!");
  }

  request.getRequestDispatcher("/page/personal_review.jsp").forward(request, response);

%>
