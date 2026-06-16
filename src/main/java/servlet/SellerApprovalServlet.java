package servlet;

import dao.PurchaseRequestDAO;
import dto.MemberDTO;
import dto.PurchaseRequestDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/SellerApproval")
public class SellerApprovalServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String sellerId = member.getStudentId();

        PurchaseRequestDAO dao = new PurchaseRequestDAO();
        List<PurchaseRequestDTO> pendingRequests = dao.getPendingRequestsBySeller(sellerId);

        request.setAttribute("pendingRequests", pendingRequests);
        request.getRequestDispatcher("SellerApproval.jsp").forward(request, response);
    }

    // POST(승인/거절처리)는 필요하다면 따로 작성
}
