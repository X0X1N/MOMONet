<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>거래 승인 대기 중</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <style>
        body { 
            font-family: 'Poor Story', Arial, sans-serif; 
            background: #f7f7fb; 
            color: #1b263b;
            margin: 0;
            padding: 0;
        }
        .confirm-container { 
            max-width: 420px; 
            margin: 80px auto; 
            background: #fff; 
            border-radius: 14px; 
            box-shadow: 0 4px 16px #e7e9f2; 
            padding: 44px 32px;
            text-align: center;
        }
        .waiting {
            font-size: 1.35em; 
            color: #FF8A3D; 
            font-weight: bold; 
            text-align: center;
            margin-bottom: 20px;
        }
        .desc { 
            color: #333; 
            margin: 25px 0 18px 0; 
            text-align: center;
        }
        .btn-row { 
            display: flex; 
            gap: 12px; 
            justify-content: center; 
            margin-top: 30px;
        }
        .main-btn, .refresh-btn {
            background: #FF8A3D;
            color: #fff;
            border: none;
            padding: 13px 26px;
            border-radius: 8px;
            font-size: 1.05em;
            cursor: pointer;
            transition: background 0.17s;
        }
        .main-btn:hover, .refresh-btn:hover { 
            background: #e37116; 
        }
        .loader {
            border: 7px solid #f3f3f3;
            border-top: 7px solid #FF8A3D;
            border-radius: 50%;
            width: 48px;
            height: 48px;
            animation: spin 1s linear infinite;
            margin: 0 auto 25px auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg);}
            100% { transform: rotate(360deg);}
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="confirm-container">
    <div class="loader"></div>
    <div class="waiting">상대방의 승인 대기 중...</div>
    <div class="desc">
        판매자 또는 구매자가 거래 요청을 확인하면<br>
        <b>거래가 진행</b>됩니다.<br><br>
     
    </div>
    <div class="btn-row">
        <a href="mypage.jsp"><button class="main-btn">마이페이지로 돌아가기</button></a>
    </div>
</div>

<script src="js/DarkToggle.js"></script>
</body>
</html>
