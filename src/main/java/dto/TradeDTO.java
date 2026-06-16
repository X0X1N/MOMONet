package dto;

import java.util.Date;

public class TradeDTO {
    private int tradeId;
    private int itemId;
    private String buyerId;
    private String sellerId;
    private String status;       // 예: "대기중", "완료", "거절"
    private Date requestDate;

    // 기본 생성자
    public TradeDTO() {}

    // 전체 필드 생성자
    public TradeDTO(int tradeId, int itemId, String buyerId, String sellerId, String status, Date requestDate) {
        this.tradeId = tradeId;
        this.itemId = itemId;
        this.buyerId = buyerId;
        this.sellerId = sellerId;
        this.status = status;
        this.requestDate = requestDate;
    }

    // tradeId
    public int getTradeId() { return tradeId; }
    public void setTradeId(int tradeId) { this.tradeId = tradeId; }

    // itemId
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    // buyerId
    public String getBuyerId() { return buyerId; }
    public void setBuyerId(String buyerId) { this.buyerId = buyerId; }

    // sellerId
    public String getSellerId() { return sellerId; }
    public void setSellerId(String sellerId) { this.sellerId = sellerId; }

    // status
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // requestDate
    public Date getRequestDate() { return requestDate; }
    public void setRequestDate(Date requestDate) { this.requestDate = requestDate; }

    // toString()
    @Override
    public String toString() {
        return "TradeDTO{" +
                "tradeId=" + tradeId +
                ", itemId=" + itemId +
                ", buyerId='" + buyerId + '\'' +
                ", sellerId='" + sellerId + '\'' +
                ", status='" + status + '\'' +
                ", requestDate=" + requestDate +
                '}';
    }
}
