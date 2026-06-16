package servlet;

import dao.PurchaseRequestDAO;
import dto.MemberDTO;
import dto.PurchaseRequestDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/PurchaseRequestServlet")
public class PurchaseRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

      
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("member");

        if (member == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        PurchaseRequestDAO dao = new PurchaseRequestDAO();
        List<PurchaseRequestDTO> pendingRequests = dao.getRequestsForSeller(member.getStudentId());

      
        request.setAttribute("pendingRequests", pendingRequests);
        request.getRequestDispatcher("purchaseRequest.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        String sellerId = request.getParameter("sellerId");
        String location = request.getParameter("location");
        String memo = request.getParameter("memo");
        String tradeTime = request.getParameter("tradeTime");
        int price = Integer.parseInt(request.getParameter("price"));


        PurchaseRequestDTO dto = new PurchaseRequestDTO(price, price, tradeTime, tradeTime, tradeTime, tradeTime, null, tradeTime, tradeTime, tradeTime, tradeTime, price);
        dto.setItemId(itemId);
        dto.setBuyerId(member.getStudentId());
        dto.setSellerId(sellerId);
        dto.setLocation(location);
        dto.setMemo(memo);
        dto.setTradeTime(tradeTime);
        dto.setPrice(price);

        PurchaseRequestDAO dao = new PurchaseRequestDAO();
        boolean result = dao.insertRequest(dto);
        if (result) {
            response.sendRedirect("purchase_complete.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}