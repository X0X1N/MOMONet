<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" %>
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
    <title>MOMONET 등록하기</title>
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
            --input-bg: #2a2a2a;
            --input-text: #fff;
            --input-border: #35394b;
            --input-placeholder: #aaa;
            --btn-bg: #FF8A3D;
            --btn-text: #fff;
            --btn-hover: #FF7000;
            --register-title: #fff;
            --form-label: #fff;
        }
        .light {
            --bg: #f4f4f4;
            --text: #1b263b;
            --card-bg: #fff;
            --card-shadow: 0 4px 18px #e7e9f2;
            --accent: #FF8A3D;
            --input-bg: #e9eef6;
            --input-text: #222;
            --input-border: #dbe3ea;
            --input-placeholder: #9db2cf;
            --btn-bg: #FF8A3D;
            --btn-text: #fff;
            --btn-hover: #FF7000;
            --register-title: #222;
            --form-label: #222;
        }
        html, body {
            background: var(--bg);
            color: var(--text);
            font-family: 'Poor Story', "Pretendard", system-ui, sans-serif;
            transition: background 0.25s, color 0.25s;
        }
        .listbook-container {
            max-width: 440px;
            margin: 70px auto 30px auto;
            background: var(--card-bg);
            color: var(--text);
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            padding: 38px 30px 32px 30px;
            transition: background 0.25s, color 0.25s;
        }
        .listbook-container h2 {
            text-align: center;
            margin-bottom: 26px;
            font-family: "Poor Story", system-ui, sans-serif;
            color: var(--register-title);
            font-size: 1.5em;
            font-weight: bold;
            letter-spacing: 1.3px;
            transition: color 0.25s;
        }
        .form-row {
            margin-bottom: 18px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: var(--form-label);
            font-size: 1.05em;
            letter-spacing: 0.5px;
            transition: color 0.25s;
        }
        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 11px 13px;
            background: var(--input-bg);
            color: var(--input-text);
            border: 1.5px solid var(--input-border);
            border-radius: 8px;
            font-size: 1em;
            transition: border 0.18s, background 0.18s, color 0.18s;
            box-sizing: border-box;
        }
        input[type="text"]::placeholder,
        input[type="number"]::placeholder,
        textarea::placeholder {
            color: var(--input-placeholder);
            opacity: 1;
        }
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            border: 1.5px solid var(--accent);
            outline: none;
        }
        textarea {
            min-height: 60px;
            resize: vertical;
        }
        .form-row input[type="file"] {
            padding: 4px 0;
            border: none;
            background: none;
            color: var(--input-text);
        }
        .btn-submit {
            width: 100%;
            background: var(--btn-bg);
            color: var(--btn-text);
            border: none;
            padding: 13px 0;
            font-size: 1.09em;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 10px;
            font-weight: bold;
            box-shadow: 0 2px 8px #00000013;
            transition: background 0.2s, color 0.2s;
        }
        .btn-submit:hover {
            background: var(--btn-hover);
        }
        .hidden {
            display: none;
        }
        #photo-previews img {
            background: var(--card-bg);
            border-radius: 8px;
            width: 90px;
            height: 90px;
            object-fit: cover;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            margin-right: 4px;
        }
        input[type="checkbox"] {
            accent-color: var(--accent);
        }
        @media (max-width: 540px) {
            .listbook-container {
                padding: 18px 6vw 18px 6vw;
                max-width: 98vw;
            }
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<%
    String nickname = (session.getAttribute("member") != null)
        ? ((dto.MemberDTO)session.getAttribute("member")).getStudentId()
        : "";
%>
<div class="listbook-container">
    <h2>등록하기</h2>
    <form action="AddItemServlet" method="post" enctype="multipart/form-data">
        <div class="form-row">
            <label for="itemType">물품 종류</label>
            <select id="itemType" name="itemType" required onchange="showFieldsByType()">
                <option value="">-- 선택 --</option>
                <option value="book">전공책</option>
                <option value="device">전자기기</option>
                <option value="etc">기타</option>
            </select>
        </div>
        <div class="form-row">
            <label for="sellerName">판매자 이름</label>
            <input type="text" id="sellerName" name="sellerName" value="<%= nickname %>" required readonly>
            <input type="checkbox" id="anonymousCheck" onclick="toggleAnonymous(this)">
            <label for="anonymousCheck" style="display:inline;font-weight:normal;">익명으로 등록</label>
        </div>
        <div id="common-fields">
            <div class="form-row">
                <label for="title">이름/제목</label>
                <input type="text" id="title" name="title" required placeholder="예: 운영체제, 무선마우스 등">
            </div>
            <div class="form-row">
                <label for="status">상태</label>
                <select id="status" name="status" required>
                    <option value="">-- 선택 --</option>
                    <option value="S">S (거의 새것)</option>
                    <option value="A+">A+ (사용감 적음)</option>
                    <option value="A">A (사용감 많음)</option>
                </select>
            </div>
            <div class="form-row">
                <label for="price">가격 (원)</label>
                <input type="number" id="price" name="price" min="0" required placeholder="예: 12000원">
            </div>
            <div class="form-row">
                <label for="description">상세 설명</label>
                <textarea id="description" name="description" placeholder="상태, 구성품, 참고사항 등을 적어주세요."></textarea>
            </div>
            <div class="form-row">
                <label for="photo">사진 첨부 (대표사진)</label>
                <input type="file" id="photo" name="photo[]" accept="image/*" multiple onchange="previewPhotos(event)">
                <div id="photo-previews" style="display:flex; gap:10px; flex-wrap:wrap; margin-top:10px;"></div>
            </div>
        </div>
        <div id="book-fields" class="hidden">
            <div class="form-row">
                <label for="author">저자</label>
                <input type="text" id="author" name="author" placeholder="예: 홍길동">
            </div>
            <div class="form-row">
                <label for="publisher">출판사</label>
                <input type="text" id="publisher" name="publisher" placeholder="예: 한빛아카데미">
            </div>
            <div class="form-row">
                <label for="professor">교수명</label>
                <input type="text" id="professor" name="professor" placeholder="예: 김교수">
            </div>
            <div class="form-row">
                <label for="year">수강년도</label>
                <input type="number" id="year" name="year" min="2000" max="2099" placeholder="예: 2024">
            </div>
            <div class="form-row">
                <label for="department">학과</label>
                <input type="text" id="department" name="department" placeholder="예: 컴퓨터공학과">
            </div>
        </div>
        <div id="device-fields" class="hidden">
            <div class="form-row">
                <label for="brand">브랜드</label>
                <input type="text" id="brand" name="brand" placeholder="예: Logitech, Arduino 등">
            </div>
            <div class="form-row">
                <label for="model">모델명</label>
                <input type="text" id="model" name="model" placeholder="예: MX Master 3, UNO R3 등">
            </div>
        </div>
        <button class="btn-submit" type="submit">등록하기</button>
    </form>
</div>
<script>
function previewPhotos(event) {
    var previewBox = document.getElementById('photo-previews');
    previewBox.innerHTML = "";
    var files = event.target.files;
    if (files && files.length > 0) {
        Array.from(files).forEach(function(file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var img = document.createElement("img");
                img.src = e.target.result;
                previewBox.appendChild(img);
            };
            reader.readAsDataURL(file);
        });
        previewBox.style.display = "flex";
    } else {
        previewBox.innerHTML = "";
        previewBox.style.display = "none";
    }
}
function showFieldsByType() {
    var type = document.getElementById("itemType").value;
    document.getElementById("book-fields").classList.add("hidden");
    document.getElementById("device-fields").classList.add("hidden");
    if(type === "book") {
        document.getElementById("book-fields").classList.remove("hidden");
    }
    if(type === "device") {
        document.getElementById("device-fields").classList.remove("hidden");
    }
}
function toggleAnonymous(chk) {
    var nameInput = document.getElementById('sellerName');
    if (chk.checked) {
        nameInput.value = '익명';
        nameInput.readOnly = true;
    } else {
        nameInput.value = '<%= nickname %>';
        nameInput.readOnly = true;
    }
}
</script>
<script src="js/DarkToggle.js"></script>
</body>
</html>
