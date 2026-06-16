package dto;

public class ItemDTO {
    private int itemId;       
    private String title;        
    private String author;        
    private String publisher;     
    private String status;       
    private int price;          
    private String description;  
    private String photo;         
    private String sellerId;     
    private String sellerName;    
    private String professor;    
    private int year;             
    private String department;    
    private String itemType;
    private String brand;
    private String model;
    private String studentId;


    public ItemDTO() {}

    public ItemDTO(int itemId, String title, String author, String publisher,
                   String status, int price, String description, String photo,
                   String sellerId, String sellerName, String professor, int year, String department, String itemType,
                   String brand, String model) {
        this.itemId = itemId;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.status = status;
        this.price = price;
        this.description = description;
        this.photo = photo;
        this.sellerId = sellerId;
        this.sellerName = sellerName;
        this.professor = professor;
        this.year = year;
        this.department = department;
        this.itemType = itemType;
        this.brand = brand;
        this.model = model;
    }

 
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPhoto() { return photo; }
    public void setPhoto(String photo) { this.photo = photo; }

    public String getSellerId() { return sellerId; }
    public void setSellerId(String sellerId) { this.sellerId = sellerId; }

    public String getSellerName() { return sellerName; }
    public void setSellerName(String sellerName) { this.sellerName = sellerName; }

    public String getProfessor() { return professor; }
    public void setProfessor(String professor) { this.professor = professor; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    
    public String getItemType() { return itemType; }
    public void setItemType(String itemType) { this.itemType = itemType; }
    
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

}
