<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.MemberDTO" %>
<%
    MemberDTO member = (MemberDTO) request.getAttribute("member");
%>
<html>
<head>
    <title>프로필 수정 | MOMONet</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #121212;
            --text: #fff;
            --card-bg: #1c1d23;
            --card-shadow: 0 6px 18px rgba(0,0,0,0.14);
            --accent: #FF8A3D;
            --input-bg: #2a2a2a;
            --input-text: #fff;
            --input-border: #35394b;
            --input-placeholder: #aaa;
            --btn-bg: #FF8A3D;
            --btn-text: #fff;
            --btn-hover: #FF7000;
            --message-text: #fff;
            --success-text: #1eae66;
        }
        .light {
            --bg: #f4f4f4;
            --text: #1b263b;
            --card-bg: #fff;
            --card-shadow: 0 4px 18px #e7e9f2;
            --accent: #FF8A3D;
            --input-bg: #e9eef6;
            --input-text: #222;
            --input-border: #dbe3ea;
            --input-placeholder: #9db2cf;
            --btn-bg: #FF8A3D;
            --btn-text: #fff;
            --btn-hover: #FF7000;
            --message-text: #222;
            --success-text: #1eae66;
        }
        html, body {
            background: var(--bg);
            color: var(--text);
            font-family: 'Poor Story', "Pretendard", system-ui, sans-serif;
            transition: background 0.25s, color 0.25s;
        }
        .edit-profile-container {
            margin-top: 110px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        .edit-profile-box {
            background: var(--card-bg);
            color: var(--text);
            padding: 34px 35px 25px 35px;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            width: 350px;
            transition: background 0.25s, color 0.25s;
        }
        .edit-profile-box h2 {
            text-align: center;
            margin-bottom: 20px;
            font-family: "Poor Story", system-ui;
            color: var(--text);
            font-size: 1.42em;
            font-weight: bold;
        }
        .edit-profile-box label {
            display: block;
            margin: 15px 0 7px 3px;
            font-weight: bold;
            color: var(--text);
            opacity: 0.92;
        }
        .edit-profile-box input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            margin: 6px 0 13px 0;
            background: var(--input-bg);
            color: var(--input-text);
            border: 1.5px solid var(--input-border);
            border-radius: 8px;
            font-size: 1.05em;
            transition: border 0.18s, background 0.18s, color 0.18s;
            box-sizing: border-box;
        }
        .edit-profile-box input[type="password"]::placeholder {
            color: var(--input-placeholder);
            opacity: 1;
        }
        .edit-profile-box input[type="password"]:focus {
            border: 1.5px solid var(--accent);
            background: #1a1a1a33;
            outline: none;
            color: var(--input-text);
        }
        .edit-profile-box button {
            width: 100%;
            padding: 12px 0;
            background-color: var(--btn-bg);
            color: var(--btn-text);
            border: none;
            border-radius: 8px;
            margin-top: 18px;
            font-size: 1.09em;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.15s, color 0.15s;
        }
        .edit-profile-box button:hover {
            background: var(--btn-hover);
        }
        .message {
            margin-bottom: 10px;
            text-align: center;
            color: var(--message-text);
            font-size: 0.99em;
            transition: color 0.22s;
        }
        .message.success {
            color: var(--success-text);
        }
        @media (max-width: 500px) {
            .edit-profile-box { width: 97vw; padding: 20px 4vw 18px 4vw;}
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="edit-profile-container">
    <div class="edit-profile-box">
        <h2>비밀번호 재설정</h2>
        <%
            String message = (String)request.getAttribute("message");
            if (message != null) {
        %>
            <div class="message"><%= message %></div>
        <%
            }
            String successMessage = (String)request.getAttribute("successMessage");
            if (successMessage != null) {
        %>
            <div class="message success"><%= successMessage %></div>
        <%
            }
        %>
        <form action="UpdatePasswordServlet" method="post" onsubmit="return validateEditForm()">
            <label for="password">새 비밀번호</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="변경 시에만 입력(6~20자)">
            
            <label for="confirmPassword">새 비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="동일하게 입력">

            <button type="submit">수정하기</button>
        </form>
    </div>
</div>

<script>
function validateEditForm() {
    const pw = document.getElementById('newPassword').value.trim();
    const pw2 = document.getElementById('confirmPassword').value.trim();
    if (pw || pw2) {
        if (pw.length < 6 || pw.length > 20) {
            alert("비밀번호는 6~20자로 입력하세요.");
            return false;
        }
        if (pw !== pw2) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }
    }
    return true;
}
</script>
<script src="js/DarkToggle.js"></script>
</body>
</html>


