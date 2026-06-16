package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import dao.TradeDAO;

@WebServlet("/ApproveTradeServlet")
public class ApproveTradeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tradeIdStr = request.getParameter("tradeId");
        if (tradeIdStr == null || tradeIdStr.isEmpty()) {
            response.sendRedirect("PendingTrades.jsp");
            return;
        }

        int tradeId = Integer.parseInt(tradeIdStr);
        TradeDAO dao = new TradeDAO();
        boolean result = dao.approveTrade(tradeId);


        response.sendRedirect("PendingTrades.jsp");
    }
}
