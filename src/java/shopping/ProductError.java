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
public class ProductError {
    private String productIDErr;
    private String productNameError;
    private String dateError;
    
    public ProductError() {
        this.productIDErr = "";
        this.productNameError = "";
        this.dateError = "";
    }

    public ProductError(String productIDErr, String productNameError, String dateError) {
        this.productIDErr = productIDErr;
        this.productNameError = productNameError;
        this.dateError = dateError;

    }

    public String getProductIDErr() {
        return productIDErr;
    }

    public String getProductNameError() {
        return productNameError;
    }


    public String getDateError() {
        return dateError;
    }


    public void setProductIDErr(String productIDErr) {
        this.productIDErr = productIDErr;
    }

    public void setProductNameError(String productNameError) {
        this.productNameError = productNameError;
    }


    public void setDateError(String dateError) {
        this.dateError = dateError;
    }
    
    
    
    
}
