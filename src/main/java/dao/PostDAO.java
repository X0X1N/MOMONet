package dao;

import dto.PostDTO;
import util.DBUtil;
import java.sql.*;
import java.util.*;

public class PostDAO {


    public List<PostDTO> getPostsByStudentId(String studentId) {
        List<PostDTO> posts = new ArrayList<>();
        String sql = "SELECT * FROM post WHERE studentId = ? ORDER BY createdAt DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PostDTO post = new PostDTO(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("createdAt"),
                    rs.getString("studentId")
                );
                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }


    public PostDTO getPostById(int id) {
        String sql = "SELECT * FROM post WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new PostDTO(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("content"),
                    rs.getString("createdAt"),
                    rs.getString("studentId")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public boolean insertPost(PostDTO post) {
        String sql = "INSERT INTO post (title, content, createdAt, studentId) VALUES (?, ?, NOW(), ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getStudentId());
            int result = pstmt.executeUpdate();
            return result == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean updatePost(PostDTO post) {
        String sql = "UPDATE post SET title=?, content=? WHERE id=? AND studentId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setInt(3, post.getId());
            pstmt.setString(4, post.getStudentId());
            int result = pstmt.executeUpdate();
            return result == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

 
    public boolean deletePost(int id, String studentId) {
        String sql = "DELETE FROM post WHERE id=? AND studentId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.setString(2, studentId);
            int result = pstmt.executeUpdate();
            return result == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
