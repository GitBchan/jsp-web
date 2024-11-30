<%@ page import="org.talent.donation.repository.MemberRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page import="org.talent.donation.entity.Talent" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Talent Sharing Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">

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
            color: var(--text-color);
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            background-attachment: fixed;
        }

        /* 히어로 섹션 새 디자인 */

        /* 히어로 섹션 스타일 */
        .hero-section {
            position: relative;
            padding: 8rem 0;
            background: linear-gradient(
                    to right bottom,
                    #2980b9,
                    #3498db,
                    #5dade2
            );
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.08'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            opacity: 0.1;
        }

        .hero-section::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(
                    to bottom,
                    transparent,
                    rgba(41, 128, 185, 0.1)
            );
        }

        .hero-section .container {
            position: relative;
            z-index: 2;
        }

        .hero-section h1 {
            font-size: 4rem;
            font-weight: 700;
            color: white;
            margin-bottom: 1.5rem;
            letter-spacing: -0.02em;
            line-height: 1.2;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .hero-section p {
            font-size: 1.5rem;
            color: rgba(255, 255, 255, 0.95);
            margin-bottom: 2.5rem;
            font-weight: 400;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        .hero-section .btn {
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .hero-section .btn-light {
            background: rgba(255, 255, 255, 0.95);
            border: none;
            color: #2980b9;
        }

        .hero-section .btn-outline-light {
            border-width: 2px;
        }

        .hero-section .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }


        /* 이용방법 섹션 개선 */
        .how-it-works {
            background: white;
            padding: 5rem 0;
            position: relative;
        }

        .how-it-works::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(52, 152, 219, 0.05), rgba(231, 76, 60, 0.05));
            z-index: 1;
        }

        .how-it-works .container {
            position: relative;
            z-index: 2;
        }

        .how-it-works h2 {
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1rem;
            color: var(--text-color);
        }

        .section-description {
            text-align: center;
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 3rem;
        }

        .steps {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .step {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            z-index: 1;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .step:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .step-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary-color), #2980b9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: white;
        }

        .step h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--text-color);
        }

        .step p {
            color: #666;
            margin: 0;
            line-height: 1.6;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .step {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .step:nth-child(1) {
            animation-delay: 0.1s;
        }

        .step:nth-child(2) {
            animation-delay: 0.2s;
        }

        .step:nth-child(3) {
            animation-delay: 0.3s;
        }

        .step:nth-child(4) {
            animation-delay: 0.4s;
        }

        /* 카테고리 카드 스타일 유지 */
        .category-card {
            background: white;
            border-radius: 15px;
            transition: all 0.3s ease;
            width: 100%;
            min-height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: var(--text-color);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 1rem;
        }

        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
        }

        .popular-talents {
            padding: 5rem 0;
            background: linear-gradient(to bottom, #ffffff, #f8f9fa);
        }

        .popular-talents h2 {
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }

        .popular-talents .subtitle {
            text-align: center;
            color: #6c757d;
            margin-bottom: 3rem;
            font-size: 1.1rem;
        }

        .talent-card {
            border: none;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.02);
            background: white;
        }

        .talent-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
        }

        .talent-card .card-img-top {
            height: 200px;
            object-fit: cover;
            transition: all 0.3s ease;
        }

        .talent-card:hover .card-img-top {
            transform: scale(1.05);
        }

        .talent-card .card-body {
            padding: 1.5rem;
        }

        .talent-card .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 3rem;
        }

        .talent-card .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .talent-card .price {
            font-size: 1.25rem;
            font-weight: 700;
            color: #3498db;
        }

        .talent-card .rating-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .talent-card .rating {
            color: #f1c40f;
            font-size: 0.9rem;
        }

        .talent-card .rating-number {
            color: #6c757d;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .talent-card .category-badge {
            display: inline-block;
            padding: 0.4rem 0.8rem;
            background: rgba(52, 152, 219, 0.1);
            color: #3498db;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 1rem;
        }

        .talent-card .btn-detail {
            background-color: #3498db;
            border: none;
            color: white;
            padding: 0.8rem;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .talent-card .btn-detail:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        .image-wrapper {
            position: relative;
            overflow: hidden;
        }

        .overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            padding: 1rem;
            color: white;
            font-weight: 500;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .talent-card:hover .overlay {
            opacity: 1;
        }
    </style>
</head>
<body>
<%@ include file="/includePage/header.jsp" %>


<%
    if (session.getAttribute("loggedInUser") == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("login_token".equals(cookie.getName())) {
                    String token = cookie.getValue();

                    // 토큰을 통해 사용자를 조회하여 세션에 로그인 정보 설정
                    MemberRepository repository = new MemberRepository();
                    Member member = repository.findByToken(token);
                    if (member != null) {
                        session.setAttribute("loggedInUser", member);
                    }

                    response.sendRedirect("/page/main.jsp");
                }
            }
        }
    }

    TalentRepository talentRepository = new TalentRepository();
    List<Talent> talentList = talentRepository.findTop3ByRating();

