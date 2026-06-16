package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import dto.TradeDTO;

public class TradeDAO {
    // 거래 신청
    public boolean requestTrade(int itemId, String buyerId, String sellerId) {
        String sql = "INSERT INTO trade (itemId, buyerId, sellerId, status) VALUES (?, ?, ?, '대기중')";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, itemId);
            pstmt.setString(2, buyerId);
            pstmt.setString(3, sellerId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // 판매자(또는 본인)가 승인 대기중인 거래 리스트 확인
    public List<TradeDTO> getPendingTradesForUser(String userId) {
        String sql = "SELECT * FROM trade WHERE sellerId = ? AND status = '대기중'";
        List<TradeDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                TradeDTO t = new TradeDTO();
                t.setTradeId(rs.getInt("tradeId"));
                t.setItemId(rs.getInt("itemId"));
                t.setBuyerId(rs.getString("buyerId"));
                t.setSellerId(rs.getString("sellerId"));
                t.setStatus(rs.getString("status"));
                t.setRequestDate(rs.getTimestamp("requestDate"));
                list.add(t);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 거래 승인
    public boolean approveTrade(int tradeId) {
        String sql = "UPDATE trade SET status='완료' WHERE tradeId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, tradeId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // 거래 거절
    public boolean rejectTrade(int tradeId) {
        String sql = "UPDATE trade SET status='거절' WHERE tradeId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, tradeId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public void updateTradeStatus(int tradeId, String status) {
        String sql = "UPDATE trade SET status = ? WHERE tradeId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);         // 새로운 상태값 (예: "완료", "거절" 등)
            pstmt.setInt(2, tradeId);           // 거래 아이디
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}