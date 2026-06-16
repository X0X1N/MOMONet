package dao;

import java.sql.*;
import util.DBUtil;
import dto.MemberDTO;

public class MemberDAO {
 
    public boolean register(MemberDTO member) {
        String sql = "INSERT INTO member(studentId, password, email, sellerId) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, member.getStudentId());
            pstmt.setString(2, member.getPassword());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getSellerId());
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public MemberDTO login(String studentId, String password) {
        String sql = "SELECT * FROM member WHERE studentId=? AND password=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new MemberDTO(
                    rs.getString("studentId"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("sellerId")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public boolean existsStudentId(String studentId) {
        String sql = "SELECT COUNT(*) FROM member WHERE studentId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

   
    public MemberDTO findByStudentIdAndEmail(String studentId, String email) {
        String sql = "SELECT * FROM member WHERE studentId=? AND email=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            pstmt.setString(2, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new MemberDTO(
                    rs.getString("studentId"),
                    rs.getString("password"),
                    rs.getString("email"),
                    rs.getString("sellerId")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

   
    public boolean updatePassword(String studentId, String newPassword) {
        String sql = "UPDATE member SET password=? WHERE studentId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newPassword);
            pstmt.setString(2, studentId);
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isAllowedStudentId(String studentId) {
        String sql = "SELECT COUNT(*) FROM allowed_student WHERE studentId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateEmail(String studentId, String email) {
        String sql = "UPDATE member SET email=? WHERE studentId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setString(2, studentId);
            int updated = pstmt.executeUpdate();
            return updated > 0; 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
