package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import dao.WishDAO;
import dto.MemberDTO;

@WebServlet("/WishServlet")
public class WishServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String studentId = member.getStudentId();
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        WishDAO wishDAO = new WishDAO();
        boolean result = wishDAO.insertWish(studentId, itemId);

        // 바로 마이페이지로 이동 (찜 목록 보여주기)
        response.sendRedirect("mypage.jsp");
    }
}
