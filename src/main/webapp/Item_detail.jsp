<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.ItemDAO" %>
<%@ page import="dto.ItemDTO" %>
<%@ page import="dto.MemberDTO" %>

<%
    if (session.getAttribute("member") == null) {
%>
    <script>
        alert("로그인 후 이용 가능합니다.");
        location.href = "login.jsp";
    </script>
<%
        return;
    }

    String itemIdParam = request.getParameter("itemId");
    if (itemIdParam == null || itemIdParam.trim().equals("")) {
        itemIdParam = request.getParameter("bookId");
    }
    if (itemIdParam == null || itemIdParam.trim().equals("")) {
%>
    <h3>잘못된 접근입니다.</h3>
<%
        return;
    }

    int itemId = 0;
    try {
        itemId = Integer.parseInt(itemIdParam);
    } catch (NumberFormatException e) {
%>
    <h3>잘못된 itemId 입니다.</h3>
<%
        return;
    }

    ItemDAO dao = new ItemDAO();
    ItemDTO item = dao.getBookById(itemId);
    if (item == null) {
%>
    <h3>존재하지 않는 아이템입니다.</h3>
<%
        return;
    }
    MemberDTO member = (MemberDTO) session.getAttribute("member");
%>

<html>
<head>
    <meta charset="UTF-8">
    <title><%= item.getTitle() %> | 아이템 상세</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/topbar.css">
    <link rel="icon" href="<%=request.getContextPath()%>/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #121212;
            --text: #fff;
            --card-bg: #1c1d23;
            --card-shadow: 0 6px 18px rgba(0,0,0,0.14);
            --label: #fff;
            --title: #fff;
        }
        :root.light {
            --bg: #f4f4f4;
            --text: #222;
            --card-bg: #fff;
            --card-shadow: 0 6px 24px rgba(48,64,120,0.06);
            --label: #222;
            --title: #222;
        }
        html, body {
            background: var(--bg);
            color: var(--text);
            font-family: 'Poor Story', 'Pretendard', system-ui, sans-serif;
            transition: background 0.25s, color 0.25s;
        }
        .book-detail-container {
            max-width: 900px;
            margin: 60px auto 30px auto;
            background: var(--card-bg);
            border-radius: 28px;
            min-height: 350px;
            box-shadow: var(--card-shadow);
            padding: 38px 30px 40px 30px;
        }
        .detail-row {
            display: flex;
            align-items: flex-start;
            gap: 30px;
            flex-wrap: wrap;
        }
        .book-img {
            width: 260px;
            height: 270px;
            object-fit: cover;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            background: #eee;
            flex-shrink: 0;
            cursor: pointer;
        }
        .book-info {
            flex: 1 1 320px;
        }
        .book-info h2 {
            font-size: 2em;
            margin: 0 0 20px 0;
            color: var(--title);
            font-weight: bold;
            letter-spacing: 1px;
        }
        .info-label {
            color: var(--label);
            font-weight: bold;
            width: 110px;
            display: inline-block;
            vertical-align: top;
            font-size: 1.09em;
            margin-bottom: 4px;
        }
        .book-info > div {
            margin-bottom: 10px;
            word-break: break-word;
            color: var(--text);
            font-size: 1.08em;
        }
        .desc {
            margin: 30px 0 20px 0;
            color: var(--text);
            font-size: 1.08em;
            white-space: pre-wrap;
            word-wrap: break-word;
            max-width: 100%;
            overflow-wrap: break-word;
        }
        .price {
            font-size: 1.25em;
            color: #e85a4f;
            font-weight: bold;
            margin-top: 8px;
        }
        .seller-info {
            margin-top: 18px;
            font-size: 1em;
            color: #888;
        }
        .buttons-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            margin-top: 40px;
        }
        .buy-btn {
            background: #e85a4f;
            color: #fff;
            font-weight: bold;
            font-size: 1.15em;
            border: none;
            border-radius: 14px;
            padding: 20px 66px;
            cursor: pointer;
            transition: background 0.16s;
        }
        .buy-btn:hover {
            background: #ba3e25;
        }
        .delete-btn {
            background: #888;
        }
        .delete-btn:hover {
            background: #b82727;
        }
        .edit-btn {
            background: #3777ee;
            color: #fff;
            border-radius: 12px;
            border: none;
            padding: 18px 46px;
            font-weight: bold;
            cursor: pointer;
        }
        .edit-btn:hover {
            background: #2250a2;
        }
        /* modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            padding-top: 60px;
            left: 0;
            top: 0;
            width: 100vw;
            height: 100vh;
            overflow: auto;
            background-color: rgba(0,0,0,0.7);
        }
        .modal-content {
            margin: auto;
            display: block;
            max-width: 80vw;
            max-height: 80vh;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.4);
        }
        .modal-close {
            position: fixed;
            top: 30px;
            right: 30px;
            font-size: 2.5rem;
            color: white;
            cursor: pointer;
            font-weight: bold;
            user-select: none;
            z-index: 1100;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="book-detail-container">
    <div class="detail-row">
        <img id="itemImage" class="book-img"
     		src="<%=request.getContextPath()%>/uploads/<%= item.getPhoto() != null ? item.getPhoto() : "default_book.png" %>" 
     		alt="상품 사진" />
        <div class="book-info">
        	<h2><%= item.getTitle() %></h2>
		    <div><span class="info-label">판매자</span> <%= item.getSellerName() != null ? item.getSellerName() : "-" %></div>
    		<div><span class="info-label">상태</span> <%= item.getStatus() != null ? item.getStatus() : "-" %></div>
    		<div><span class="info-label">가격</span> <%= item.getPrice() != 0 ? String.format("%,d", item.getPrice()) + " 원" : "-" %></div>
    		<div><span class="info-label">상세설명</span> <span class="desc"><%= item.getDescription() != null ? item.getDescription() : "-" %></span></div>
    	<% if ("book".equals(item.getItemType())) { %>
        	<div><span class="info-label">저자</span> <%= item.getAuthor() != null ? item.getAuthor() : "-" %></div>
        	<div><span class="info-label">출판사</span> <%= item.getPublisher() != null ? item.getPublisher() : "-" %></div>
        	<div><span class="info-label">교수명</span> <%= item.getProfessor() != null ? item.getProfessor() : "-" %></div>
        	<div><span class="info-label">수강년도</span> <%= item.getYear() != 0 ? item.getYear() : "-" %></div>
        	<div><span class="info-label">학과</span> <%= item.getDepartment() != null ? item.getDepartment() : "-" %></div>
    	<% } else if ("device".equals(item.getItemType())) { %> 
        	<div><span class="info-label">브랜드</span> <%= item.getBrand() != null ? item.getBrand() : "-" %></div>
        	<div><span class="info-label">모델명</span> <%= item.getModel() != null ? item.getModel() : "-" %></div>
    	<% } %>
		</div>
    </div>
    <div class="buttons-container">
		<form action="purchase_form.jsp" method="get">
    		<input type="hidden" name="itemId" value="<%= item.getItemId() %>">
    		<button type="submit" class="buy-btn">구매하기</button>
		</form>

        <form action="<%=request.getContextPath()%>/WishServlet" method="post">
            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
            <button type="submit" class="buy-btn" style="background:#FFD600; color:#222;">찜하기</button>
        </form>
        <%
            if (member != null && member.getStudentId().equals(item.getStudentId())) {
        %>
            <a href="<%=request.getContextPath()%>/EditItem.jsp?itemId=<%= item.getItemId() %>" class="edit-btn">수정</a>
            <form action="<%=request.getContextPath()%>/DeleteItemServlet" method="post" style="display:inline;">
                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                <button type="submit" class="buy-btn delete-btn">삭제</button>
            </form>
        <%
            }
        %>
    </div>
</div>

<div id="imageModal" class="modal">
    <span class="modal-close" id="modalClose">&times;</span>
    <img class="modal-content" id="modalImage">
</div>

<script src="<%=request.getContextPath()%>/js/DarkToggle.js"></script>
<script>
    const modal = document.getElementById('imageModal');
    const modalImg = document.getElementById('modalImage');
    const img = document.getElementById('itemImage');
    const modalClose = document.getElementById('modalClose');

    img.onclick = function() {
        modal.style.display = "block";
        modalImg.src = this.src;
    }
    modalClose.onclick = function() {
        modal.style.display = "none";
    }
    modal.onclick = function(e) {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    }
</script>
</body>
</html>
