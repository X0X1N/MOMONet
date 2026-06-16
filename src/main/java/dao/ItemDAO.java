package dao;

import java.sql.*;
import java.util.*;
import dto.ItemDTO;
import util.DBUtil;

public class ItemDAO {

    // (1) insertBook
    public boolean insertBook(ItemDTO book) {
        String sql = "INSERT INTO item(title, author, publisher, status, price, description, photo, sellerId, sellerName, professor, year, department, itemType, brand, model) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getPublisher());
            pstmt.setString(4, book.getStatus());
            pstmt.setInt(5, book.getPrice());
            pstmt.setString(6, book.getDescription());
            pstmt.setString(7, book.getPhoto());
            pstmt.setString(8, book.getSellerId());
            pstmt.setString(9, book.getSellerName());
            pstmt.setString(10, book.getProfessor());
            pstmt.setInt(11, book.getYear());
            pstmt.setString(12, book.getDepartment());
            pstmt.setString(13, book.getItemType());
            pstmt.setString(14, book.getBrand());
            pstmt.setString(15, book.getModel());
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // (2) insertItem
    public int insertItem(ItemDTO item) {
        int result = 0;
        String sql = "INSERT INTO item (title, author, publisher, status, price, description, photo, sellerId, sellerName, professor, year, department, itemType, brand, model) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, item.getTitle());
            pstmt.setString(2, item.getAuthor());
            pstmt.setString(3, item.getPublisher());
            pstmt.setString(4, item.getStatus());
            pstmt.setInt(5, item.getPrice());
            pstmt.setString(6, item.getDescription());
            pstmt.setString(7, item.getPhoto());
            pstmt.setString(8, item.getSellerId());
            pstmt.setString(9, item.getSellerName());
            pstmt.setString(10, item.getProfessor());
            pstmt.setInt(11, item.getYear());
            pstmt.setString(12, item.getDepartment());
            pstmt.setString(13, item.getItemType());
            pstmt.setString(14, item.getBrand());
            pstmt.setString(15, item.getModel());

            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // (3) updateBook
    public boolean updateBook(ItemDTO book) {
        String sql = "UPDATE item SET title=?, author=?, publisher=?, status=?, price=?, description=?, photo=?, sellerId=?, sellerName=?, professor=?, year=?, department=?, itemType=?, brand=?, model=? WHERE itemId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getAuthor());
            pstmt.setString(3, book.getPublisher());
            pstmt.setString(4, book.getStatus());
            pstmt.setInt(5, book.getPrice());
            pstmt.setString(6, book.getDescription());
            pstmt.setString(7, book.getPhoto());
            pstmt.setString(8, book.getSellerId());
            pstmt.setString(9, book.getSellerName());
            pstmt.setString(10, book.getProfessor());
            pstmt.setInt(11, book.getYear());
            pstmt.setString(12, book.getDepartment());
            pstmt.setString(13, book.getItemType());
            pstmt.setString(14, book.getBrand());
            pstmt.setString(15, book.getModel());
            pstmt.setInt(16, book.getItemId());
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // (4) getAllBooks
    public List<ItemDTO> getAllBooks() {
        List<ItemDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM item ORDER BY itemId DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                ItemDTO b = new ItemDTO();
                b.setItemId(rs.getInt("itemId"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setPublisher(rs.getString("publisher"));
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getInt("price"));
                b.setDescription(rs.getString("description"));
                b.setPhoto(rs.getString("photo"));
                b.setSellerId(rs.getString("sellerId"));
                b.setSellerName(rs.getString("sellerName"));
                b.setProfessor(rs.getString("professor"));
                b.setYear(rs.getInt("year"));
                b.setDepartment(rs.getString("department"));
                b.setItemType(rs.getString("itemType"));
                b.setBrand(rs.getString("brand"));
                b.setModel(rs.getString("model"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // (5) getBookById
    public ItemDTO getBookById(int itemId) {
        String sql = "SELECT * FROM item WHERE itemId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, itemId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ItemDTO b = new ItemDTO();
                    b.setItemId(rs.getInt("itemId"));
                    b.setTitle(rs.getString("title"));
                    b.setAuthor(rs.getString("author"));
                    b.setPublisher(rs.getString("publisher"));
                    b.setStatus(rs.getString("status"));
                    b.setPrice(rs.getInt("price"));
                    b.setDescription(rs.getString("description"));
                    b.setPhoto(rs.getString("photo"));
                    b.setSellerId(rs.getString("sellerId"));
                    b.setSellerName(rs.getString("sellerName"));
                    b.setProfessor(rs.getString("professor"));
                    b.setYear(rs.getInt("year"));
                    b.setDepartment(rs.getString("department"));
                    b.setItemType(rs.getString("itemType"));
                    b.setBrand(rs.getString("brand"));
                    b.setModel(rs.getString("model"));
                    return b;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // (6) getItemsByStudentId
    public List<ItemDTO> getItemsByStudentId(String studentId) {
        List<ItemDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM item WHERE studentId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ItemDTO item = new ItemDTO();
                item.setItemId(rs.getInt("itemId"));
                item.setTitle(rs.getString("title"));
                item.setAuthor(rs.getString("author"));
                item.setPublisher(rs.getString("publisher"));
                item.setStatus(rs.getString("status"));
                item.setPrice(rs.getInt("price"));
                item.setDescription(rs.getString("description"));
                item.setPhoto(rs.getString("photo"));
                item.setStudentId(rs.getString("studentId"));
                item.setSellerId(rs.getString("sellerId"));
                item.setSellerName(rs.getString("sellerName"));
                item.setProfessor(rs.getString("professor"));
                item.setYear(rs.getInt("year"));
                item.setDepartment(rs.getString("department"));
                item.setItemType(rs.getString("itemType"));
                item.setBrand(rs.getString("brand"));
                item.setModel(rs.getString("model"));
                list.add(item);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // (7) searchBooks
    public List<ItemDTO> searchBooks(String keyword) {
        List<ItemDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM item WHERE title LIKE ? OR author LIKE ? OR publisher LIKE ? ORDER BY itemId DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            String like = "%" + keyword + "%";
            pstmt.setString(1, like);
            pstmt.setString(2, like);
            pstmt.setString(3, like);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ItemDTO b = new ItemDTO();
                b.setItemId(rs.getInt("itemId"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setPublisher(rs.getString("publisher"));
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getInt("price"));
                b.setDescription(rs.getString("description"));
                b.setPhoto(rs.getString("photo"));
                b.setSellerId(rs.getString("sellerId"));
                b.setSellerName(rs.getString("sellerName"));
                b.setProfessor(rs.getString("professor"));
                b.setYear(rs.getInt("year"));
                b.setDepartment(rs.getString("department"));
                b.setItemType(rs.getString("itemType"));
                b.setBrand(rs.getString("brand"));
                b.setModel(rs.getString("model"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // (8) 나머지 삭제 등
    public boolean deleteBook(int itemId) {
        String sql = "DELETE FROM item WHERE itemId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, itemId);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteById(int itemId) {
        String sql = "DELETE FROM item WHERE itemId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, itemId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String getSellerIdByItemId(int itemId) {
        String sql = "SELECT sellerId FROM item WHERE itemId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, itemId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String sid = rs.getString("sellerId");
                System.out.println("DB에서 읽어온 sellerId: " + sid);
                return sid;
            } else {
                System.out.println("itemId로 item을 찾지 못함: " + itemId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
