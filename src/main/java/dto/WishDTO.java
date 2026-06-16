package dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class WishDTO implements Serializable {
    private int id;
    private String studentId;
    private int productId;
    private String title;
    private Timestamp wishDate;

    public WishDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Timestamp getWishDate() { return wishDate; }
    public void setWishDate(Timestamp wishDate) { this.wishDate = wishDate; }

    public String getWishDateStr() {
        if (wishDate == null) return "";
        return new SimpleDateFormat("yyyy-MM-dd HH:mm").format(wishDate);
    }
}
