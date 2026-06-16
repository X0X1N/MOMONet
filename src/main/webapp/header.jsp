<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.MemberDTO" %>

<link rel="stylesheet" href="css/topbar.css">
<link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">

<div class="topbar">
  <div style="display: flex; align-items: center;">
    <a href="main.jsp" style="margin-right: 15px;">
      <img src="images/momoLogo.png" width="65" height="65" alt="로고" />
    </a>
    <a href="List.jsp">등록하기</a>
    <a href="Review.jsp">후기/평점</a>
    <a href="Notice.jsp">공지사항</a>
  </div>

  <div style="display: flex; align-items: center;">
    <%

      MemberDTO headerMember = (MemberDTO) session.getAttribute("member");
      if (headerMember != null) {
    %>
        <a href="mypage.jsp" style="font-weight:bold;color:#FF8A3D;margin:0 8px;">
          <%= headerMember.getStudentId() %> 님
        </a>
        <a href="LogoutServlet" style="margin-left:5px;">로그아웃</a>
    <%
      } else {
    %>
        <a href="login.jsp">로그인</a>
        <a href="singup.jsp">회원가입</a>
    <%
      }
    %>

    <div class="theme-toggle-container" style="margin-left:15px;">
      <button id="themeToggle" class="theme-toggle">
        <img src="images/moon.png" alt="테마">
      </button>
    </div>
  </div>
</div>
