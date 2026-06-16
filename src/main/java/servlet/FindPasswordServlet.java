package servlet;

import java.io.IOException;
import dao.MemberDAO;
import dto.MemberDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.MailUtil;

@WebServlet("/FindPasswordServlet")
public class FindPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String studentId = req.getParameter("studentId");
        String email = req.getParameter("email");
        MemberDAO dao = new MemberDAO();
        MemberDTO user = dao.findByStudentIdAndEmail(studentId, email);

        if (user != null) {
            String tempPwd = makeRandomPwd();
            dao.updatePassword(studentId, tempPwd);
         
            try {
				MailUtil.send(email, "MOMONet 임시 비밀번호",
				    "임시 비밀번호: " + tempPwd + "<br>로그인 후 비밀번호를 변경하세요.");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            req.setAttribute("msg", "임시 비밀번호가 이메일로 발송되었습니다.");
        } else {
            req.setAttribute("msg", "입력한 정보가 일치하지 않습니다.");
        }
        req.getRequestDispatcher("findPassword.jsp").forward(req, res);
    }

    private String makeRandomPwd() {
        return Long.toHexString(System.currentTimeMillis()).substring(0,8);
    }
}
