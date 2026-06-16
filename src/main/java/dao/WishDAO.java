package dao;

import dto.ItemDTO;
import dto.WishDTO;
import util.DBUtil;
import java.sql.*;
import java.util.*;

public class WishDAO {

    // 찜한 item 정보 전체 조회 (상품 리스트용)
    public List<ItemDTO> getWishedItemsByStudentId(String studentId) {
        List<ItemDTO> list = new ArrayList<>();
        // productId로 JOIN!
        String sql = "SELECT i.* FROM wish w JOIN item i ON w.productId = i.itemId WHERE w.studentId = ? ORDER BY w.wishDate DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ItemDTO item = new ItemDTO();
                item.setItemId(rs.getInt("itemId"));
                item.setTitle(rs.getString("title"));
                item.setPrice(rs.getInt("price"));
                item.setPhoto(rs.getString("photo"));
                item.setAuthor(rs.getString("author"));
                item.setPublisher(rs.getString("publisher"));
                // 필요한 필드 추가 가능
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 찜 등록 (productId로)
    public boolean insertWish(String studentId, int itemId) {
        String sql = "INSERT INTO wish (studentId, productId, wishDate) VALUES (?, ?, NOW())";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            pstmt.setInt(2, itemId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<WishDTO> getWishesByStudentId(String studentId) {
        List<WishDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM wish WHERE studentId = ? ORDER BY wishDate DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                WishDTO wish = new WishDTO();
                wish.setId(rs.getInt("id"));
                wish.setStudentId(rs.getString("studentId"));
                wish.setProductId(rs.getInt("productId"));
                wish.setWishDate(rs.getTimestamp("wishDate"));
                // 필요하면 추가 필드
                list.add(wish);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
