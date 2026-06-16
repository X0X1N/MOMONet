package dto;

import java.io.Serializable;

public class PostDTO implements Serializable {
    private int id;           // 글 번호(고유값)
    private String title;     // 글 제목
    private String content;   // 글 내용
    private String createdAt; // 작성일 (예: yyyy-MM-dd)
    private String studentId; // 글 작성자 학번

    public PostDTO() {}

    public PostDTO(int id, String title, String content, String createdAt, String studentId) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.studentId = studentId;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public String getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getStudentId() {
        return studentId;
    }
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
}
