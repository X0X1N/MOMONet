package dao;

import dto.PurchaseRequestDTO;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.*;

public class PurchaseRequestDAO {


    public List<PurchaseRequestDTO> getPendingRequestsBySeller(String sellerId) {
        List<PurchaseRequestDTO> list = new ArrayList<>();
        String sql =
                "SELECT pr.*, m.studentId AS buyerName, i.title, i.price, i.photo " +
                "FROM purchaserequest pr " +
                "JOIN item i ON pr.itemId = i.itemId " +
                "JOIN member m ON pr.buyerId = m.studentId " +
                "WHERE i.sellerId = ? AND pr.status = '대기' " +
                "ORDER BY pr.requestDate DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, sellerId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PurchaseRequestDTO dto = new PurchaseRequestDTO(0, 0, sql, sql, sql, sql, null, sql, sql, sql, sql, 0);
                dto.setRequestId(rs.getInt("requestId"));
                dto.setItemId(rs.getInt("itemId"));
                dto.setBuyerId(rs.getString("buyerId"));
                dto.setBuyerName(rs.getString("buyerName")); 
                dto.setSellerId(sellerId);
                dto.setLocation(rs.getString("location"));
                dto.setMemo(rs.getString("memo"));
                dto.setStatus(rs.getString("status"));
                dto.setRequestDate(rs.getTimestamp("requestDate"));
                dto.setPhotoPath(rs.getString("photo")); 
                dto.setTradeTime(rs.getString("tradeTime"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateRequestStatus(int requestId, String status) {
        String sql = "UPDATE purchaserequest SET status = ? WHERE requestId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, requestId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

  
    public boolean insertRequest(PurchaseRequestDTO dto) {
        String sql = "INSERT INTO purchaserequest(itemId, buyerId, sellerId, location, memo, tradeTime, price) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, dto.getItemId());
            pstmt.setString(2, dto.getBuyerId());
            pstmt.setString(3, dto.getSellerId());
            pstmt.setString(4, dto.getLocation());
            pstmt.setString(5, dto.getMemo());
            pstmt.setString(6,dto.getTradeTime());
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }


 
    public PurchaseRequestDTO getRequestById(int requestId) {
        String sql =
                "SELECT pr.*, m.studentId AS buyerName, i.title, i.price, i.photo " +
                "FROM purchaserequest pr " +
                "JOIN item i ON pr.itemId = i.itemId " +
                "JOIN member m ON pr.buyerId = m.studentId " +
                "WHERE pr.requestId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, requestId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                PurchaseRequestDTO dto = new PurchaseRequestDTO(requestId, requestId, sql, sql, sql, sql, null, sql, sql, sql, sql, requestId);
                dto.setRequestId(rs.getInt("requestId"));
                dto.setItemId(rs.getInt("itemId"));
                dto.setBuyerId(rs.getString("buyerId"));
                dto.setBuyerName(rs.getString("buyerName")); 
                dto.setSellerId(rs.getString("sellerId"));
                dto.setLocation(rs.getString("location"));
                dto.setMemo(rs.getString("memo"));
                dto.setStatus(rs.getString("status"));
                dto.setRequestDate(rs.getTimestamp("requestDate"));
                dto.setPhotoPath(rs.getString("photo"));
                dto.setTradeTime(rs.getString("tradeTime"));
                return dto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<PurchaseRequestDTO> getRequestsForSeller(String sellerId) {
        List<PurchaseRequestDTO> list = new ArrayList<>();
        String sql = "SELECT pr.*, m.studentId AS buyerName, i.title, i.price, i.photo " +
                "FROM purchaserequest pr " +
                "JOIN item i ON pr.itemId = i.itemId " +
                "JOIN member m ON pr.buyerId = m.studentId " +
                "WHERE pr.sellerId = ? " +
                "ORDER BY pr.requestDate DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, sellerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PurchaseRequestDTO dto = new PurchaseRequestDTO(0, 0, sql, sql, sql, sql, null, sql, sql, sql, sql, 0);
                dto.setRequestId(rs.getInt("requestId"));
                dto.setItemId(rs.getInt("itemId"));
                dto.setBuyerId(rs.getString("buyerId"));
                dto.setBuyerName(rs.getString("buyerName")); 
                dto.setSellerId(rs.getString("sellerId"));
                dto.setLocation(rs.getString("location"));
                dto.setRequestDate(rs.getTimestamp("requestDate"));
                dto.setPhotoPath(rs.getString("photo"));
                dto.setMemo(rs.getString("memo"));
                dto.setStatus(rs.getString("status"));
                dto.setTradeTime(rs.getString("tradeTime"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
