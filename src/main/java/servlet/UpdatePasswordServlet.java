package servlet;
import java.io.IOException;

import dao.MemberDAO;
import dto.MemberDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String newPassword = request.getParameter("newPassword");
        String studentId = member.getStudentId();

        MemberDAO dao = new MemberDAO();
        boolean result = dao.updatePassword(studentId, newPassword);

        if (result) {
            request.setAttribute("successMessage", "비밀번호가 변경되었습니다.");
        } else {
            request.setAttribute("message", "비밀번호 변경에 실패했습니다.");
        }
        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
    }
}
