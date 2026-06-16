<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.PurchaseRequestDTO" %>
<%@ page import="dao.ItemDAO" %>
<%@ page import="dto.ItemDTO" %>
<%
    Object pendingRequestsObj = request.getAttribute("pendingRequests");
    List<PurchaseRequestDTO> pendingRequests = null;
    if (pendingRequestsObj instanceof List<?>) {
        pendingRequests = (List<PurchaseRequestDTO>) pendingRequestsObj;
    }
    ItemDAO itemDAO = new ItemDAO();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>판매자 구매 요청 승인</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #181a22;
            --text: #fff;
            --accent: #FF8A3D;
            --border: #393c47;
            --card-bg: #1c1f28;
            --thead-bg: #232336;
            --thead-text: #ffbb6b;
            --btn-green: #23b26d;
            --btn-green-hover: #159e5d;
            --btn-red: #ef4a55;
            --btn-red-hover: #be3640;
            --muted: #9a9fab;
            --radius: 13px;
            --shadow: 0 4px 22px 0 rgba(14,18,30,0.17);
        }
        body {
            margin: 0;
            padding: 0;
            background: var(--bg);
            color: var(--text);
            font-family: 'Poor Story', 'Pretendard', 'Apple SD Gothic Neo', Arial, sans-serif;
            transition: background 0.23s, color 0.23s;
        }
        .main-container {
            max-width: 1060px;
            margin: 48px auto 0;
            background: var(--card-bg);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 36px 32px 56px 32px;
            min-height: 540px;
            transition: background 0.23s;
        }
        h2 {
            color: var(--accent);
            font-weight: 700;
            font-size: 2rem;
            margin: 16px 0 32px 0;
            letter-spacing: 1.2px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: var(--card-bg);
            border-radius: var(--radius);
            overflow: hidden;
            margin-top: 20px;
            box-shadow: 0 2px 10px rgba(20,30,50,0.08);
            color: var(--text);
            transition: background 0.23s, color 0.23s;
        }
        thead tr {
            background: var(--thead-bg);
            color: var(--thead-text);
            font-weight: bold;
            font-size: 1.05em;
            transition: background 0.23s, color 0.23s;
        }
        th, td {
            padding: 15px 8px;
            text-align: center;
            border-bottom: 1.5px solid var(--border);
            vertical-align: middle;
            background: var(--card-bg);
            color: var(--text);
            transition: background 0.23s, color 0.23s;
        }
        th {
            font-size: 1.05em;
            letter-spacing: 0.5px;
        }
        tbody tr:last-child td {
            border-bottom: none;
        }
        tbody tr {
            transition: background 0.13s;
        }
        tbody tr:hover {
            background: #26284a;
        }
        .item-title {
            font-weight: bold;
            color: var(--accent);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .product-img {
            width: 52px;
            height: 52px;
            vertical-align: middle;
            border-radius: 7px;
            object-fit: cover;
            background: #232336;
            border: 1.2px solid var(--border);
            box-shadow: 0 1.5px 4px #faad5055;
        }
        .status-span {
            font-size: 0.97em;
            font-weight: 500;
            color: var(--muted);
        }
        form {
            margin: 0;
            display: inline-block;
        }
        button[name="action"][value="approve"] {
            background-color: var(--btn-green);
        }
        button[name="action"][value="approve"]:hover {
            background-color: var(--btn-green-hover);
        }
        button[name="action"][value="reject"] {
            background-color: var(--btn-red);
        }
        button[name="action"][value="reject"]:hover {
            background-color: var(--btn-red-hover);
        }
        button {
            padding: 8px 18px;
            margin: 0 3px;
            font-weight: 600;
            font-size: 0.96em;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            color: #fff;
            box-shadow: 0 1.5px 6px #0004;
            letter-spacing: 0.5px;
            transition: background 0.15s;
        }
        .empty-message {
            text-align: center;
            padding: 48px 0 32px 0;
            color: var(--muted);
            font-size: 1.15rem;
        }

        /* Light mode override */
        body.light, :root.light, .light .main-container {
            --bg: #f7f7fa;
            --text: #222;
            --accent: #FF8A3D;
            --border: #e0e3eb;
            --card-bg: #fff;
            --thead-bg: #ffe3c4;
            --thead-text: #ff7300;
            --btn-green: #23b26d;
            --btn-green-hover: #159e5d;
            --btn-red: #ef4a55;
            --btn-red-hover: #be3640;
            --muted: #bdbdbd;
            --radius: 13px;
            --shadow: 0 4px 22px 0 rgba(24,40,100,0.07);
        }
        .light body, .light .main-container {
            background: var(--bg);
            color: var(--text);
        }
        .light table,
        .light th,
        .light td {
            background: var(--card-bg);
            color: var(--text);
        }
        .light thead tr {
            background: var(--thead-bg);
            color: var(--thead-text);
        }
        .light tbody tr:hover {
            background: #fffae9;
        }
        .light .product-img {
            background: #f7f7f7;
        }
        .light .status-span {
            color: var(--muted);
        }
        .light .empty-message {
            color: var(--muted);
        }
        @media (max-width: 900px) {
            .main-container { padding: 20px 5vw 32px 5vw;}
            th, td { padding: 10px 2.5vw; font-size: 0.94em; }
        }
        @media (max-width: 600px) {
            .main-container { padding: 7vw 2vw; min-width: 0;}
            table, thead, tbody, th, td, tr { font-size: 0.92em; }
            .product-img { width: 34px; height: 34px;}
            h2 { font-size: 1.16rem; }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="main-container">
    <h2>구매 요청 승인 대기 목록</h2>
    <%
        if (pendingRequests == null || pendingRequests.isEmpty()) {
    %>
        <p class="empty-message">
            현재 승인 대기 중인 구매 요청이 없습니다.
        </p>
    <%
        } else {
    %>
    <table>
        <thead>
            <tr>
                <th>상품명</th>
                <th>구매자 ID</th>
                <th>구매자 이름</th>
                <th>가격</th>
                <th>희망 거래 시간</th>
                <th>희망 거래 장소</th>
                <th>요청 메모</th>
                <th>요청일</th>
                <th>상태</th>
                <th>승인 / 거절</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (PurchaseRequestDTO pr : pendingRequests) {
                    ItemDTO item = itemDAO.getBookById(pr.getItemId());
                    String title = (item != null) ? item.getTitle() : "상품 정보 없음";
                    String price = (item != null) ? String.format("%,d 원", item.getPrice()) : "-";
                    String photo = (item != null && item.getPhoto() != null && !item.getPhoto().isEmpty())
                        ? request.getContextPath() + "/uploads/" + item.getPhoto()
                        : request.getContextPath() + "/images/default_book.png";
                    String buyerName = pr.getBuyerName() != null ? pr.getBuyerName() : "-";
                    String reqDate = pr.getRequestDate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(pr.getRequestDate()) : "-";
                    String tradeTime = pr.getTradeTime() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(pr.getTradeTime()) : "-";
                    String location = pr.getLocation() != null ? pr.getLocation() : "-";
                    String memo = pr.getMemo() != null ? pr.getMemo() : "-";
                    String status = pr.getStatus() != null ? pr.getStatus() : "대기";
            %>
            <tr>
                <td class="item-title">
                    <img src="<%= photo %>" alt="상품 이미지" class="product-img">
                    <%= title %>
                </td>
                <td><%= pr.getBuyerId() %></td>
                <td><%= buyerName %></td>
                <td><%= price %></td>
                <td><%= tradeTime %></td>
                <td><%= location %></td>
                <td><%= memo %></td>
                <td><%= reqDate %></td>
                <td>
                    <span class="status-span"><%= status %></span>
                </td>
                <td>
				    <% if ("대기".equals(status)) { %>
    					<form method="post" action="SellerApprovalServlet" style="display:inline;">
        				<input type="hidden" name="requestId" value="<%= pr.getRequestId() %>">
        				<button type="submit" name="action" value="approve" onclick="return confirm('승인하시겠습니까?');">승인</button>
        				<button type="submit" name="action" value="reject" onclick="return confirm('거절하시겠습니까?');">거절</button>
    				</form>
    				<% } else { %>
        					<span class="status-span"><%= status %></span>
    				<% } %>
				</td>

            </tr>
            <% } %>
        </tbody>
    </table>
    <% } %>
</div>
<script src="js/DarkToggle.js"></script>
</body>
</html>
