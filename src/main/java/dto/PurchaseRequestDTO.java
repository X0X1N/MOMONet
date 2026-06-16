package dto;

import java.util.Date;

public class PurchaseRequestDTO {
    private int requestId;
    private int itemId;
    private String buyerId;
    private String buyerName;      
    private String sellerId;
    private String location;
    private Date requestDate;      
    private String photoPath;
    private String memo;
    private String status;
    private String tradeTime;
    private int price;

    public PurchaseRequestDTO(int requestId, int itemId, String buyerId, String buyerName, String sellerId,
                              String location, Date requestDate, String photoPath, String memo, String status,
                              String tradeTime, int price) {
        this.requestId = requestId;
        this.itemId = itemId;
        this.buyerId = buyerId;
        this.buyerName = buyerName;
        this.sellerId = sellerId;
        this.location = location;
        this.requestDate = requestDate;
        this.photoPath = photoPath;
        this.memo = memo;
        this.status = status;
        this.tradeTime = tradeTime;
        this.price = price;
    }



    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(String buyerId) {
        this.buyerId = buyerId;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getSellerId() {
        return sellerId;
    }

    public void setSellerId(String sellerId) {
        this.sellerId = sellerId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }
    
    public String getMemo() {
    	return memo;
    }
    
    public void setMemo(String memo) {
    	this.memo = memo;
    }
    
    public String getStatus() {
    	return status;
    }
    
    public void setStatus(String status) {
    	this.status = status;
    }
    
    public String getTradeTime() {
        return tradeTime;
    }

    public void setTradeTime(String tradeTime) {
        this.tradeTime = tradeTime;
    }
    
    public int getPrice() {
    	return price;
    }
    
    public void setPrice(int price) {
    	this.price = price;
    }
}
