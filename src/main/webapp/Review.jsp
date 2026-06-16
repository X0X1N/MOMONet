<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*, dto.ReviewDTO" %>
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
%>

<html>
<head>
    <title>MOMONet.com | 리뷰</title>
    <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #121212;
            --card-bg: #1c1d23;
            --input: #262b34;
            --border: #35394b;
            --text: #fff;
             --main-label: #fff; 
            --accent: #FF8A3D;
            --shadow: 0 4px 18px #181920;
            --star-on: #ffd600;
            --star-off: #55595a;
            --meta: #9db2cf;
            --form-bg: #181920;
            --btn-bg: #FF8A3D;
            --btn-hover: #ff6800;
           
        }
        :root.light {
            --bg: #f4f7fa;
            --card-bg: #fff;
            --input: #e9eef6;
            --border: #dbe3ea;
            --text: #1a2849;
            --main-label: #222;
            --accent: #ff9417;
            --shadow: 0 4px 18px #e7e9f2;
            --star-on: #ffd600;
            --star-off: #eee1bc;
            --meta: #7e8a97;
            --form-bg: #f7fafd;
            --btn-bg: #ff9417;
            --btn-hover: #ff9800;
        }
        html, body {
            background: var(--bg);
            color: var(--text);
            font-family: "Poor Story", "Pretendard", system-ui, sans-serif;
            margin: 0;
            transition: background 0.25s, color 0.25s;
        }
        .main-content {
            max-width: 820px;
            min-width: 340px;
            margin: 60px auto 30px auto;
            background: var(--card-bg);
            border-radius: 18px;
            box-shadow: var(--shadow);
            padding: 56px 60px 38px 60px;
            border: 1.2px solid var(--border);
            display: flex;
            flex-direction: column;
            gap: 46px;
            align-items: center;
            transition: background 0.25s, color 0.25s;
        }
        @media (max-width: 980px) {
            .main-content { max-width: 98vw; padding: 34px 7vw 26px 7vw;}
        }
        .review-top-section {
            width: 100%;
            max-width: 680px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .review-title {
            font-size: 1.33em;
            color: var(--main-label) !important;
            font-weight: bold;
            margin-bottom: 20px;
            letter-spacing: 0.01em;
        }
        .review-list {
            width: 100%;
            margin-bottom: 10px;
        }
        .review-item {
            border-bottom: 1px solid var(--border);
            padding: 14px 0 10px 0;
        }
        .review-stars {
            color: var(--star-on);
            font-size: 1.19em;
            margin-right: 5px;
            letter-spacing: 1.2px;
        }
        .review-who {
            color: var(--meta);
            font-size: 0.97em;
            margin-left: 8px;
        }
        .review-content {
            margin-top: 6px;
            color: var(--text);
            font-size: 1.08em;
            line-height: 1.55;
        }
        .review-date {
            color: #bfc8d4;
            font-size: 0.83em;
            margin-top: 4px;
        }

        .review-form-section {
            width: 100%;
            max-width: 680px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .review-form {
            width: 100%;
            background: var(--form-bg);
            border-radius: 12px;
            padding: 28px 22px 20px 22px;
            box-shadow: 0 2px 10px #0003;
            margin-top: 0;
            border: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            gap: 19px;
            transition: background 0.25s, color 0.25s;
        }
        .star-rating-group {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 6px;
        }
        .star-rating {
            direction: rtl;
            display: flex;
        }
        .star-radio { display: none; }
        .star {
            font-size: 1.9em;
            color: var(--star-off);
            cursor: pointer;
            transition: color 0.19s;
            padding: 0 2px;
            user-select: none;
        }
        .star:hover,
        .star:hover ~ .star {
            color: var(--star-on);
        }
        .star-radio:checked ~ label.star,
        .star-radio:checked ~ label.star ~ label.star {
            color: var(--star-on);
        }
        .form-group { width: 100%; }
        .form-label {
            font-size: 1.11em;
            color: var(--accent);
            margin-bottom: 4px;
            display: block;
            font-weight: bold;
        }
        .review-form textarea {
            width: 100%;
            min-height: 62px;
            border-radius: 8px;
            padding: 12px 15px;
            border: 1.5px solid var(--border);
            background: var(--input);
            color: var(--text);
            font-family: "Poor Story", sans-serif;
            font-size: 1.09em;
            resize: vertical;
            outline: none;
            margin-bottom: 3px;
            transition: border 0.16s, background 0.2s, color 0.2s;
        }
        .review-form textarea:focus {
            border-color: var(--accent);
            background: #23272f;
        }
        .review-submit-btn {
            margin-top: 9px;
            background: var(--btn-bg);
            color: #fff;
            border: none;
            padding: 13px 0;
            border-radius: 8px;
            width: 100%;
            font-size: 1.13em;
            cursor: pointer;
            font-family: "Poor Story", sans-serif;
            font-weight: bold;
            transition: background 0.18s;
            letter-spacing: 0.03em;
        }
        .review-submit-btn:hover {
            background: var(--btn-hover);
      
        }
   
        :root.light .review-date { color: #bbc7d8; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="main-content">
     
        <div class="review-top-section">
            <div class="review-title">리뷰 및 별점</div>
            <div class="review-list">
                <%
                    List<ReviewDTO> reviews = (List<ReviewDTO>) request.getAttribute("reviews");
                    if (reviews == null) reviews = new ArrayList<>();
                    if (reviews.isEmpty()) {
                %>
                    <div style="text-align:center; color:#bbc7d8; margin:27px 0;">아직 등록된 리뷰가 없습니다.</div>
                <%
                    } else {
                        for (ReviewDTO review : reviews) {
                %>
                    <div class="review-item">
                        <div>
                            <span class="review-stars">
                                <% for (int i = 0; i < review.getRating(); i++) { %>★<% } %>
                                <% for (int i = review.getRating(); i < 5; i++) { %>☆<% } %>
                            </span>
                            <span class="review-who"><%= review.getWriterType() %> <%= review.getWriterName() %></span>
                        </div>
                        <div class="review-content"><%= review.getContent() %></div>
                        <div class="review-date"><%= review.getRegDate() %></div>
                    </div>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <div class="review-form-section">
            <form class="review-form" action="AddReviewServlet" method="post">
                <div class="star-rating-group">
                    <label class="form-label">별점</label>
                    <div class="star-rating">
                        <% for (int i = 5; i >= 1; i--) { %>
                            <input class="star-radio" type="radio" id="star<%=i%>" name="rating" value="<%=i%>" <%= i==5 ? "checked" : "" %> />
                            <label class="star" for="star<%=i%>">★</label>
                        <% } %>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label" for="content">리뷰 내용</label>
                    <textarea id="content" name="content" maxlength="300" required placeholder="정직한 후기를 남겨주세요 :)"></textarea>
                </div>
                <input type="hidden" name="writerType" value="학생">
                <button type="submit" class="review-submit-btn">리뷰 등록</button>
            </form>
        </div>
    </div>
    <script src="js/DarkToggle.js"></script>
</body>
</html>
