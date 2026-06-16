<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매 요청 실패</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <style>
        .message-container {
            text-align: center;
            margin-top: 100px;
            font-family: 'Poor Story', cursive;
        }
        .message-container h2 {
            color: #cc3333;
        }
        .message-container a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #888;
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
        }
        .message-container a:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="message-container">
    <h2>구매 요청 중 오류가 발생했습니다.</h2>
    <a href="javascript:history.back()">이전 페이지로 돌아가기</a>
</div>
<script src="js/DarkToggle.js"></script>
</body>
</html>
