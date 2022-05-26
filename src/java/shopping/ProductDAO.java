/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import utils.DBUtils;

/**
 *
 * @author admin
 */
public class ProductDAO {
    public static final String GET_ALL = "select productID, productName, image, price, quantity, importDate, expiredDate from tblProduct where status = 1 and expiredDate > getDate()";
    public static final String SEARCH = "select productID, productName, image, price, quantity, importDate, expiredDate from tblProduct where productName like ? and status = 1 and expiredDate > getDate()";
    public static final String CHECK_QUANTITY = "select productName, quantity from tblProduct where productID = ?";
    public static final String CREATE_ORDER = "insert into tblOrder (orderID, orderDate, total, userID, status) values (?, getDate(), ?, ?, 1)";
    public static final String CREATE_ORDER_DETAIL = "insert into tblOrderDetail (detailID, price, quantity, orderID, productID, status) values (?, ?, ?, ?, ?, 1)";
    public static final String UPDATE_QUANTITY = "update tblProduct set quantity = quantity - ? where productID = ?";
    public static final String UPDATE = "update tblProduct set productName = ?, image = ?, price = ?, quantity = ?, importDate = ?, expiredDate = ? where productID = ?";
    public static final String DELETE = "update tblProduct set status = 0 where productID = ?";
    public static final String GET_CATEGORYID = "select categoryID from tblCategory";
    public static final String CHECK_DUPLICATE = "select productName from tblProduct where productID = ?";
    public static final String INSERT = "insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, expiredDate, status) values (?, ?, ?, ?, ?, ?, ?, ?, 1)";
    
    public List<Product> getAllProduct() throws SQLException{
        List<Product> listProduct = new ArrayList<>();
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(GET_ALL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    String image = rs.getString("image");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String importDate = rs.getString("importDate");
                    String expiredDate = rs.getString("expiredDate");
                    listProduct.add(new Product(productID, productName, image, price, quantity, importDate, expiredDate));
                }
            }
        }
        catch (Exception e) {
            
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return listProduct;
    }
    
    public List<Product> search(String search) throws SQLException{
        List<Product> listProduct = new ArrayList<>();
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(SEARCH);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    String image = rs.getString("image");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String importDate = rs.getString("importDate");
                    String expiredDate = rs.getString("expiredDate");
                    listProduct.add(new Product(productID, productName, image, price, quantity, importDate, expiredDate));
                }
            }
        }
        catch (Exception e) {
            
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return listProduct;
    }
    
    public boolean checkQuantity(String productID, int quantity) throws SQLException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        int quantityFromDB = 0;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(CHECK_QUANTITY);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                if (rs.next())
                    quantityFromDB = rs.getInt("quantity");
                if (quantityFromDB >= quantity) {
                    check = true;
                }
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return check;
    }
    
    public boolean checkout(String userID, double total, List<Product> listProduct) throws SQLException, ClassNotFoundException {
        boolean checkAll = false;
        boolean checkOrder;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            UUID uuid = UUID.randomUUID();
            String orderID = uuid.toString();
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(CREATE_ORDER);
                ptm.setString(1, orderID);
                ptm.setDouble(2, total);
                ptm.setString(3, userID);
                checkOrder = ptm.executeUpdate() > 0;
                if (checkOrder) {
                    for (Product product : listProduct) {
                        con = DBUtils.getConnection();
                        if (con != null) {
                            ptm = con.prepareStatement(CREATE_ORDER_DETAIL);
                            ptm.setString(1, orderID + "-" + userID);
                            ptm.setDouble(2, product.getPrice());
                            ptm.setInt(3, product.getQuantity());
                            ptm.setString(4, orderID);
                            ptm.setString(5, product.getProductID());
                            boolean checkOrderDetail = ptm.executeUpdate() > 0;
                            if (checkOrderDetail) {
                                con = DBUtils.getConnection();
                                if (con != null) {
                                    ptm = con.prepareStatement(UPDATE_QUANTITY);
                                    ptm.setInt(1, product.getQuantity());
                                    ptm.setString(2, product.getProductID());
                                    ptm.executeUpdate();
                                }
                            }
                        }
                    }
                    checkAll = true; 
                }
            }
            
        }
        catch (Exception e) {
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return checkAll;
    }
    
    public String createOrder(String userID, double total) throws SQLException, ClassNotFoundException {
        String orderID = "";
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            UUID uuid = UUID.randomUUID();
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(CREATE_ORDER);
                ptm.setString(1, uuid.toString());
                ptm.setDouble(2, total);
                ptm.setString(3, userID);
                if (ptm.executeUpdate() > 0) orderID = uuid.toString();
            }
            
        }
        catch (Exception e) {
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return orderID;
    }
    
    public boolean createOrderDetail(String orderID, Product product) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(CREATE_ORDER_DETAIL);
                ptm.setString(1, orderID + "-" + product.getProductID());
                ptm.setDouble(2, product.getPrice());
                ptm.setInt(3, product.getQuantity());
                ptm.setString(4, orderID);
                ptm.setString(5, product.getProductID());
                check = ptm.executeUpdate() > 0;
            }
        }
        catch (Exception e) {
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return check;
    }
    
    public boolean updateQuantity(Product product) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(UPDATE_QUANTITY);
                ptm.setInt(1, product.getQuantity());
                ptm.setString(2, product.getProductID());
                check = ptm.executeUpdate() > 0;
            }
        }
        catch (Exception e) {
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return check;
    }
    
    public boolean update(Product product) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(UPDATE);
                ptm.setString(1, product.getProductName());
                ptm.setString(2, product.getImage());
                ptm.setDouble(3, product.getPrice());
                ptm.setInt(4, product.getQuantity());
                ptm.setString(5, product.getImportDate());
                ptm.setString(6, product.getExpiredDate());
                ptm.setString(7, product.getProductID());
                check = ptm.executeUpdate() > 0;
            }
        }
        catch (Exception e) {
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return check;
    }
    
    public boolean delete(String productID) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(DELETE);
                ptm.setString(1, productID);
                check = ptm.executeUpdate() > 0;
            }
        }
        catch (Exception e) {
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return check;
    }
    
    public List<String> getCategoryID() throws SQLException, ClassNotFoundException {
        List<String> listCategory = new ArrayList<>();
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(GET_CATEGORYID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    listCategory.add(rs.getString("categoryID"));
                }
            }
        }
        catch (Exception e) {
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return listCategory;
    }
    
    public boolean checkDuplicate(String productID) throws SQLException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(CHECK_DUPLICATE);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                if (rs.next()) check = true;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return check;
    }
    
    public boolean insert(Product product, String categoryID) throws SQLException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(INSERT);
                ptm.setString(1, product.getProductID());
                ptm.setString(2, product.getProductName());
                ptm.setString(3, product.getImage());
                ptm.setDouble(4, product.getPrice());
                ptm.setInt(5, product.getQuantity());
                ptm.setString(6, categoryID);
                ptm.setString(7, product.getImportDate());
                ptm.setString(8, product.getExpiredDate());
                check = ptm.executeUpdate() > 0;                    
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return check;
    }
    
}
