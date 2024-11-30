<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page import="org.talent.donation.entity.Talent" %>
<%@ page import="java.util.List" %>

<%
  int currentPage = 1;
  int pageSize = 12;
  String search = request.getParameter("search");
  String category = request.getParameter("category");

  try {
    String pageParam = request.getParameter("page");
    if (pageParam != null && !pageParam.isEmpty()) {
      currentPage = Integer.parseInt(pageParam);
      if (currentPage < 1) currentPage = 1;
    }
  } catch (NumberFormatException e) {
    currentPage = 1;
  }

  TalentRepository talentRepository = new TalentRepository();
  List<Talent> talents = talentRepository.findTalentsWithPaging(currentPage, pageSize, search, category);
  int totalPages = talentRepository.getTotalPages(pageSize, search, category);

  String successMessage = (String) request.getAttribute("successMessage");

  if (successMessage != null) {
%>
<script>
  alert("<%= successMessage %>");
</script>
<%
  }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>재능 목록 - 재능 공유 플랫폼</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #e74c3c;
      --background-color: #f8f9fa;
      --text-color: #2c3e50;
      --card-bg-color: #ffffff;
    }

    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      background-attachment: fixed;
      color: var(--text-color);
    }

    /* 모든 스타일 그대로 유지 */
    .talent-list-header {
      background: linear-gradient(to right bottom, #2980b9, #3498db, #5dade2);
      color: white;
      padding: 4rem 0;
      text-align: center;
    }

    .talent-list-header h1 {
      font-size: 3rem;
      font-weight: 700;
      margin-bottom: 1rem;
    }

    .talent-search-container {
      background: white;
      padding: 2rem;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
      margin-top: -50px;
      position: relative;
      z-index: 10;
    }

    .talent-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 1.5rem;
      padding: 2rem 0;
    }

    .talent-card {
      background: white;
      border-radius: 15px;
      overflow: hidden;
      transition: all 0.3s ease;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .talent-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
    }

    .talent-card-image {
      height: 200px;
      object-fit: cover;
    }

    .talent-card-body {
      padding: 1rem;
    }

    .talent-category-icon {
      font-size: 2rem;
      margin-bottom: 0.5rem;
      color: var(--primary-color);
    }

    .talent-price {
      color: black;
      font-weight: bold;
    }

    .filter-section {
      background: white;
      border-radius: 15px;
      padding: 1.5rem;
      margin-bottom: 1.5rem;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    }

    .pagination {
      justify-content: center;
      margin-top: 2rem;
    }

    .search-row {
      display: flex;
      align-items: center;
      gap: 1rem;
    }



  </style>
</head>
<body>
<%@include file="/includePage/header.jsp"%>

<main>
  <section class="talent-list-header">
    <div class="container">
      <h1>다양한 재능을 만나보세요</h1>
      <p class="lead">전문가들의 재능을 찾고 배우세요</p>
    </div>
  </section>

  <div class="container">
    <div class="talent-search-container">
      <form id="talentSearchForm" method="GET" action="list.jsp">
        <div class="row g-3 align-items-center">
          <div class="col-md-4">
            <select name="category" class="form-select">
              <option value="">전체 카테고리</option>
              <option value="design" <%= "design".equals(category) ? "selected" : "" %>>디자인</option>
              <option value="programming" <%= "programming".equals(category) ? "selected" : "" %>>프로그래밍</option>
              <option value="marketing" <%= "marketing".equals(category) ? "selected" : "" %>>마케팅</option>
              <option value="writing" <%= "writing".equals(category) ? "selected" : "" %>>글쓰기</option>
              <option value="music" <%= "music".equals(category) ? "selected" : "" %>>음악</option>
              <option value="etc" <%= "etc".equals(category) ? "selected" : "" %>>기타</option>
            </select>
          </div>
          <div class="col-md-3">
            <select name="sort" class="form-select">
              <option value="latest">최신순</option>
              <option value="popular">인기순</option>
              <option value="price_low">가격 낮은순</option>
              <option value="price_high">가격 높은순</option>
            </select>
          </div>
          <div class="col-md-5">
            <div class="input-group">
              <input type="text" name="search" class="form-control" placeholder="재능을 검색해보세요" value="<%= search != null ? search : "" %>">
              <button class="btn btn-primary" type="submit">
                <i class="bi bi-search"></i> 검색
              </button>
            </div>
          </div>
        </div>
      </form>
    </div>

    <div class="talent-grid">
      <%
        for (Talent talent : talents) {
      %>
      <div class="talent-card">
        <a href="/page/detail.jsp?tno=<%=talent.getTno()%>">
          <div class="talent-card-body">
            <div class="talent-category-icon">
              <i class="bi <%= talent.getCategory().equals("design") ? "bi-palette" :
                            talent.getCategory().equals("programming") ? "bi-code-slash" :
                            talent.getCategory().equals("marketing") ? "bi-megaphone" :
                            talent.getCategory().equals("writing") ? "bi-pencil" :
                            talent.getCategory().equals("music") ? "bi-music-note" : "bi-stars" %>"></i>
            </div>
            <h5 class="card-title"><%= talent.getTitle() %></h5>
            <p class="talent-price"><%= talent.getPrice().intValue() %>원</p>
          </div>

        </a>
      </div>
      <%
        }
      %>
    </div>

    <nav aria-label="Page navigation">
      <ul class="pagination">
        <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
          <a class="page-link" href="?page=<%= currentPage - 1 %>&search=<%= search %>&category=<%= category %>" tabindex="-1">이전</a>
        </li>
        <%
          for (int i = 1; i <= totalPages; i++) {
        %>
        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
          <a class="page-link" href="?page=<%= i %>&search=<%= search %>&category=<%= category %>"><%= i %></a>
        </li>
        <%
          }
        %>
        <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
          <a class="page-link" href="?page=<%= currentPage + 1 %>&search=<%= search %>&category=<%= category %>">다음</a>
        </li>
      </ul>
    </nav>
  </div>
</main>

<%@ include file="/includePage/footer.jsp" %>
</body>
</html>
