package dto;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class PurchaseDTO implements Serializable {
    private int id;                // 구매 내역 PK (purchase 테이블의 id)
    private String buyerId;        // 구매자 아이디
    private int productId;         // 상품(아이템) id
    private String title;          // 상품명 (item 테이블과 조인해서 가져올 때)
    private int price;            // 상품 가격 (item 테이블에서 조인)
    private int ItemId;
    private Timestamp purchaseDate;


    public PurchaseDTO() {}

    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getBuyerId() { return buyerId; }
    public void setBuyerId(String buyerId) { this.buyerId = buyerId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public int getItemId() {return ItemId; }
    public void setItemId(int ItemId) { this.ItemId = ItemId; }
    
    public Timestamp getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(Timestamp purchaseDate) { this.purchaseDate = purchaseDate; }

    // 날짜를 문자열로 반환 (yyyy-MM-dd HH:mm)
    public String getPurchaseDateStr() {
        if (purchaseDate == null) return "";
        return new SimpleDateFormat("yyyy-MM-dd HH:mm").format(purchaseDate);
    }
}
