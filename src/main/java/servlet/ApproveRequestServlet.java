package servlet;

import dao.PurchaseRequestDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ApproveRequestServlet")
public class ApproveRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String requestIdStr = request.getParameter("requestId");
        String action = request.getParameter("action"); // "approve" or "reject"
        int requestId = (requestIdStr != null && !requestIdStr.isEmpty()) ? Integer.parseInt(requestIdStr) : 0;

        String newStatus = null;
        if ("approve".equals(action)) newStatus = "승인";
        else if ("reject".equals(action)) newStatus = "거절";

        if (requestId > 0 && newStatus != null) {
            PurchaseRequestDAO dao = new PurchaseRequestDAO();
            boolean ok = dao.updateRequestStatus(requestId, newStatus);
            if (ok) {
                response.sendRedirect("SellerApproval.jsp?msg=" + newStatus); // 목록으로 이동
            } else {
                response.sendRedirect("error.jsp?msg=처리실패");
            }
        } else {
            response.sendRedirect("error.jsp?msg=파라미터오류");
        }
    }
}
