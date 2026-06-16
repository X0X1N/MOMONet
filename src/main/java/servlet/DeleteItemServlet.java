package servlet;

import dao.ItemDAO;
import dto.ItemDTO;
import dto.MemberDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteItemServlet")
public class DeleteItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemIdStr = request.getParameter("itemId");
        MemberDTO member = (MemberDTO) request.getSession().getAttribute("member");
        if (itemIdStr == null || member == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int itemId = Integer.parseInt(itemIdStr);

        ItemDAO dao = new ItemDAO();
        ItemDTO item = dao.getBookById(itemId);
      
        if (item != null && member.getStudentId().equals(item.getStudentId())) {
            dao.deleteById(itemId);
            response.sendRedirect("main.jsp?msg=deleted");
        } else {
            response.sendRedirect("main.jsp?msg=forbidden");
        }
    }
}
