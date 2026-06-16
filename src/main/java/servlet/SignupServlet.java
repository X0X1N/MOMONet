package servlet;
import dao.MemberDAO;
import dto.MemberDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    String studentId = request.getParameter("studentId");
	    String password = request.getParameter("password");
	    String email     = request.getParameter("email");
	    String sellerId = request.getParameter("sellerId");
	    
	    MemberDAO dao = new MemberDAO();
	    
	    if (!dao.isAllowedStudentId(studentId)) {
          
            request.getRequestDispatcher("singup.jsp").forward(request, response);
            return; 
        }


	    MemberDTO member = new MemberDTO(studentId, password, email, sellerId);
	    boolean result = dao.register(member);

	    if(result) {
	        request.setAttribute("successMessage", "회원가입이 완료되었습니다! 로그인 해주세요 😊");
	        request.getRequestDispatcher("login.jsp").forward(request, response);
	    } else {
	        request.setAttribute("message", "회원가입 실패! 이미 사용 중인 ID일 수 있습니다.");
	        request.getRequestDispatcher("singup.jsp").forward(request, response);
	    }

	}

}
