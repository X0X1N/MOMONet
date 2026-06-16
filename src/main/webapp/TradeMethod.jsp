<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <title>거래 방법 선택</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
        body {
            background: #f4f4f4;
            color: #222;
            font-family: 'Poor Story', "Pretendard", system-ui, sans-serif;
        }
        .trade-container {
            max-width: 410px;
            margin: 100px auto 0 auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.09);
            padding: 36px 28px 28px 28px;
            text-align: center;
        }
        .trade-container h2 {
            color: #2250a2;
            margin-bottom: 20px;
        }
        .method-box {
            margin: 22px 0;
            padding: 18px;
            border-radius: 10px;
            background: #faf7f2;
            font-size: 1.11em;
            border: 1.5px solid #ffe2bf;
        }
        .method-box b {
            color: #FF8A3D;
            font-size: 1.1em;
        }
        .confirm-btn {
            background: #FF8A3D;
            color: #fff;
            border: none;
            padding: 13px 0;
            width: 100%;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            margin-top: 12px;
            transition: background 0.19s;
        }
        .confirm-btn:hover {
            background: #e37116;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="trade-container">
        <h2>거래 방법 선택</h2>
        <div class="method-box">
            <b>직거래 (만나서 결제)</b><br>
            현재 결제 시스템은 지원하지 않습니다.<br>
            상품의 판매자와 직접 연락하여<br>
            만나서 결제 및 상품을 전달받으세요.<br><br>
            <span style="color:#c87811;">※ 안전한 장소에서 만나세요!</span>
        </div>
        <form action="TradeConfirm.jsp" method="post">
            <input type="hidden" name="itemId" value="<%= request.getParameter("itemId") %>">
            <button type="submit" class="confirm-btn">이 방법으로 거래 진행</button>
        </form>
    </div>
<script src="js/DarkToggle.js"></script>
</body>
</html>
