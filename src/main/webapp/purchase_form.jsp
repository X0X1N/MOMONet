<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ItemDAO, dto.ItemDTO" %>
<%
    String itemIdStr = request.getParameter("itemId");
    int itemId = (itemIdStr != null && !itemIdStr.isEmpty()) ? Integer.parseInt(itemIdStr) : 0;
    ItemDAO dao = new ItemDAO();
    ItemDTO item = dao.getBookById(itemId);
%>
<html>
<head>
    <title>직거래 요청 - MOMONet</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #121212; --text: #fff; --card-bg: #1c1d23; --card-shadow: 0 6px 18px rgba(0,0,0,0.14);
            --section-bg: #181920; --accent: #FF8A3D; --search-bg: #222328;
            --input: #2a2a2a; --border: #35394b;
        }
        :root.light {
            --bg: #f4f4f4; --text: #1b263b; --card-bg: #fff; --card-shadow: 0 4px 18px #e7e9f2;
            --section-bg: #f7f7fb; --accent: #FF8A3D; --search-bg: #fff; --input: #e9eef6; --border: #dbe3ea;
        }
        html, body { background: var(--bg); color: var(--text); font-family: 'Poor Story', "Pretendard", system-ui, sans-serif; }
        .purchase-form-container {
            max-width: 540px; margin: 60px auto; background: var(--card-bg); border-radius: 17px;
            box-shadow: var(--card-shadow); padding: 36px 28px 34px 28px;
        }
        .item-summary { display: flex; gap: 18px; align-items: center; margin-bottom: 32px; }
        .item-summary img {
            width: 85px; height: 110px; object-fit: cover; border-radius: 10px; background: #eee;
        }
        .item-summary-info { flex: 1;}
        .item-summary-title { font-size: 1.19em; font-weight: bold; color: var(--accent);}
        .item-summary-price { color: #ffd900; font-weight: bold; margin-top: 7px;}
        .purchase-form-row { margin-bottom: 22px;}
        label { display: block; margin-bottom: 8px; font-weight: bold; color: var(--accent);}
        input[type="text"], input[type="datetime-local"], textarea {
            width: 100%; padding: 10px 13px; border-radius: 8px;
            background: var(--input); color: var(--text);
            border: 1.5px solid var(--border); font-size: 1em;
        }
        textarea { resize: vertical; min-height: 48px;}
        .btn-purchase { width: 100%; background: var(--accent); color: #fff;
            border: none; padding: 14px 0; border-radius: 9px;
            font-size: 1.09em; font-weight: bold; margin-top: 9px; cursor: pointer;
            box-shadow: 0 2px 8px #00000013; transition: background 0.2s;
        }
        .btn-purchase:hover { background: #e37116;}
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="purchase-form-container">
    <!-- 상품 요약 -->
    <div class="item-summary">
        <img src="uploads/<%= (item != null && item.getPhoto() != null && !item.getPhoto().isEmpty()) ? item.getPhoto().split(",")[0] : "default_book.png" %>" alt="상품사진">
        <div class="item-summary-info">
            <div class="item-summary-title"><%= item != null ? item.getTitle() : "상품정보 없음" %></div>
            <div class="item-summary-price"><%= item != null ? String.format("%,d원", item.getPrice()) : "" %></div>
        </div>
    </div>
    <!-- 직거래 폼 -->
    <form action="PurchaseServlet" method="post">
        <input type="hidden" name="itemId" value="<%= itemId %>">
        <div class="purchase-form-row">
            <label for="tradeTime">희망 거래 시간</label>
            <input type="datetime-local" id="tradeTime" name="tradeTime" required>
        </div>
        <div class="purchase-form-row">
            <label for="tradePlace">희망 거래 장소</label>
            <input type="text" id="location" name="location" placeholder="예) 우당관 8층 로비" required>
        </div>
        <div class="purchase-form-row">
            <label for="memo">요청 메모 (선택)</label>
            <textarea id="memo" name="memo" placeholder="전달사항이 있으면 적어주세요."></textarea>
        </div>
        <button type="submit" class="btn-purchase">구매 요청 보내기</button>
    </form>
</div>
<script src="js/DarkToggle.js"></script>
</body>
</html>
