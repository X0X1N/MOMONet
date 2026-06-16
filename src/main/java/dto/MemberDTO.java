package dto;
public class MemberDTO {
    private String studentId; // 학번
    private String password;  // 비밀번호
    private String email;
    private String sellerId;

    // 생성자
    public MemberDTO() {}
    public MemberDTO(String studentId, String password, String email, String sellerId) {
        this.studentId = studentId;
        this.password = password;
        this.email = email;
        this.sellerId = sellerId;
    }

    // Getter/Setter
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email;}
    
    public String getSellerId() { return sellerId; }
    public void setSellerId(String sellerId) { this.sellerId = sellerId;}
}
