<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.talent.donation.entity.Talent" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>

<%
    // 파일 업로드 설정
    String uploadPath = getServletContext().getRealPath("/uploads");;
    int size = 10 * 1024 * 1024; // 최대 파일 크기 (10MB)

    try {
        // MultipartRequest를 사용하여 파일 업로드 처리
        MultipartRequest multi = new MultipartRequest(
                request,
                uploadPath,
                size,
                "UTF-8",
                new DefaultFileRenamePolicy()
        );

        // 폼 데이터 가져오기
        String title = multi.getParameter("title");
        String description = multi.getParameter("description");
        int priceInt = Integer.parseInt(multi.getParameter("price"));
        BigDecimal price = new BigDecimal(priceInt);
        String category = multi.getParameter("category");
        Member loggedInUser = (Member) session.getAttribute("loggedInUser");
        Long memberId = loggedInUser.getMno();

        // 업로드된 파일 정보
        String image = null;
        File file = multi.getFile("image");
        if (file != null) {
            image = file.getName();
        }

        Talent talent = Talent.builder()
                .memberId(memberId)
                .title(title)
                .description(description)
                .price(price)
                .category(category)
                .image(image)
                .build();

        TalentRepository repository = new TalentRepository();
        repository.save(talent);

        request.setAttribute("successMessage", "재능 등록이 성공적으로 완료되었습니다.");
        request.getRequestDispatcher("/page/list.jsp").forward(request, response);

    } catch (Exception e) {
        // 오류 처리
        e.printStackTrace();
%>
<script>
    alert("재능 등록 중 오류가 발생했습니다.");
    history.back();
</script>
<%
        e.printStackTrace();
    }
%>