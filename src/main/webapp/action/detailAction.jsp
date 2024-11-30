<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page import="org.talent.donation.entity.TalentTimeSlot" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="org.talent.donation.repository.TransactionRepository" %>
<%@ page import="org.talent.donation.entity.Transaction" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="java.math.BigDecimal" %><%--
  Created by IntelliJ IDEA.
  User: kimbyungchan
  Date: 24. 11. 8.
  Time: 오후 12:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    Member member = (Member) session.getAttribute("loggedInUser");

    String timeOption = request.getParameter("timeOption");
    String date = request.getParameter("date");
    int price = Integer.parseInt(request.getParameter("price"));
    BigDecimal priceBig = BigDecimal.valueOf(price);
    String talent = request.getParameter("talent");
    long talentOwner = Long.parseLong(request.getParameter("talentOwner"));

    LocalDate parsedDate = LocalDate.parse(date);
    LocalDateTime scheduledDateTime = parsedDate.atStartOfDay();

    TalentTimeSlot timeSlot = TalentTimeSlot.builder()
            .talentId(Long.parseLong(talent))
            .timeSlot(Integer.parseInt(timeOption))
            .scheduledDate(scheduledDateTime)
            .build();

    Transaction transaction = Transaction.builder()
            .buyerId(member.getMno())
            .talentId(Long.parseLong(talent))
            .talentOwnerId(talentOwner)
            .amount(priceBig)
            .scheduledDate(scheduledDateTime)
            .timeSlot(timeOption)
            .build();



    TalentRepository repository = new TalentRepository();
    TransactionRepository transactionRepository = new TransactionRepository();

    try {
        repository.saveTimeSlot(timeSlot);
        transactionRepository.save(transaction);

        response.sendRedirect("/page/personal_purchase.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/page/detail.jsp?tno=" + talent);
    }
%>