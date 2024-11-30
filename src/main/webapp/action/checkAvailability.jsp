<%@ page import="org.talent.donation.entity.TalentTimeSlot" %><%@ page import="org.talent.donation.repository.TalentRepository"%><%@ page import="java.util.List"%><%@ page import="java.time.LocalDate"%><%@ page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Long talentId = Long.parseLong(request.getParameter("talentId"));
    String dateParam = request.getParameter("date"); // yyyy-MM-dd 형식으로 전달

    TalentRepository repository = new TalentRepository();
    List<TalentTimeSlot> timeSlots = repository.findByTalentId(talentId, LocalDateTime.parse(dateParam));

    // JSON 응답 생성
    StringBuilder json = new StringBuilder("{ \"timeSlots\": [");
    for (int i = 0; i < timeSlots.size(); i++) {
        TalentTimeSlot slot = timeSlots.get(i);
        json.append("{ \"timeSlot\": ").append(slot.getTimeSlot()).append(", \"status\": \"").append(slot.getStatus()).append("\" }");
        if (i < timeSlots.size() - 1) {
            json.append(", ");
        }
    }
    json.append("] }");
    out.print(json.toString());
%>
