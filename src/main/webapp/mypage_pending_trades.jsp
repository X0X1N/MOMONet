<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dao.TradeDAO, dto.TradeDTO, java.util.*" %>
<%
    dto.MemberDTO member = (dto.MemberDTO) session.getAttribute("member");
    if (member == null) {
%>
    <script>
        alert("로그인 후 이용 가능합니다.");
        location.href = "login.jsp";
    </script>
<%
        return;
    }
    dao.TradeDAO dao = new dao.TradeDAO();
    List<dto.TradeDTO> pendingTrades = dao.getPendingTradesForUser(member.getStudentId());
%>
<html>
<head>
<title>승인 대기중 거래</title>
 <link rel="stylesheet" href="css/topbar.css">
    <link rel="icon" href="/MOMONet/images/momoLogo.png" type="image/png">
    <link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
<style>
    table { width: 90%; margin: 35px auto; border-collapse: collapse; background: #fff;}
    th, td { border: 1px solid #eee; padding: 12px 8px; text-align: center; }
    th { background: #FF8A3D; color: #fff;}
    button { padding: 7px 17px; border-radius: 5px; border: none; cursor: pointer;}
    button[type="submit"] { background: #FF8A3D; color: #fff;}
    button[type="submit"]:hover { background: #e37116; }
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<h2 style="text-align:center; color:#FF8A3D; margin-top:38px;">승인 대기중 거래 요청</h2>
<table>
<tr>
    <th>거래번호</th>
    <th>상품ID</th>
    <th>구매자</th>
    <th>상태</th>
    <th>처리</th>
</tr>
<%
if (pendingTrades.size() == 0) {
%>
<tr>
    <td colspan="5">대기 중인 거래 요청이 없습니다.</td>
</tr>
<%
} else {
    for (dto.TradeDTO t : pendingTrades) {
%>
<tr>
  <td><%= t.getTradeId() %></td>
  <td><%= t.getItemId() %></td>
  <td><%= t.getBuyerId() %></td>
  <td><%= t.getStatus() %></td>
  <td>
    <form action="ApproveTradeServlet" method="post" style="display:inline;">
      <input type="hidden" name="tradeId" value="<%= t.getTradeId() %>">
      <button type="submit">승인</button>
    </form>
    <form action="RejectTradeServlet" method="post" style="display:inline;">
      <input type="hidden" name="tradeId" value="<%= t.getTradeId() %>">
      <button type="submit" style="background:#888;">거절</button>
    </form>
  </td>
</tr>
<%
    }
}
%>
</table>
<script src="js/DarkToggle.js"></script>
</body>
</html>
