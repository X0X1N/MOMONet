<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head>
    <title>MOMONet Forgot Password?</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">

    <style>
        .findpw-container {
            margin-top: 120px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .findpw-box {
            background-color: var(--card-bg, #fff);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 350px;
        }

        .findpw-box h2 {
            text-align: center;
            margin-bottom: 20px;
            font-family: "Poor Story", system-ui;
            color: #000 !important;
        }

        .findpw-box input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .findpw-box button {
            width: 100%;
            padding: 10px;
            background-color: #FF8A3D;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .findpw-box button:hover {
            background-color: #FF8A3D;
        }
    </style>
</head>
<body>
<% String msg = (String) request.getAttribute("msg");
   if (msg != null) { %>
   <div style="color:#FF8A3D;text-align:center;"><%= msg %></div>
<% } %>
<%@ include file="header.jsp" %>
<div class="findpw-container">
    <div class="findpw-box">
        <h2>비밀번호를 잊으셨나요?</h2>
        <form action="FindPasswordServlet" method="post">
            <input type="text" name="studentId" placeholder="ID" required>
            <input type="email" name="email" placeholder="Email" required>
            <button type="submit">reset password</button>
        </form>
    </div>
</div>

<script src="js/DarkToggle.js"></script>
</body>
</html>
