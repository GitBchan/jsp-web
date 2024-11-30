<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.talent.donation.repository.TalentRepository" %>
<%@ page import="org.talent.donation.entity.Talent" %>
<%@ page import="org.talent.donation.entity.Member" %>
<%@ page import="org.talent.donation.repository.MemberRepository" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>디지털 일러스트레이션 재능 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.1.3/css/bootstrap.min.css">

    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2980b9;
            --accent-color: #e8f4fc;
            --text-color: #2c3e50;
            --light-text-color: #7f8c8d;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
            color: var(--text-color);
        }

        .talent-header {
            background: var(--primary-color);
            color: white;
            padding: 4rem 0;
        }

        /* .talent-header::before 스타일 제거 */

        .talent-content {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            padding: 2rem;
            margin-top: -4rem;
            position: relative;
        }

        .portfolio-image {
            border-radius: 0.5rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .portfolio-image:hover {
            transform: scale(1.02);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }


        .price-badge {
            background-color: var(--secondary-color);
            color: var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-weight: 600;
        }

        .star-rating {
            display: inline-flex;
            align-items: center;
            color: #fbbf24;
        }

        .booking-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            background-color: var(--accent-color);
            border-radius: 0.5rem;
            padding: 2rem;
            margin-top: 2rem;
        }

        .provider-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .provider-profile img {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            object-fit: cover;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-group-vertical .btn {
            text-align: left;
            padding: 0.5rem 1rem;
            border-radius: 0.25rem !important;
            margin-bottom: 0.5rem;
        }
    </style>

    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 240" style="display:none;">
        <!-- Design Icon -->
        <symbol id="design-icon" viewBox="0 0 240 240">
            <circle cx="120" cy="120" r="80" fill="#FF7F50" opacity="0.1"/>
            <!-- 심플한 브러시 스트로크 -->
            <path d="M80 160c30-40 50-40 80-20c30 20 50 10 60 0
             c-10 20-30 40-60 40c-30 0-60-10-80-20z"
                  fill="#FF7F50"
                  opacity="0.7"/>
            <!-- 심플한 펜 도구 -->
            <path d="M140 80l20 20l-60 60l-20-20z"
                  fill="#FF7F50"/>
        </symbol>

        <!-- Programming Icon -->
        <symbol id="programming-icon" viewBox="0 0 240 240">
            <circle cx="120" cy="120" r="80" fill="#4169E1" opacity="0.1"/>
            <path d="M90 100l-30 20 30 20M150 100l30 20-30 20" stroke="#4169E1" stroke-width="8" fill="none"/>
            <path d="M130 80l-20 80" stroke="#4169E1" stroke-width="8"/>
        </symbol>

        <!-- Marketing Icon -->
        <symbol id="marketing-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 240">
            <!-- 배경 원 -->
            <circle cx="120" cy="120" r="100" fill="#4A90E2" opacity="0.1"/>

            <!-- 메가폰 -->
            <path d="M70 120 L90 100 L160 80 L160 140 L90 120 L70 120"
                  fill="#4A90E2"
                  stroke="#4A90E2"
                  stroke-width="2"/>

            <!-- 확성기에서 나오는 파동 효과 -->
            <path d="M165 110 Q175 110 180 110 M185 110 Q195 110 200 110"
                  stroke="#4A90E2"
                  stroke-width="4"
                  stroke-linecap="round"
                  fill="none"/>
            <path d="M165 100 Q180 100 190 100 M195 100 Q205 100 210 100"
                  stroke="#4A90E2"
                  stroke-width="4"
                  stroke-linecap="round"
                  fill="none"/>
            <path d="M165 120 Q180 120 190 120 M195 120 Q205 120 210 120"
                  stroke="#4A90E2"
                  stroke-width="4"
                  stroke-linecap="round"
                  fill="none"/>

            <!-- 그래프 요소 -->
            <path d="M70 160 L90 140 L110 150 L130 120 L150 130"
                  fill="none"
                  stroke="#4A90E2"
                  stroke-width="4"
                  stroke-linecap="round"/>

            <!-- 데이터 포인트 -->
            <circle cx="90" cy="140" r="4" fill="#4A90E2"/>
            <circle cx="110" cy="150" r="4" fill="#4A90E2"/>
            <circle cx="130" cy="120" r="4" fill="#4A90E2"/>
            <circle cx="150" cy="130" r="4" fill="#4A90E2"/>
        </symbol>



        <!-- Writing Icon -->
        <symbol id="writing-icon" viewBox="0 0 240 240">
            <circle cx="120" cy="120" r="80" fill="#9370DB" opacity="0.1"/>
            <path d="M90 160h60M90 140h60M90 120h60" stroke="#9370DB" stroke-width="8" stroke-linecap="round"/>
            <path d="M150 80l-60 0c-11 0-20 9-20 20v60c0 11 9 20 20 20h60c11 0 20-9 20-20v-60c0-11-9-20-20-20z"
                  stroke="#9370DB" stroke-width="8" fill="none"/>
        </symbol>

        <!-- Music Icon -->
        <symbol id="music-icon" viewBox="0 0 240 240">
            <circle cx="120" cy="120" r="80" fill="#FFD700" opacity="0.1"/>
            <circle cx="100" cy="160" r="15" fill="#FFD700"/>
            <circle cx="160" cy="140" r="15" fill="#FFD700"/>
            <path d="M115 160v-80l60-20v80" stroke="#FFD700" stroke-width="8" fill="none"/>
        </symbol>

        <!-- Default Icon -->
        <symbol id="default-icon" viewBox="0 0 240 240">
            <circle cx="120" cy="120" r="80" fill="#A9A9A9" opacity="0.1"/>
            <path d="M120 70l18 36 40 6-29 28 7 40-36-19-36 19 7-40-29-28 40-6z" fill="#A9A9A9"/>
        </symbol>
    </svg>
</head>

<%
    Long tno = Long.parseLong(request.getParameter("tno"));
    TalentRepository repository = new TalentRepository();
    Talent talent = repository.findById(tno);

    MemberRepository memberRepository = new MemberRepository();
    Member talentOwner = memberRepository.findByMno(talent.getMemberId());

    request.setAttribute("talent", talent);
    request.setAttribute("talentOwner", talentOwner);


    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");

    if (successMessage != null) {
%>
<script>
    alert("<%=successMessage%>")
</script>

<%
    }

    if (errorMessage != null) {
%>
<script>
    alert("<%=errorMessage%>")
</script>

<%
    }

%>
<body>

<%@ include file="/includePage/header.jsp" %>

<!-- 재능 헤더 -->
<header class="talent-header text-center">
    <div class="container position-relative">
        <h1 class="display-4 fw-bold mb-3"><%=talent.getTitle()%>
        </h1>
        <div class="d-flex justify-content-center align-items-center">
            <div class="star-rating me-2">
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-half"></i>
            </div>
            <span class="text-white">(4.5/5점, 128개의 평가)</span>
        </div>
    </div>
</header>

<div class="container">
    <div class="talent-content">
        <div class="row g-4">
            <!-- 포트폴리오 이미지 -->
            <div class="col-lg-6">
                <div id="portfolioCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <c:choose>
                                <c:when test="${talent.image == null}">
                                    <div class="category-icon-wrapper"
                                         style="width: 100%; padding-bottom: 100%; position: relative;">
                                        <svg class="w-100 h-100" style="position: absolute; top: 0; left: 0;"
                                             viewBox="0 0 240 240">
                                            <use href="#${talent.category == 'design' ? 'design-icon' :
                     talent.category == 'programming' ? 'programming-icon' :
                     talent.category == 'marketing' ? 'marketing-icon' :
                     talent.category == 'writing' ? 'writing-icon' :
                     talent.category == 'music' ? 'music-icon' : 'default-icon'}"
                                            />
                                        </svg>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <img src="/uploads/${talent.image}" class="d-block w-100 portfolio-image"
                                         alt="이미지">
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>

                </div>
            </div>

            <!-- 재능 정보 -->
            <div class="col-lg-6">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <span class="badge bg-primary rounded-pill px-3 py-2"><%=talent.getCategory()%></span>
                    <span class="price-badge">₩<%=talent.getPrice().intValue()%>부터</span>
                </div>

                <h2 class="h3 mb-4"><%=talent.getTitle()%>
                </h2>
                <p class="lead mb-4"><%=talent.getDescription()%>
                </p>
            </div>
        </div>

        <form method="post" action="/action/detailAction.jsp">
            <!-- 예약 및 제공자 섹션 -->
            <div class="booking-container mt-5">
                <!-- 제공자 정보 -->
                <div class="provider-profile">
                    <img src="/uploads/<%=talentOwner.getFileName()%>" alt="제공자 프로필">
                    <div>
                        <h4 class="mb-1"><%=talentOwner.getName()%>
                        </h4>
                    </div>
                </div>

                <!-- 예약 섹션 -->
                <div class="calendar-section">
                    <h3 class="h4 mb-3">날짜 및 시간 선택</h3>
                    <div class="mb-3">
                        <label for="datePicker" class="form-label">날짜 선택</label>
                        <input type="date" name="date" class="form-control" id="datePicker">
                    </div>
                    <div>
                        <label class="form-label d-block mb-2">시간 선택</label>
                        <div class="btn-group-vertical w-100" role="group">
                            <input type="radio" class="btn-check" name="timeOption" id="time-09-11" value="1"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary text-start" for="time-09-11">09:00 - 11:00</label>

                            <input type="radio" class="btn-check" name="timeOption" id="time-11-13" value="2"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary text-start" for="time-11-13">11:00 - 13:00</label>

                            <input type="radio" class="btn-check" name="timeOption" id="time-13-15" value="3"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary text-start" for="time-13-15">13:00 - 15:00</label>

                            <input type="radio" class="btn-check" name="timeOption" id="time-15-17" value="4"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary text-start" for="time-15-17">15:00 - 17:00</label>

                            <input type="radio" class="btn-check" name="timeOption" id="time-17-19" value="5"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary text-start" for="time-17-19">17:00 - 19:00</label>
                        </div>
                    </div>
                    <input type="hidden" name="talent" value="<%=talent.getTno()%>">
                    <input type="hidden" name="talentOwner" value="<%=talent.getMemberId()%>">
                    <input type="hidden" name="price" value="<%=talent.getPrice().intValue()%>">
                </div>
            </div>

            <!-- 문의 및 구매 버튼 -->
            <div class="mt-5 text-center">
                <button class="btn btn-primary btn-lg me-3 px-4 py-2" data-bs-toggle="modal" type="button"
                        data-bs-target="#inquiryModal" data-bs-backdrop="static">
                    <i class="bi bi-chat-dots me-2"></i>문의하기
                </button>
                <button type="submit" class="btn btn-success btn-lg px-4 py-2">
                    <i class="bi bi-cart me-2"></i>예약하기
                </button>
            </div>
        </form>


    </div>
