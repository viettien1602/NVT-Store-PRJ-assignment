/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shopping;

/**
 *
 * @author admin
 */
public class Product {
    private String productID;
    private String productName;
    private String image;
    private double price;
    private int quantity;
    private String importDate;
    private String expiredDate;

    public Product() {
    }

    public Product(String productID, String productName, String image, double price, int quantity, String importDate, String expiredDate) {
        this.productID = productID;
        this.productName = productName;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.importDate = importDate;
        this.expiredDate = expiredDate;
    }

    public String getProductID() {
        return productID;
    }

    public String getProductName() {
        return productName;
    }

    public String getImage() {
        return image;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getImportDate() {
        return importDate;
    }

    public String getExpiredDate() {
        return expiredDate;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setImportDate(String importDate) {
        this.importDate = importDate;
    }

    public void setExpiredDate(String expiredDate) {
        this.expiredDate = expiredDate;
    }
                        
}
