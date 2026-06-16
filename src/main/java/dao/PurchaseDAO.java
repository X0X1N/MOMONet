package dao;

import java.sql.*;
import java.util.*;
import dto.ItemDTO;
import dto.PurchaseDTO;
import util.DBUtil;

public class PurchaseDAO {

    /**
     * 해당 buyerId가 구매한 상품 전체 정보를 반환합니다.
     * (구매 내역에 있는 itemId로 item 테이블의 상세 정보를 join해서 모두 불러옵니다.)
     *
     * @param buyerId - 구매자(학생) id
     * @return 구매한 상품(ItemDTO) 리스트
     */
    public List<ItemDTO> getPurchasedItemsByBuyerId(String buyerId) {
        List<ItemDTO> list = new ArrayList<>();
        String sql = "SELECT i.* " +
                     "FROM purchase p " +
                     "JOIN item i ON p.itemId = i.itemId " +
                     "WHERE p.buyerId = ? " +
                     "ORDER BY p.purchaseDate DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, buyerId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ItemDTO item = new ItemDTO();
                item.setItemId(rs.getInt("itemId"));
                item.setTitle(rs.getString("title"));
                item.setPrice(rs.getInt("price"));
                item.setPhoto(rs.getString("photo"));
                item.setAuthor(rs.getString("author"));
                item.setPublisher(rs.getString("publisher"));
                // 필요한 다른 필드 있으면 여기에 추가!
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 구매 내역을 DB에 insert하는 메소드 (구매하기 시 사용)
     */
    public boolean insertPurchase(String buyerId, int itemId) {
        String sql = "INSERT INTO purchase (buyerId, itemId, purchaseDate) VALUES (?, ?, NOW())";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, buyerId);
            pstmt.setInt(2, itemId);
            int result = pstmt.executeUpdate();

            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<PurchaseDTO> getPurchasesByBuyer(String studentId) {
        List<PurchaseDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM purchase WHERE buyerId = ? ORDER BY purchaseDate DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PurchaseDTO dto = new PurchaseDTO();
                dto.setId(rs.getInt("id"));  // purchase 테이블 PK
                dto.setBuyerId(rs.getString("buyerId"));
                dto.setItemId(rs.getInt("itemId"));
                dto.setPurchaseDate(rs.getTimestamp("purchaseDate"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
