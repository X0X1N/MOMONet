package servlet;

import java.io.IOException;

import dao.PostDAO;
import dto.MemberDTO;
import dto.PostDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PostWriteServlet")
public class PostWriteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

     
        MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
        String studentId = member.getStudentId();

       
        PostDTO post = new PostDTO(0, title, content, null, studentId);
        boolean result = new PostDAO().insertPost(post);

 
        if (result) {
            response.sendRedirect("mypage.jsp");
        } else {
            response.sendRedirect("postWrite.jsp?error=fail");
        }
    }
}
