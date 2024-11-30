<%@ page import="org.talent.donation.entity.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 관리 - 재능 공유 플랫폼</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Pretendard', sans-serif;
            background-color: #f3f4f6;
        }

        .gradient-border {
            position: relative;
            background: white;
            border-radius: 16px;
        }

        .gradient-border::before {
            content: "";
            position: absolute;
            inset: -2px;
            border-radius: 18px;
            background: linear-gradient(45deg, #4F46E5, #818CF8);
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .gradient-border:hover::before {
            opacity: 1;
        }

        .profile-upload-btn {
            position: absolute;
            bottom: -8px;
            right: -8px;
            background: linear-gradient(45deg, #4F46E5, #818CF8);
            color: white;
            padding: 12px;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .profile-upload-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 12px -1px rgba(0, 0, 0, 0.2);
        }

        .form-input {
            transition: all 0.3s ease;
        }

        .form-input:focus {
            border-color: #4F46E5;
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .custom-checkbox {
            position: relative;
            width: 3rem;
            height: 1.5rem;
            border-radius: 1.5rem;
            background-color: #e5e7eb;
            transition: all 0.3s ease;
        }

        .custom-checkbox::after {
            content: "";
            position: absolute;
            top: 2px;
            left: 2px;
            width: 1.25rem;
            height: 1.25rem;
            border-radius: 50%;
            background-color: white;
            transition: all 0.3s ease;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        input:checked + .custom-checkbox {
            background-color: #4F46E5;
        }

        input:checked + .custom-checkbox::after {
            transform: translateX(1.5rem);
        }
    </style>
</head>

<%
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
<body class="min-h-screen">
<%@ include file="/includePage/header.jsp" %>

<div class="container mx-auto px-4 py-12 max-w-4xl">
    <!-- 페이지 헤더 -->
    <div class="flex items-center justify-between mb-10">
        <div>
            <h1 class="text-3xl font-bold text-gray-900">프로필 관리</h1>
            <p class="text-gray-600 mt-2 text-lg">당신의 전문성을 돋보이게 해줄 프로필을 만들어보세요</p>
        </div>
        <a href="/mypage" class="text-gray-600 hover:text-gray-900 transition-colors">
            <i class="fas fa-times text-2xl"></i>
        </a>
    </div>

    <form action="/action/personal_modifyAction.jsp" enctype="multipart/form-data" method="post" class="space-y-8">
        <!-- 프로필 이미지 섹션 -->
        <div class="gradient-border p-8 bg-white">
            <h2 class="text-xl font-bold mb-6 text-gray-900">프로필 이미지</h2>
            <div class="flex items-center">
                <div class="relative group">
                    <div class="w-40 h-40 rounded-full overflow-hidden ring-4 ring-white shadow-lg">
                        <img src="/uploads/${sessionScope.loggedInUser.fileName}" alt="프로필 이미지"
                             class="w-full h-full object-cover">
                    </div>
                    <label for="profile-image-upload" class="profile-upload-btn">
                        <i class="fas fa-camera text-lg"></i>
                    </label>
                    <input type="file" id="profile-image-upload" name="profileImage" accept="image/*" class="hidden">
                </div>
                <div class="ml-8">
                    <p class="text-gray-600 mb-2"><i class="fas fa-info-circle mr-2"></i>권장 크기: 500x500px</p>
                    <p class="text-gray-600"><i class="fas fa-file-image mr-2"></i>JPG, PNG (최대 5MB)</p>
                </div>
            </div>
        </div>

        <!-- 기본 정보 섹션 -->
        <div class="gradient-border p-8 bg-white">
            <h2 class="text-xl font-bold mb-6 text-gray-900">기본 정보</h2>
            <div class="space-y-6">
                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700 mb-2">이름</label>
                    <input type="text" id="name" name="name" value="${sessionScope.loggedInUser.name}"
                           class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg text-gray-900">
                </div>

                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-2">이메일</label>
                    <input type="email" id="email" name="email" value="${sessionScope.loggedInUser.id}"
                           class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600"
                           readonly>
                    <p class="text-sm text-gray-500 mt-2 flex items-center">
                        <i class="fas fa-lock mr-2"></i>이메일은 변경할 수 없습니다
                    </p>
                </div>

                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700 mb-2">패스워드</label>
                    <input type="password" id="password" name="password"
                           class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg">
                </div>
            </div>
        </div>

        <!-- 저장 버튼 -->
        <div class="flex justify-end space-x-4">
            <a href="/mypage"
               class="px-6 py-3 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors duration-200">
                취소
            </a>
            <button type="submit"
                    class="px-6 py-3 bg-gradient-to-r from-indigo-600 to-indigo-500 text-white rounded-lg hover:from-indigo-700 hover:to-indigo-600 transition-all duration-200 shadow-lg hover:shadow-xl">
                저장하기
            </button>
        </div>
    </form>
</div>

<%@ include file="/includePage/footer.jsp" %>

<script>
    // 프로필 이미지 업로드 미리보기
    document.getElementById('profile-image-upload').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.querySelector('img').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // 글자 수 카운터
    const bioTextarea = document.getElementById('bio');
    const charCount = document.getElementById('char-count');

    bioTextarea.addEventListener('input', function() {
        const count = this.value.length;
        charCount.textContent = `${count}/200`;

        if (count > 200) {
            charCount.classList.add('text-red-500');
        } else {
            charCount.classList.remove('text-red-500');
        }
    });

    // 폼 제출 전 유효성 검사
    document.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault();

        const name = document.getElementById('name').value;
        const phone = document.getElementById('phone').value;
        const bio = document.getElementById('bio').value;

        if (!name.trim()) {
            alert('이름을 입력해주세요.');
            return;
        }

        if (!phone.trim()) {
            alert('연락처를 입력해주세요.');
            return;
        }

        if (bio.length > 200) {
            alert('자기소개는 200자를 초과할 수 없습니다.');
            return;
        }

        this.submit();
    });
</script>
</body>
</html>