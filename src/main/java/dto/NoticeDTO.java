package dto;

public class NoticeDTO {
    private int noticeId;         // 공지 고유 번호 (PK)
    private String title;         // 공지 제목
    private String content;       // 공지 내용
    private String writerId;      // 작성자(관리자) 아이디
    private String writerName;    // 작성자 이름/닉네임
    private String regDate;       // 등록일 (yyyy-MM-dd HH:mm 등)

    public NoticeDTO() {}

    public NoticeDTO(int noticeId, String title, String content, String writerId, String writerName, String regDate) {
        this.noticeId = noticeId;
        this.title = title;
        this.content = content;
        this.writerId = writerId;
        this.writerName = writerName;
        this.regDate = regDate;
    }

    // Getter & Setter
    public int getNoticeId() {
        return noticeId;
    }
    public void setNoticeId(int noticeId) {
        this.noticeId = noticeId;
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

    public String getRegDate() {
        return regDate;
    }
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }
}
