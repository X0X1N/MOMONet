<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.MemberDTO,dao.PurchaseDAO,dao.WishDAO,dao.PostDAO,dto.ItemDTO,dto.PostDTO" %>
<%@ page import="java.util.List" %>
<%
    MemberDTO member = (MemberDTO) session.getAttribute("member");
    if (member == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String studentId = member.getStudentId();
    PurchaseDAO purchaseDAO = new PurchaseDAO();
    WishDAO wishDAO = new WishDAO();
    PostDAO postDAO = new PostDAO();
    List<ItemDTO> purchaseList = purchaseDAO.getPurchasedItemsByBuyerId(studentId);
    List<ItemDTO> wishList = wishDAO.getWishedItemsByStudentId(studentId);
    List<PostDTO> postList = postDAO.getPostsByStudentId(studentId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>MOMONet mypage</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
         :root {
            --bg: #121212;
            --text: #fff;
            --card-bg: #1c1d23;
            --card-shadow: 0 6px 18px rgba(0,0,0,0.14);
            --accent: #FF8A3D;
            --main-color: #fff;
            --section-title: #fff;
            --info: #bdbdbd;
            --item-box-bg: #232336;
            --btn-bg: #FF8A3D;
            --btn-text: #fff;
            --btn-hover: #FF7000;
            --input-bg: #2a2a2a;
            --input-text: #fff;
        }
        .light {
            --bg: #f4f4f4;
            --text: #1b263b;
            --card-bg: #fff;
            --card-shadow: 0 4px 18px #e7e9f2;
            --accent: #FF8A3D;
            --main-color: #222;
            --section-title: #222;
            --info: #868e96;
            --item-box-bg: #f8f8ff;
            --btn-bg: #FF8A3D;
            --btn-text: #fff;
            --btn-hover: #FF7000;
            --input-bg: #e9eef6;
            --input-text: #222;
        }
        html, body {
            background: var(--bg);
            color: var(--text);
            font-family: 'Poor Story', "Pretendard", system-ui, sans-serif;
            transition: background 0.25s, color 0.25s;
        }
        .mypage-wrap {
            max-width: 430px;
            margin: 54px auto 0;
            background: var(--card-bg);
            color: var(--main-color);
            border-radius: 18px;
            box-shadow: var(--card-shadow);
            padding: 36px 30px 32px 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: background 0.25s, color 0.25s;
        }
        .mypage-wrap h2 {
            color: var(--section-title);
            font-family: 'Poor Story', 'Pretendard', 'Apple SD Gothic Neo', Arial, sans-serif;
            font-size: 1.65rem;
            font-weight: 600;
            margin-bottom: 16px;
            text-align: center;
            letter-spacing: 1px;
            transition: color 0.25s;
        }
        .mypage-wrap > div {
            width: 100%;
            text-align: left;
            color: var(--main-color);
            margin-bottom: 15px;
            transition: color 0.25s;
        }
        .mypage-wrap > div span {
            color: var(--main-color);
            font-size: 1.03rem;
            font-weight: bold;
            letter-spacing: 1px;
            transition: color 0.25s;
        }
        .section-title {
            margin-top: 38px;
            margin-bottom: 14px;
            color: var(--section-title);
            font-size: 1.08rem;
            font-weight: bold;
            letter-spacing: 0.2px;
            transition: color 0.25s;
        }
        .item-box {
            display: flex;
            align-items: center;
            background: var(--item-box-bg);
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(48,64,120,0.03);
            padding: 12px 14px;
            margin-bottom: 10px;
            gap: 12px;
            transition: background 0.25s;
        }
        .mypage-wrap .item-box img {
            width: 56px;
            height: 56px;
            border-radius: 8px;
            object-fit: cover;
            background: #eaeaea;
            border: 1px solid #ececec;
        }
        .item-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
            flex: 1;
        }
        .item-box strong {
            font-size: 1.02rem;
            color: var(--main-color);
            margin-bottom: 3px;
            transition: color 0.25s;
        }
        .item-box span {
            font-size: 0.97rem;
            color: var(--main-color);
            font-weight: bold;
            transition: color 0.25s;
        }
        .detail-btn {
            background: #ff8a3d;
            border: none;
            color: #fff;
            font-size: 0.93em;
            border-radius: 8px;
            padding: 7px 17px;
            font-weight: 600;
            margin-left: 12px;
            cursor: pointer;
            transition: background 0.14s;
            letter-spacing: 1px;
        }
        .detail-btn:hover {
            background: #ff6800;
        }
        .info-text, .mypage-wrap .info-text {
            color: var(--info);
            font-size: 1.03rem;
            transition: color 0.25s;
        }
        button,
        a button {
            background: #ff8a3d;
            border: none;
            color: #fff;
            font-size: 1rem;
            font-family: inherit;
            padding: 10px 20px;
            border-radius: 10px;
            margin: 12px 3px 0 0;
            box-shadow: 0 2px 10px rgba(255,138,61,0.09);
            cursor: pointer;
            transition: background 0.18s;
        }
        button:hover,
        a button:hover {
            background: #ff6800;
        }
        @media (max-width: 540px) {
            .mypage-wrap {
                padding: 18px 6vw 20px 6vw;
                max-width: 98vw;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="mypage-wrap">
    <h2><%= studentId %> 님의 마이페이지</h2>
    <div>
        <span>아이디: <%= studentId %></span><br>
        <span>이메일: <%= member.getEmail() %></span>
    </div>

    <div style="margin-top: 20px; width: 100%; text-align: center;">
        <a href="SellerApproval.jsp">
            <button type="button" style="width: 100%; max-width: 350px;">판매자 구매 요청 승인 보기</button>
        </a>
    </div>

    <div class="section-title">🛒 최근 구매 내역</div>
    <%
        if (purchaseList == null || purchaseList.isEmpty()) {
    %>
        <div class="info-text">구매 내역이 없습니다.</div>
    <%
        } else {
            for (ItemDTO item : purchaseList) {
    %>
        <div class="item-box">
            <img src="uploads/<%= (item.getPhoto() != null && !item.getPhoto().isEmpty()) ? item.getPhoto() : "default_book.png" %>" alt="상품사진">
            <div class="item-info">
                <strong><%= item.getTitle() %></strong>
                <span><%= item.getPrice() %>원</span>
            </div>
            <form action="Item_detail.jsp" method="get" style="margin:0;">
                <input type="hidden" name="bookId" value="<%= item.getItemId() %>">
                <button type="submit" class="detail-btn">상세보기</button>
            </form>
        </div>
    <%
            }
        }
    %>

    <div class="section-title">⭐ 찜해놓은 목록</div>
    <%
        if (wishList == null || wishList.isEmpty()) {
    %>
        <div class="info-text">찜한 항목이 없습니다.</div>
    <%
        } else {
            for (ItemDTO item : wishList) {
    %>
        <div class="item-box">
            <img src="uploads/<%= (item.getPhoto() != null && !item.getPhoto().isEmpty()) ? item.getPhoto() : "default_book.png" %>" alt="상품사진">
            <div class="item-info">
                <strong><%= item.getTitle() %></strong>
                <span><%= item.getPrice() %>원</span>
            </div>
            <form action="Item_detail.jsp" method="get" style="margin:0;">
                <input type="hidden" name="bookId" value="<%= item.getItemId() %>">
                <button type="submit" class="detail-btn">상세보기</button>
            </form>
        </div>
    <%
            }
        }
    %>

    <br>
    <form action="LogoutServlet" method="post" style="display:inline;">
        <button type="submit">로그아웃</button>
    </form>
    <a href="editProfile.jsp"><button>비밀번호 재설정</button></a>
</div>

<script>
(function(){
    function applyTheme() {
        var isLight = localStorage.getItem("theme") === "light";
        document.documentElement.classList.toggle("light", isLight);
    }
    applyTheme();
    window.addEventListener("storage", applyTheme);
})();
</script>
<script src="js/DarkToggle.js"></script>
</body>
</html>
