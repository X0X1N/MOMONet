<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.NoticeDTO" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%
    List<NoticeDTO> noticeList = (List<NoticeDTO>) request.getAttribute("noticeList");
    if (noticeList == null) noticeList = new ArrayList<>();
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null) isAdmin = false;
%>
<html>
<head>
    <title>공지사항 | MOMONET</title>
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
	    --border: #35394b;
	    --main-label: #fff; 
	}
	:root.light, .light {
	    --bg: #f4f4f4;
	    --text: #1b263b;
	    --card-bg: #fff;
	    --card-shadow: 0 4px 18px #e7e9f2;
	    --section-bg: #f7f7fb;
	    --accent: #FF8A3D;
	    --border: #dbe3ea;
	    --main-label: #222;   
	}
	
	html, body {
	    background: var(--bg);
	    color: var(--text);
	    font-family: 'Poor Story', "Pretendard", system-ui, sans-serif;
	    transition: background 0.25s, color 0.25s;
	    margin: 0;
	    padding: 0;
	}
	
	.notice-title,
	.notice-item-title {
	    color: var(--main-label) !important;
	    font-weight: bold;
	}
	
	.notice-container {
	    max-width: 680px;
	    margin: 80px auto 40px auto;
	    background: var(--card-bg);
	    border-radius: 16px;
	    box-shadow: var(--card-shadow);
	    padding: 42px 32px;
	    border: 1.2px solid var(--border);
	}
	
	.notice-title {
	    font-size: 1.3em;
	    margin-bottom: 18px;
	    text-align: center;
	    letter-spacing: 1px;
	}
	
	.notice-list {
	    margin: 24px 0 18px 0;
	}
	.notice-item {
	    border-bottom: 1px solid var(--border);
	    padding: 17px 0 13px 0;
	}
	.notice-item:last-child {
	    border-bottom: none;
	}
	.notice-item-title {
	    font-size: 1.07em;
	    margin-bottom: 2px;
	}
	.notice-item-meta {
	    color: #ffad73;
	    font-size: 0.99em;
	    margin-top: 2px;
	    font-family: 'Pretendard', sans-serif;
	}
	.notice-empty {
	    color: #888;
	    text-align: center;
	    padding: 30px 0;
	    font-size: 1.1em;
	}
	.notice-btn-row {
	    margin-top: 18px;
	    text-align: right;
	}
	.btn-write {
	    background: var(--accent);
	    color: #fff;
	    border: none;
	    padding: 9px 25px;
	    border-radius: 7px;
	    font-size: 1em;
	    font-family: inherit;
	    font-weight: bold;
	    box-shadow: 0 2px 8px #ff8a3d30;
	    letter-spacing: 0.8px;
	    cursor: pointer;
	    transition: background 0.14s, box-shadow 0.13s;
	}
	.btn-write:hover {
	    background: #ff6900;
	    box-shadow: 0 6px 16px #ffd68b;
	}
	.notice-item-content {
	    margin: 7px 0 0 0;
	    color: var(--text);
	    font-size: 1.06em;
	    word-break: keep-all;
	}
	
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="notice-container">
    <div class="notice-title">공지사항</div>
    <div class="notice-list">
        <% if (noticeList.isEmpty()) { %>
            <div class="notice-empty">등록된 공지사항이 없습니다.</div>
        <% } else { %>
            <% for (NoticeDTO notice : noticeList) { %>
                <div class="notice-item">
                    <div class="notice-item-title">
                        <%= notice.getTitle() %>
                    </div>
                    <div class="notice-item-meta">
                        <%= notice.getRegDate() %> | by <%= notice.getWriterName() %>
                    </div>
                    <div class="notice-item-content">
                        <%= notice.getContent() %>
                    </div>
                </div>
            <% } %>
        <% } %>
    </div>
    <% if (isAdmin) { %>
        <div class="notice-btn-row">
            <form action="NoticeWrite.jsp" method="get" style="display:inline;">
                <button type="submit" class="btn-write">공지 등록</button>
            </form>
        </div>
    <% } %>
</div>
<script src="js/DarkToggle.js"></script>
</body>
</html>
