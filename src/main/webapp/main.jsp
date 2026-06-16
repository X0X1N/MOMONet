<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,dao.ItemDAO" %>
<%@ page import="java.util.*,dto.ItemDTO" %>
<%
    ItemDAO dao = new ItemDAO();
    List<ItemDTO> allItems = dao.getAllBooks();
    List<ItemDTO> bestItems = allItems.size() > 3 ? allItems.subList(0, 3) : allItems;
%>
<html>
<head>
    <title>MOMONet.com</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #121212;
            --text: #fff;
            --card-bg: #1c1d23;
            --card-shadow: 0 6px 18px rgba(0,0,0,0.14);
            --section-bg: #181920;
            --accent: #FF8A3D;
            --search-bg: #222328;
            --input: #2a2a2a;
            --border: #35394b;
        }
        :root.light {
            --bg: #f4f4f4;
            --text: #1b263b;
            --card-bg: #fff;
            --card-shadow: 0 4px 18px #e7e9f2;
            --section-bg: #f7f7fb;
            --accent: #FF8A3D;
            --search-bg: #fff;
            --input: #e9eef6;
            --border: #dbe3ea;
        }
        html, body {
            background: var(--bg);
            color: var(--text);
            font-family: 'Poor Story', "Pretendard", system-ui, sans-serif;
            transition: background 0.25s, color 0.25s;
        }
        .main-container {
            max-width: 950px;
            margin: 40px auto 40px auto;
            padding: 0 20px;
        }
     
        .search-bar {
            width: 100%;
            max-width: 470px;
            margin: 0 auto 40px auto;
            display: flex;
            background: var(--search-bg);
            border-radius: 11px;
            box-shadow: var(--card-shadow);
            border: 1.5px solid var(--border);
        }
        .search-bar input {
            flex: 1;
            padding: 15px 18px;
            background: var(--input);
            border: none;
            border-radius: 11px 0 0 11px;
            color: var(--text);
            font-size: 1.08em;
            outline: none;
            transition: background 0.2s;
        }
        .search-bar input::placeholder { color: #9db2cf; }
        .search-bar button {
            background: var(--accent);
            color: #fff;
            border: none;
            border-radius: 0 11px 11px 0;
            font-size: 1.12em;
            font-weight: bold;
            padding: 0 30px;
            cursor: pointer;
            letter-spacing: 1px;
            transition: background 0.15s;
        }
        .search-bar button:hover {
            background: #e37116;
        }
     
        .section-title {
            font-size: 1.33em;
            color: var(--accent);
            margin: 42px 0 19px 0;
            font-weight: bold;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .section-title:first-of-type {
            margin-top: 0;
        }
        .fire-emoji {
            font-size: 1.23em;
        }
       
        .items-row {
            display: flex;
            gap: 21px;
            flex-wrap: wrap;
            justify-content: flex-start;
        }
        .item-card {
            background: var(--card-bg);
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            padding: 22px 17px 18px 17px;
            flex: 1 1 220px;
            min-width: 210px;
            max-width: 260px;
            text-align: center;
            transition: transform 0.17s, box-shadow 0.17s;
            border: 1.5px solid var(--border);
            position: relative;
        }
        .items-row .item-card:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: 0 12px 32px rgba(0,0,0,0.21);
            border-color: var(--accent);
            z-index: 1;
        }
        .item-card img {
            width: 95px;
            height: 125px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 12px;
            background: #eee;
            box-shadow: 0 2px 8px #0001;
            transition: filter 0.2s;
        }
        .item-card .item-title {
            font-size: 1.12em;
            color: var(--accent);
            font-weight: bold;
            margin-bottom: 5px;
        }
        .item-card .item-price {
            color: #ffd900;
            background: #ff8a3d22;
            border-radius: 6px;
            font-weight: bold;
            padding: 4px 12px;
            font-size: 1.09em;
            display: inline-block;
        }
       
        .all-items-list {
            margin-top: 32px;
            background: var(--section-bg);
            border-radius: 14px;
            padding: 20px 14px;
            box-shadow: var(--card-shadow);
        }
        .all-items-list .item-card {
            display: flex;
            align-items: center;
            text-align: left;
            min-width: 100%;
            max-width: 100%;
            gap: 26px;
            margin-bottom: 16px;
            background: none;
            border: none;
            box-shadow: none;
            border-radius: 0;
            padding: 0 0 10px 0;
            border-bottom: 1px solid var(--border);
            transition: none;
            position: relative;
            flex-wrap: wrap;
        }
        .all-items-list .item-card:hover {
         
            transform: none;
            box-shadow: none;
            border-color: var(--border);
            z-index: auto;
        }
        .all-items-list img {
            width: 62px;
            height: 82px;
            border-radius: 7px;
            background: #eee;
            margin: 0;
        }
        .item-meta {
            font-size: 0.97em;
            color: #7b8998;
            margin: 2px 0 8px 0;
        }
        .all-items-list .item-title {
            color: var(--accent);
            font-weight: bold;
            font-size: 1.07em;
            margin-bottom: 2px;
        }
        .all-items-list .item-price {
            color: var(--accent);
            font-size: 1.01em;
            background: #fff2;
            border-radius: 5px;
            padding: 2px 10px;
            display: inline-block;
            font-weight: bold;
        }

        .all-items-list .detail-btn-area {
            width: 100%;
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }
        .all-items-list .detail-btn {
            position: static;
            background: #ff8a3d;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 7px 28px;
            font-size: 0.97em;
            font-weight: 600;
            box-shadow:0 1.5px 6px rgba(255,138,61,0.07);
            cursor: pointer;
            transition: background 0.15s;
            letter-spacing: 1px;
            margin: 0;
            display: inline-block;
        }
        .all-items-list .detail-btn:hover {
            background: #ff6800;
        }
        @media (max-width: 740px) {
            .main-container { padding: 0 6px;}
            .items-row { flex-direction: column; gap: 11px;}
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="main-container">

       
        <form class="search-bar" action="Item_list.jsp" method="get">
            <input type="text" name="query" placeholder="검색어를 입력하세요">
            <button type="submit">검색</button>
        </form>

        <div class="section-title"><span class="fire-emoji">🔥</span>최근에 등록된 상품</div>
        <div class="items-row">
            <%
                for(ItemDTO item : bestItems) {
            %>
            <div class="item-card">
                <a href="Item_detail.jsp?bookId=<%=item.getItemId()%>">
                    <img src="uploads/<%= (item.getPhoto() != null && !item.getPhoto().isEmpty()) ? item.getPhoto() : "default_book.png" %>" alt="상품사진">
                    <div class="item-title"><%= item.getTitle() %></div>
                    <div class="item-price"><%= String.format("%,d", item.getPrice()) %>원</div>
                </a>
            </div>
            <% } %>
        </div>

        <div class="section-title">전체 상품</div>
        <div class="all-items-list">
            <%
                for(ItemDTO item : allItems) {
            %>
            <div class="item-card">
                <img src="uploads/<%= (item.getPhoto() != null && !item.getPhoto().isEmpty()) ? item.getPhoto() : "default_book.png" %>" alt="상품사진">
                <div style="flex:1;">
                    <div class="item-title"><%= item.getTitle() %></div>
                    <div class="item-meta">
                        <% if ("book".equals(item.getItemType())) { %>
                            저자: <%= item.getAuthor() != null ? item.getAuthor() : "-" %> | 출판사: <%= item.getPublisher() != null ? item.getPublisher() : "-" %>
                        <% } else if ("device".equals(item.getItemType())) { %>
                            브랜드: <%= item.getBrand() != null ? item.getBrand() : "-" %> | 모델명: <%= item.getModel() != null ? item.getModel() : "-" %>
                        <% } else { %>
                            상태: <%= item.getStatus() != null ? item.getStatus() : "-" %>
                        <% } %>
                    </div>
                    <div class="item-price"><%= String.format("%,d", item.getPrice()) %>원</div>
                    <div class="detail-btn-area">
                        <form action="Item_detail.jsp" method="get" style="margin:0;">
                            <input type="hidden" name="bookId" value="<%= item.getItemId() %>">
                            <button type="submit" class="detail-btn">상세보기</button>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <script src="js/DarkToggle.js"></script>
</body>
</html>