%>
<main>
    <!-- 히어로 섹션 -->
    <section class="hero-section">
        <div class="container text-center">
            <h1>당신의 재능을<br>나눠보세요</h1>
            <p class="lead">전문가들과 함께 성장하는 재능 공유 플랫폼</p>
            <div>
                <a href="register.jsp" class="btn btn-light rounded-pill me-3">시작하기</a>
                <a href="list.jsp" class="btn btn-outline-light rounded-pill">재능 둘러보기</a>
            </div>
        </div>
    </section>

    <!-- 소개 섹션 -->
    <section class="py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="mb-4">재능을 공유하고 성장하세요</h2>
                    <p class="lead">업계 전문가들과 함께 자신의 재능을 나누고 새로운 기술을 배워보세요. 고객들과의 만남을 통해 비즈니스 기회를 확장할 수 있습니다.</p>
                </div>
                <div class="col-md-6 text-end">
                    <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" fill="currentColor"
                         class="bi bi-arrow-left-right" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                              d="M1 11.5a.5.5 0 0 0 .5.5h11.793l-3.147 3.146a.5.5 0 0 0 .708.708l4-4a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 11H1.5a.5.5 0 0 0-.5.5m14-7a.5.5 0 0 1-.5.5H2.707l3.147 3.146a.5.5 0 1 1-.708.708l-4-4a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 4H14.5a.5.5 0 0 1 .5.5"/>
                    </svg>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" fill="currentColor"
                         class="bi bi-stack-overflow" viewBox="0 0 16 16">
                        <path d="M12.412 14.572V10.29h1.428V16H1v-5.71h1.428v4.282z"/>
                        <path d="M3.857 13.145h7.137v-1.428H3.857zM10.254 0 9.108.852l4.26 5.727 1.146-.852zm-3.54 3.377 5.484 4.567.913-1.097L7.627 2.28l-.914 1.097zM4.922 6.55l6.47 3.013.603-1.294-6.47-3.013zm-.925 3.344 6.985 1.469.294-1.398-6.985-1.468z"/>
                    </svg>
                </div>
                <div class="col-md-6">
                    <h2 class="mb-4">전문가들과 함께 성장하세요</h2>
                    <p class="lead">다양한 분야의 전문가들과 교류하며 새로운 영감과 기회를 얻을 수 있습니다. 함께 배우고 협업하며 당신의 재능을 발전시켜 보세요.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="mb-4">고객들과 만나보세요</h2>
                    <p class="lead">당신의 재능을 소개하고 고객들과 직접 소통할 수 있습니다. 이를 통해 새로운 비즈니스 기회를 얻어 보세요.</p>
                </div>
                <div class="col-md-6 text-end">
                    <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128" fill="currentColor"
                         class="bi bi-wechat" viewBox="0 0 16 16">
                        <path d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.32.32 0 0 0-.12.366l.218.81a.6.6 0 0 1 .029.117.166.166 0 0 1-.162.162.2.2 0 0 1-.092-.03l-1.057-.61a.5.5 0 0 0-.256-.074.5.5 0 0 0-.142.021 5.7 5.7 0 0 1-1.576.22M9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.6.6 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.63.63 0 0 0 .098.356"/>
                        <path d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.5.5 0 0 0-.032.14.19.19 0 0 0 .193.193q.06 0 .111-.029l1.268-.733a.6.6 0 0 1 .308-.088q.088 0 .171.025a6.8 6.8 0 0 0 1.625.26 4.5 4.5 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02l.15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826m4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0m3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0"/>
                    </svg>
                </div>
            </div>
        </div>
    </section>

    <section class="how-it-works">
        <div class="container">
            <h2>이용 방법</h2>
            <p class="section-description">재능교환은 간단한 4단계로 이루어집니다. 지금 바로 시작해보세요!</p>
            <div class="steps">
                <div class="step">
                    <div class="step-icon">👤</div>
                    <h3>프로필 생성</h3>
                    <p>당신의 재능과 배우고 싶은 기술을 소개하세요.</p>
                </div>
                <div class="step">
                    <div class="step-icon">🔍</div>
                    <h3>재능 찾기</h3>
                    <p>다양한 분야의 전문가들을 만나보세요.</p>
                </div>
                <div class="step">
                    <div class="step-icon">💬</div>
                    <h3>연결하기</h3>
                    <p>관심 있는 사람과 직접 대화를 나누고 일정을 잡으세요.</p>
                </div>
                <div class="step">
                    <div class="step-icon">🌟</div>
                    <h3>재능 교환</h3>
                    <p>서로의 재능을 나누고 새로운 기술을 습득하세요.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 인기 재능 섹션 -->
    <section class="popular-talents">
        <div class="container">
            <h2>인기 재능</h2>
            <p class="subtitle">가장 인기 있는 재능을 만나보세요</p>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <% for(Talent talent : talentList) { %>
                <div class="col">
                    <div class="talent-card card h-100">
                        <div class="image-wrapper">
                            <div class="overlay">
                                자세히 보기
                            </div>
                        </div>
                        <div class="card-body">
                            <span class="category-badge"><%= talent.getCategory() %></span>
                            <h5 class="card-title"><%= talent.getTitle() %></h5>
                            <div class="info-row">
                                <span class="price"><%= String.format("%,d원부터", talent.getPrice().intValue()) %></span>
                                <div class="rating-group">
                                    <div class="rating">
                                        <%
                                            Double rating = (talent.getRating() != null) ? talent.getRating().doubleValue() : 0.0;
                                            for(int i = 0; i < 5; i++) {
                                                if(i < Math.floor(rating)) {
                                        %>
                                        <i class="bi bi-star-fill"></i>
                                        <% } else if(i + 0.5 <= rating) { %>
                                        <i class="bi bi-star-half"></i>
                                        <% } else { %>
                                        <i class="bi bi-star"></i>
                                        <% }
                                        }
                                        %>
                                    </div>
                                    <span class="rating-number"><%= String.format("%.1f", rating) %></span>
                                </div>
                            </div>
                            <a href="/page/detail.jsp?tno=<%= talent.getTno() %>" class="btn btn-detail w-100">
                                재능 둘러보기
                            </a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </section>


    <!-- 카테고리 섹션 -->
    <section class="section-alternate">
        <div class="container section-content">
            <h2 class="text-center mb-5">인기 카테고리</h2>
            <div class="row justify-content-center g-4">
                <div class="col-6 col-md-4">
                    <a href="/page/list.jsp?category=design&search=" class="category-card">
                        <i class="bi bi-palette category-icon"></i>
                        <h5 class="category-title">디자인</h5>
                    </a>
                </div>
                <div class="col-6 col-md-4">
                    <a href="/page/list.jsp?category=programming&search=" class="category-card">
                        <i class="bi bi-code-slash category-icon"></i>
                        <h5 class="category-title">프로그래밍</h5>
                    </a>
                </div>
                <div class="col-6 col-md-4">
                    <a href="/page/list.jsp?category=marketing&search=" class="category-card">
                        <i class="bi bi-megaphone category-icon"></i>
                        <h5 class="category-title">마케팅</h5>
                    </a>
                </div>
            </div>
        </div>
    </section>

</main>

<%@ include file="/includePage/footer.jsp" %>
</body>
</html>