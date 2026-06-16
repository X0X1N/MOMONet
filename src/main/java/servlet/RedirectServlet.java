package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import dao.TradeDAO;

@WebServlet("/RedirectServlet")
public class RedirectServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            int tradeId = Integer.parseInt(req.getParameter("tradeId"));
            TradeDAO dao = new TradeDAO();
            dao.updateTradeStatus(tradeId, "거절");
        
            res.sendRedirect("index.jsp");
        } catch (NumberFormatException e) {
  
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 거래 ID입니다.");
        }
    }
}
