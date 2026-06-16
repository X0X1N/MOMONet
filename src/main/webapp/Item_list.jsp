<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ItemDAO" %>
<%@ page import="dto.ItemDTO" %>
<%@ page import="java.util.List" %>
<%
    String query = request.getParameter("query");
    ItemDAO dao = new ItemDAO();
    List<ItemDTO> itemList;
    if (query != null && !query.trim().isEmpty()) {
        itemList = dao.searchBooks(query.trim());
    } else {
        itemList = dao.getAllBooks();
    }
%>

<html>
<head>
    <title>아이템 목록</title>
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
        --item-title: #FF8A3D;
        --item-meta: #bdbdbd;
        --item-price: #ffd900;
        --btn-bg: #FF8A3D;
        --btn-hover: #FF7000;
        --empty-text: #bdbdbd;
    }
    :root.light {
        --bg: #f4f4f4;
        --text: #222;
        --card-bg: #fff;
        --card-shadow: 0 4px 18px #e7e9f2;
        --section-bg: #f7f7fb;
        --accent: #FF8A3D;
        --search-bg: #fff;
        --input: #e9eef6;
        --border: #dbe3ea;
        --item-title: #FF8A3D;
        --item-meta: #868e96;
        --item-price: #FF8A3D;
        --btn-bg: #FF8A3D;
        --btn-hover: #FF7000;
        --empty-text: #bdbdbd;
    }
    html, body {
        background: var(--bg);
        color: var(--text);
        font-family: "Poor Story", "Pretendard", system-ui, sans-serif;
        transition: background 0.25s, color 0.25s;
    }
    .item-list { max-width:700px; margin:40px auto; }
    .item {
        background: var(--card-bg);
        border-radius: 15px;
        margin-bottom: 20px;
        padding: 18px 24px;
        box-shadow: var(--card-shadow);
        display: flex;
        align-items: center;
        position: relative;
        transition: background 0.22s, color 0.22s;
        border: 1.5px solid var(--border);
    }
    .item img {
        width:80px;
        height:100px;
        object-fit:cover;
        border-radius:8px;
        background:#eee;
        margin-right:28px;
    }
    .item-info { flex:1; }
    .item-title {
        font-size:1.18em;
        font-weight:bold;
        color: var(--item-title);
        margin-bottom: 3px;
    }
    .item-title a {
        color: var(--item-title);
        text-decoration: none;
        transition: color 0.2s;
    }
    .item-title a:hover {
        text-decoration: underline;
    }
    .item-meta {
        color: var(--item-meta);
        font-size:0.98em;
        margin-bottom: 1px;
    }
    .item-price {
        color: var(--item-price);
        font-weight: bold;
        margin-left: 8px;
        background: #ff8a3d22;
        border-radius: 6px;
        padding: 1px 10px;
        font-size: 1.01em;
        display: inline-block;
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
        transition: background 0.2s, color 0.2s;
    }
    .search-bar input::placeholder { color: #9db2cf; }
    .search-bar button {
        background: var(--btn-bg);
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
        background: var(--btn-hover);
    }
    .detail-btn {
        position: absolute;
        right: 28px;
        bottom: 22px;
        background: var(--btn-bg);
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 9px 25px;
        font-size: 1em;
        font-weight: 600;
        box-shadow: 0 2px 10px rgba(255,138,61,0.07);
        cursor: pointer;
        transition: background 0.15s;
        letter-spacing: 1px;
    }
    .detail-btn:hover {
        background: var(--btn-hover);
    }
    .empty-msg {
        color: var(--empty-text);
        text-align: center;
        margin-top: 60px;
        font-size: 1.1em;
    }
</style>

</head>
<body>
<%@ include file="header.jsp" %>
<div class="item-list">

      <form class="search-bar" action="Item_list.jsp" method="get">
            <input type="text" name="query" placeholder="검색어를 입력하세요">
            <button type="submit">검색</button>
        </form>

    <% if (itemList == null || itemList.isEmpty()) { %>
        <div style="color:#888; text-align:center;">등록된 아이템이 없습니다.</div>
    <% } else { 
        for (ItemDTO item : itemList) { %>
        <div class="item">
            <img src="uploads/<%= (item.getPhoto() != null && !item.getPhoto().isEmpty()) ? item.getPhoto() : "default_book.png" %>" alt="표지">
            <div class="item-info">
                <div class="item-title">
                     <a href="Item_detail.jsp?bookId=<%=item.getItemId()%>"><%= item.getTitle() %></a>
                </div>
                <div class="item-meta">
                    <% if ("book".equals(item.getItemType())) { %>
                        저자: <%= item.getAuthor() %> |
                        출판사: <%= item.getPublisher() %> |
                    <% } %>
                    <span class="item-price"><%= String.format("%,d", item.getPrice()) %>원</span>
                </div>
                <div class="item-meta">
                    판매자: <%= item.getSellerName() %>
                </div>
            </div>
            <!-- 상세보기 버튼 (맨 오른쪽 하단) -->
            <form action="Item_detail.jsp" method="get" style="display:inline;">
                <input type="hidden" name="bookId" value="<%=item.getItemId()%>">
                <button type="submit" class="detail-btn">상세보기</button>
            </form>
        </div>
    <%  } 
    } %>
</div>
<script src="js/DarkToggle.js"></script>
</body>
</html>