</div>

<!-- 문의하기 모달 -->
<div class="modal fade" id="inquiryModal" tabindex="-1" aria-labelledby="inquiryModalLabel" aria-hidden="true">
    <form method="post" action="/action/detail_modalAction.jsp">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="inquiryModalLabel">재능에 대해 문의하기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="inquiryMessage" class="form-label">문의 내용</label>
                        <textarea class="form-control" name="inquiryMessage" id="inquiryMessage" rows="3"
                                  placeholder="문의 내용을 작성해주세요."></textarea>
                        <input type="hidden" name="talent" value="<%=talent.getTno()%>">
                        <input type="hidden" name="talentOwner" value="<%=talent.getMemberId()%>">

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary">제출</button>
                </div>
            </div>
        </div>
    </form>
</div>

<%@ include file="/includePage/footer.jsp" %>


<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
    document.getElementById("datePicker").addEventListener("change", function () {
        const selectedDate = this.value;
        const talentId = "<%=talent.getTno()%>";

        fetch(`/action/checkAvailability.jsp?talentId=${talentId}&date=${selectedDate}`)
            .then(response => response.json())
            .then(data => {
                // 모든 시간대 버튼을 활성화한 뒤 상태에 따라 비활성화
                document.querySelectorAll("input[name='timeOption']").forEach(button => {
                    button.disabled = false;
                });

                // `AVAILABLE`이 아닌 상태의 시간대를 비활성화
                data.timeSlots.forEach(slot => {
                    const timeOption = document.querySelector(`input[name='timeOption'][value='${slot.timeSlot}']`);
                    if (timeOption) {
                        timeOption.disabled = true; // `AVAILABLE`이 아닌 시간대는 비활성화
                    }
                });
            })
            .catch(error => {
                console.error("시간대 상태를 불러오는 데 실패했습니다.", error);
            });
    })

</script>
</body>
</html>
