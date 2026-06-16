<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <title>MOMONet Join</title>
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
            --signup-link: #FF8A3D;
            --signup-link-text: #fff;
            --message-text: #fff;
            --success-text: #1eae66;
            --signup-title: #fff;
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
            --signup-link: #FF8A3D;
            --signup-link-text: #222;
            --message-text: #222;
            --success-text: #1eae66;
            --signup-title: #222;
        }
        html, body {
            background: var(--bg);
            color: var(--text);
            font-family: 'Poor Story', "Pretendard", system-ui, sans-serif;
            transition: background 0.25s, color 0.25s;
        }
        .signup-container {
            margin-top: 120px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        .signup-box {
            background: var(--card-bg);
            color: var(--text);
            padding: 32px 28px 28px 28px;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            width: 350px;
            transition: background 0.25s, color 0.25s;
        }
        .signup-box h2 {
            text-align: center;
            margin-bottom: 22px;
            font-family: "Poor Story", system-ui, sans-serif;
            color: var(--signup-title);
            font-size: 1.6em;
            font-weight: bold;
            letter-spacing: 1.5px;
            transition: color 0.25s;
        }
        .signup-box input[type="text"],
        .signup-box input[type="password"],
        .signup-box input[type="email"] {
            width: 100%;
            padding: 12px 14px;
            margin: 9px 0 16px 0;
            background: var(--input-bg);
            color: var(--input-text);
            border: 1.5px solid var(--input-border);
            border-radius: 8px;
            font-size: 1.05em;
            transition: border 0.18s, background 0.18s, color 0.18s;
            box-sizing: border-box;
        }
        .signup-box input[type="text"]::placeholder,
        .signup-box input[type="password"]::placeholder,
        .signup-box input[type="email"]::placeholder {
            color: var(--input-placeholder);
            opacity: 1;
        }
        .signup-box input[type="text"]:focus,
        .signup-box input[type="password"]:focus,
        .signup-box input[type="email"]:focus {
            border: 1.5px solid var(--accent);
            background: #1a1a1a33;
            outline: none;
            color: var(--input-text);
        }
        .signup-box button {
            width: 100%;
            padding: 12px 0;
            background-color: var(--btn-bg);
            color: var(--btn-text);
            border: none;
            border-radius: 8px;
            font-size: 1.09em;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 12px;
            box-shadow: 0 2px 8px #00000013;
            transition: background 0.15s, color 0.15s;
        }
        .signup-box button:hover {
            background: var(--btn-hover);
        }
        .signup-box .link-buttons {
            display: flex;
            justify-content: flex-end;
            width: 100%;
            margin-top: 5px;
        }
        .signup-box .link-buttons a {
            font-size: 1em;
            color: var(--signup-link-text);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.25s, text-decoration 0.15s;
        }
        .signup-box .link-buttons a:hover {
            text-decoration: underline;
        }
        .message {
            margin-bottom: 8px;
            text-align: center;
            color: var(--message-text);
            font-size: 0.97em;
            transition: color 0.25s;
        }
        .message.success {
            color: var(--success-text);
        }
        @media (max-width: 500px) {
            .signup-box { width: 97vw; padding: 20px 4vw 18px 4vw;}
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="signup-container">
    <div class="signup-box">
        <h2>회원가입</h2>
        <%
            String message = (String)request.getAttribute("message");
            if (message != null) {
        %>
            <div class="message"><%= message %></div>
        <%
            }
        %>
        <form name="joinForm" action="SignupServlet" method="post" onsubmit="return validateForm()">
            <input type="text" name="studentId" placeholder="ID" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="email" name="email" placeholder="Email" required>
            <button type="submit">회원가입</button>
        </form>
        <div class="link-buttons">
            <a href="login.jsp">이미 회원가입 하셨나요?</a>
        </div>
    </div>
</div>

<script>
function validateForm() {
    var studentId = document.forms["joinForm"]["studentId"].value.trim();
    var password = document.forms["joinForm"]["password"].value.trim();
    var email = document.forms["joinForm"]["email"].value.trim();

    var idPattern =/^[0-9]{7}$/;
    if (!idPattern.test(studentId)) {
        alert("ID는 학번을 입력해주세요.");
        document.forms["joinForm"]["studentId"].focus();
        return false;
    }

    var pwPattern = /^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d!@#$%^&*]{6,20}$/;
    if (!pwPattern.test(password)) {
        alert("비밀번호는 6~20자, 영문과 숫자를 모두 포함해야 합니다.");
        document.forms["joinForm"]["password"].focus();
        return false;
    }

    var emailPattern = /^[\w\.-]+@[\w\.-]+\.\w{2,}$/;
    if (!emailPattern.test(email)) {
        alert("이메일 형식이 올바르지 않습니다.");
        document.forms["joinForm"]["email"].focus();
        return false;
    }
    return true;
}
</script>
<script src="js/DarkToggle.js"></script>
</body>
</html>
