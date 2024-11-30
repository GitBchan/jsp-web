<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="org.talent.donation.repository.MemberRepository" %>
<%@ page import="org.talent.donation.entity.Member" %>

<%
  // 세션에서 현재 로그인한 사용자 가져오기
  Member loggedInUser = (Member) session.getAttribute("loggedInUser");

  if (loggedInUser == null) {
    // 로그인이 되어 있지 않다면 로그인 페이지로 이동
    response.sendRedirect("/page/login.jsp");
    return;
  }

  // 프로필 이미지 저장 경로 설정 (예: 서버의 특정 폴더)
  String uploadPath = getServletContext().getRealPath("/uploads");
  int maxFileSize = 5 * 1024 * 1024; // 5MB 제한
  String encoding = "UTF-8";

  String name = null;
  String password = null;
  String fileName = null;

  try {
    // MultipartRequest 객체 생성으로 파일 업로드와 파라미터 처리를 동시에 수행
    MultipartRequest multi = new MultipartRequest(
            request,
            uploadPath,
            maxFileSize,
            encoding,
            new DefaultFileRenamePolicy()
    );

    // 폼 데이터 가져오기
    name = multi.getParameter("name");
    password = multi.getParameter("password");

    // 업로드된 파일 이름 가져오기
    fileName = multi.getFilesystemName("profileImage");

  } catch (Exception ex) {
    ex.printStackTrace();
    session.setAttribute("errorMessage", "파일 업로드 중 오류가 발생했습니다.");
    response.sendRedirect("/page/personal_modify.jsp");
    return;
  }

  // 업데이트할 회원 정보 객체 생성
  Member updatedMember = new Member()
          .builder()
          .mno(loggedInUser.getMno())
          .name(name)
          .password(password.isEmpty() ? password : loggedInUser.getPassword())
          .fileName(fileName) // 파일 이름 저장
          .build();

  // MemberRepository의 update 메서드 호출하여 데이터베이스에 저장
  MemberRepository repository = new MemberRepository();
  try {
    repository.update(updatedMember);

    // 세션에 수정된 사용자 정보 업데이트
    session.setAttribute("loggedInUser", updatedMember);

    // 성공 메시지를 세션에 추가하고 프로필 페이지로 리다이렉트
    session.setAttribute("successMessage", "프로필이 성공적으로 업데이트되었습니다.");
    response.sendRedirect("/page/personal.jsp");
  } catch (Exception e) {
    e.printStackTrace();
    session.setAttribute("errorMessage", "프로필 업데이트 중 오류가 발생했습니다.");
    response.sendRedirect("/page/personal_modify.jsp");
  }
%>
