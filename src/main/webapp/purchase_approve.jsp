<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ItemDAO, dto.ItemDTO, dao.PurchaseRequestDAO, dto.PurchaseRequestDTO" %>
<%
    String itemIdStr = request.getParameter("itemId");
    String requestIdStr = request.getParameter("requestId"); 
    int itemId = (itemIdStr != null && !itemIdStr.isEmpty()) ? Integer.parseInt(itemIdStr) : 0;
    int requestId = (requestIdStr != null && !requestIdStr.isEmpty()) ? Integer.parseInt(requestIdStr) : 0;

    ItemDAO itemDao = new ItemDAO();
    ItemDTO item = itemDao.getBookById(itemId);

    PurchaseRequestDAO reqDao = new PurchaseRequestDAO();
    PurchaseRequestDTO req = reqDao.getRequestById(requestId); 
%>
<html>
<head>
    <title>구매 요청 상세 - MOMONet</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #121212; --text: #fff; --card-bg: #1c1d23; --card-shadow: 0 6px 18px rgba(0,0,0,0.14);
            --section-bg: #181920; --accent: #FF8A3D; --input: #2a2a2a; --border: #35394b;
        }
        :root.light {
            --bg: #f4f4f4; --text: #1b263b; --card-bg: #fff; --card-shadow: 0 4px 18px #e7e9f2;
            --section-bg: #f7f7fb; --accent: #FF8A3D; --input: #e9eef6; --border: #dbe3ea;
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
        .value-box { padding: 12px 14px; border-radius: 8px; background: var(--input); color: var(--text); border: 1.5px solid var(--border);}
        label { display: block; margin-bottom: 8px; font-weight: bold; color: var(--accent);}
        .btn-group { display: flex; gap: 16px; margin-top: 24px; }
        .btn-approve, .btn-reject {
            flex: 1 1 0; padding: 13px 0; font-size: 1.06em; border-radius: 8px; font-weight: bold; cursor: pointer; border: none;
        }
        .btn-approve { background: var(--accent); color: #fff; }
        .btn-approve:hover { background: #e37116;}
        .btn-reject { background: #fff; color: #d13333; border: 2px solid #d13333;}
        .btn-reject:hover { background: #ffdada;}
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
    <!-- 요청 정보 -->
    <div class="purchase-form-row">
        <label>희망 거래 시간</label>
        <div class="value-box"><%= req != null && req.getRequestDate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(req.getRequestDate()) : "-" %></div>
    </div>
    <div class="purchase-form-row">
        <label>희망 거래 장소</label>
        <div class="value-box"><%= req != null && req.getLocation() != null ? req.getLocation() : "-" %></div>
    </div>
    <div class="purchase-form-row">
        <label>요청 메모</label>
        <div class="value-box"><%= req != null && req.getMemo() != null ? req.getMemo() : "-" %></div>
    </div>
    <!-- 승인/거절 버튼 -->
    <form action="ApproveRequestServlet" method="post" style="margin-top:32px;">
        <input type="hidden" name="requestId" value="<%= requestId %>">
        <input type="hidden" name="itemId" value="<%= itemId %>">
        <div class="btn-group">
            <button type="submit" name="action" value="approve" class="btn-approve">승인</button>
            <button type="submit" name="action" value="reject" class="btn-reject">거절</button>
        </div>
    </form>
</div>
<script src="js/DarkToggle.js"></script>
</body>
</html>
