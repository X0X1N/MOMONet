package servlet;
import dao.MemberDAO;

import dto.MemberDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        MemberDAO dao = new MemberDAO();
        MemberDTO member = dao.login(studentId, password);

        if (member != null) {
            request.getSession().setAttribute("member", member);
            response.sendRedirect("main.jsp");
        } else {
            request.setAttribute("message", "ID 또는 비밀번호가 올바르지 않습니다.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
