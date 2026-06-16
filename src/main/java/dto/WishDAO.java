package dto;

import dto.WishDTO;
import util.DBUtil;
import java.sql.*;
import java.util.*;

public class WishDAO {
    public List<WishDTO> getWishesByStudentId(String studentId) {
        List<WishDTO> list = new ArrayList<>();
        String sql = "SELECT w.id, w.studentId, w.productId, w.wishDate, i.title " +
                     "FROM wish w JOIN item i ON w.productId = i.itemId " +
                     "WHERE w.studentId = ? ORDER BY w.wishDate DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                WishDTO wish = new WishDTO();
                wish.setId(rs.getInt("id"));
                wish.setStudentId(rs.getString("studentId"));
                wish.setProductId(rs.getInt("productId"));
                wish.setTitle(rs.getString("title"));
                wish.setWishDate(rs.getTimestamp("wishDate"));
                list.add(wish);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
