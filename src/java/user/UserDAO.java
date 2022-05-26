/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBUtils;

/**
 *
 * @author admin
 */
public class UserDAO {
    
    private static final String LOGIN = "select fullName, roleID, address, birthday, phone, email from tblUsers where userID = ? and password = ? and status = 1";
    private static final String CHECK_DUPLICATE = "select fullName from tblUsers where userID = ? and status = 1";
    private static final String CREATE = "insert into tblUsers(userID, fullName, password, roleID, address, birthday, phone, email, status) values (?, ?, ?, ?, ?, ?, ?, ?, 1)";
    
    public UserDTO checkLogin(String userID, String password) throws SQLException {
        UserDTO user = null;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(LOGIN);
                ptm.setString(1, userID);
                ptm.setString(2, password);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    String birthday = rs.getString("birthday");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    Boolean status = true;
                    user = new UserDTO(userID, fullName, "", roleID, address, birthday, phone, email, status);
                }
            }
        } catch (Exception e) {
            
        }
        finally {
            if (rs != null) rs.close();
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return user;
    }
    
    public boolean checkDuplicate(String userID) throws SQLException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(CHECK_DUPLICATE);
                ptm.setString(1, userID);
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
    
    public boolean create(UserDTO user) throws SQLException {
        boolean check = false;
        Connection con = null;
        PreparedStatement ptm = null;
        try {
            con = DBUtils.getConnection();
            if (con != null) {
                ptm = con.prepareStatement(CREATE);
                ptm.setString(1, user.getUserID());
                ptm.setString(2, user.getFullName());
                ptm.setString(3, user.getPassword());
                ptm.setString(4, user.getRoleID());
                ptm.setString(5, user.getAddress());
                ptm.setString(6, user.getBirthday());
                ptm.setString(7, user.getPhone());
                ptm.setString(8, user.getEmail());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        }
        catch (Exception e) {
            
        }
        finally {
            if (ptm != null) ptm.close();
            if (con != null) con.close();
        }
        return check;
    }
}
