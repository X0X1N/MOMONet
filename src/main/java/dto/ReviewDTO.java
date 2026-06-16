package dto;

public class ReviewDTO {
    private int reviewId;         // 후기 고유번호 (PK)
    private int itemId;           // 거래/책/물품 고유번호 (optional, 연결용)
    private String writerId;      // 작성자 회원 아이디
    private String writerName;    // 작성자 이름/닉네임
    private String writerType;    // 판매자/구매자/학생 등
    private int rating;           // 별점(1~5)
    private String content;       // 후기 내용
    private String regDate;       // 작성일(yyyy-MM-dd HH:mm 등)

    public ReviewDTO() {}

    public ReviewDTO(int reviewId, int itemId, String writerId, String writerName, String writerType,
                     int rating, String content, String regDate) {
        this.reviewId = reviewId;
        this.itemId = itemId;
        this.writerId = writerId;
        this.writerName = writerName;
        this.writerType = writerType;
        this.rating = rating;
        this.content = content;
        this.regDate = regDate;
    }

    // Getter & Setter
    public int getReviewId() {
        return reviewId;
    }
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getItemId() {
        return itemId;
    }
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getWriterId() {
        return writerId;
    }
    public void setWriterId(String writerId) {
        this.writerId = writerId;
    }

    public String getWriterName() {
        return writerName;
    }
    public void setWriterName(String writerName) {
        this.writerName = writerName;
    }

    public String getWriterType() {
        return writerType;
    }
    public void setWriterType(String writerType) {
        this.writerType = writerType;
    }

    public int getRating() {
        return rating;
    }
    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public String getRegDate() {
        return regDate;
    }
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }
}
