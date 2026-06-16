package servlet;

import dto.MemberDTO;

import java.io.IOException;
import dao.TradeDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/TradeRequestServlet")
public class TradeRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemIdStr = request.getParameter("itemId");
        String sellerId = request.getParameter("sellerId");
        MemberDTO buyer = (MemberDTO) request.getSession().getAttribute("member");

        if (itemIdStr == null || buyer == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int itemId = Integer.parseInt(itemIdStr);

        dao.TradeDAO dao = new dao.TradeDAO();
        dao.requestTrade(itemId, buyer.getStudentId(), sellerId);

        // 승인 대기 화면으로 이동
        response.sendRedirect("TradeConfirm.jsp?itemId=" + itemId);
    }
}
