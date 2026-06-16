<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.List, dto.PurchaseRequestDTO" %>
<%
    List<PurchaseRequestDTO> pendingRequests = (List<PurchaseRequestDTO>) request.getAttribute("pendingRequests");
    if (pendingRequests == null) pendingRequests = new java.util.ArrayList<>();
%>
<html>
<head>
    <title>구매 요청 목록 | MOMONet</title>
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
            background: var(--bg);
            color: var(--text);
            font-family: 'Poor Story', 'Pretendard', Arial, sans-serif;
            margin: 0;
        }
        .main-container {
            max-width: 1060px;
            margin: 48px auto 0;
            background: var(--card-bg);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 36px 32px 56px 32px;
            min-height: 540px;
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
        }
        thead tr {
            background: var(--thead-bg);
            color: var(--thead-text);
            font-weight: bold;
            font-size: 1.05em;
        }
        th, td {
            padding: 15px 8px;
            text-align: center;
            border-bottom: 1.5px solid var(--border);
            vertical-align: middle;
        }
        th { letter-spacing: 0.5px; }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr:hover { background: #26284a; }
        .status-span {
            font-size: 0.97em;
            font-weight: 600;
            color: var(--muted);
        }
        button[name="action"][value="approve"] { background-color: var(--btn-green);}
        button[name="action"][value="approve"]:hover { background-color: var(--btn-green-hover);}
        button[name="action"][value="reject"] { background-color: var(--btn-red);}
        button[name="action"][value="reject"]:hover { background-color: var(--btn-red-hover);}
        button {
            padding: 8px 18px;
            font-weight: 600;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            color: #fff;
            box-shadow: 0 1.5px 6px #0004;
            letter-spacing: 0.5px;
        }
        .empty-message {
            text-align: center;
            padding: 48px 0 32px 0;
            color: var(--muted);
            font-size: 1.15rem;
        }
        /* 라이트모드 */
        :root.light, .light body, .light .main-container {
            --bg: #f7f7fa;
            --text: #222;
            --accent: #FF8A3D;
            --border: #e0e3eb;
            --card-bg: #fff;
            --thead-bg: #ffe3c4;
            --thead-text: #ff7300;
            --muted: #bdbdbd;
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
        .light .status-span {
            color: var(--muted);
        }
        .light .empty-message {
            color: var(--muted);
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="main-container">
    <h2>구매 요청 승인 대기 목록</h2>
    <%
        if (pendingRequests.isEmpty()) {
    %>
        <p class="empty-message">현재 승인 대기 중인 구매 요청이 없습니다.</p>
    <%
        } else {
    %>
    <table>
        <thead>
            <tr>
                <th>상품 ID</th>
                <th>구매자 ID</th>
                <th>구매자 이름</th>
                <th>희망 거래 시간</th>
                <th>희망 거래 장소</th>
                <th>요청 메모</th>
                <th>요청일</th>
                <th>상태</th>
                <th>승인 / 거절</th>
            </tr>
        </thead>
        <tbody>
            <% for (dto.PurchaseRequestDTO req : pendingRequests) { %>
            <tr>
                <td><%= req.getItemId() %></td>
                <td><%= req.getBuyerId() %></td>
                <td><%= req.getBuyerName() != null ? req.getBuyerName() : "-" %></td>
                <td><%= req.getTradeTime() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(req.getTradeTime()) : "-" %></td>
                <td><%= req.getLocation() != null ? req.getLocation() : "-" %></td>
                <td><%= req.getMemo() != null ? req.getMemo() : "-" %></td>
                <td><%= req.getRequestDate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(req.getRequestDate()) : "-" %></td>
                <td>
                    <span class="status-span"><%= req.getStatus() %></span>
                </td>
                <td>
                    <% if ("대기".equals(req.getStatus())) { %>
                        <form method="post" action="SellerApprovalServlet" style="display:inline;">
                            <input type="hidden" name="requestId" value="<%= req.getRequestId() %>">
                            <button type="submit" name="action" value="approve" onclick="return confirm('승인하시겠습니까?');">승인</button>
                            <button type="submit" name="action" value="reject" onclick="return confirm('거절하시겠습니까?');">거절</button>
                        </form>
                    <% } else { %>
                        <span class="status-span"><%= req.getStatus() %></span>
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
