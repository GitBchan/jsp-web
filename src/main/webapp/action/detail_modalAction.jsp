<%@ page import="org.talent.donation.repository.InquiryRepository" %>
<%@ page import="org.talent.donation.entity.Inquiry" %>
<%@ page import="org.talent.donation.entity.Member" %><%--
  Created by IntelliJ IDEA.
  User: kimbyungchan
  Date: 24. 11. 8.
  Time: 오전 1:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String inquiryMessage = request.getParameter("inquiryMessage");

    Member member = (Member) session.getAttribute("loggedInUser");

    String talent = request.getParameter("talent");
    Inquiry inquiry = Inquiry.builder()
            .writerId(member.getMno())
            .talentId(Long.parseLong(talent))
            .talentOwnerId(Long.parseLong(request.getParameter("talentOwner")))
            .content(inquiryMessage)
            .build();

    try {
        InquiryRepository repository = new InquiryRepository();
        repository.save(inquiry);

        request.setAttribute("successMessage", "문의를 성공적으로 발송했습니다!");
        request.getRequestDispatcher("/page/detail.jsp?tno=" + talent).forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();

        request.setAttribute("errorMessage", "문의 발송에 실패했습니다. 다시 작성해주세요!");
        request.getRequestDispatcher("/page/detail.jsp?tno=" + talent).forward(request, response);
    }
%>