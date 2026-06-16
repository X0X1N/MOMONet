package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import dao.PurchaseDAO;
import dao.WishDAO;
import dao.PostDAO;
import dto.PurchaseDTO;
import dto.WishDTO;
import dto.PostDTO;
import dto.MemberDTO;

@WebServlet("/mypage")  // ★ 여기 수정: jsp와 동일하게 하지 마세요!
public class MypageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        MemberDTO user = (MemberDTO) session.getAttribute("member");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = user.getStudentId();

        PurchaseDAO purchaseDAO = new PurchaseDAO();
        List<PurchaseDTO> purchaseList = purchaseDAO.getPurchasesByBuyer(studentId);

        WishDAO wishDAO = new WishDAO();
        List<WishDTO> wishList = wishDAO.getWishesByStudentId(studentId);

        PostDAO postDAO = new PostDAO();
        List<PostDTO> myPostList = postDAO.getPostsByStudentId(studentId);

        request.setAttribute("purchaseList", purchaseList);
        request.setAttribute("wishList", wishList);
        request.setAttribute("myPostList", myPostList);

   
        RequestDispatcher dispatcher = request.getRequestDispatcher("mypage.jsp");
        dispatcher.forward(request, response);
    }
}
