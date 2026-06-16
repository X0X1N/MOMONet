package servlet;

import dao.ItemDAO;
import dao.PurchaseRequestDAO;
import dto.MemberDTO;
import dto.PurchaseRequestDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/PurchaseServlet")
public class PurchaseServlet extends HttpServlet {

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

        try {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            String location = request.getParameter("location");
            String memo = request.getParameter("memo");
            String tradeTime = null;

            // *** 여기서 sellerId를 item 테이블에서 조회 ***
            ItemDAO itemDAO = new ItemDAO();
            String sellerId = itemDAO.getSellerIdByItemId(itemId); // 이 메소드 추가 필요!

            PurchaseRequestDTO dto = new PurchaseRequestDTO(itemId, itemId, sellerId, sellerId, sellerId, sellerId, null, sellerId, sellerId, sellerId, sellerId, itemId);
            dto.setItemId(itemId);
            dto.setBuyerId(member.getStudentId());
            dto.setSellerId(sellerId); // null 방지!
            dto.setLocation(location);
            dto.setMemo(memo);
            dto.setTradeTime(tradeTime);

            PurchaseRequestDAO dao = new PurchaseRequestDAO();
            boolean success = dao.insertRequest(dto);

            if (success) {
                response.sendRedirect("purchase_success.jsp");
            } else {
                response.sendRedirect("purchase_fail.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("purchase_fail.jsp");
        }
    }
}