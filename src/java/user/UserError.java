/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package user;

/**
 *
 * @author admin
 */
public class UserError {
    private String userIDErr;
    private String fullNameErr;
    private String roleIDErr;
    private String phoneErr;
    private String confirmErr;

    public UserError() {
        this.userIDErr = "";
        this.fullNameErr = "";
        this.roleIDErr = "";
        this.phoneErr = "";
        this.confirmErr = "";
    }

    public UserError(String userIDErr, String fullNameErr, String roleIDErr, String phoneErr, String confirmErr) {
        this.userIDErr = userIDErr;
        this.fullNameErr = fullNameErr;
        this.roleIDErr = roleIDErr;
        this.phoneErr = phoneErr;
        this.confirmErr = confirmErr;
    }

    public void setUserIDErr(String userIDErr) {
        this.userIDErr = userIDErr;
    }

    public void setFullNameErr(String fullNameErr) {
        this.fullNameErr = fullNameErr;
    }

    public void setRoleIDErr(String roleIDErr) {
        this.roleIDErr = roleIDErr;
    }

    public void setPhoneErr(String phoneErr) {
        this.phoneErr = phoneErr;
    }

    public void setConfirmErr(String confirmErr) {
        this.confirmErr = confirmErr;
    }

    public String getUserIDErr() {
        return userIDErr;
    }

    public String getFullNameErr() {
        return fullNameErr;
    }

    public String getRoleIDErr() {
        return roleIDErr;
    }

    public String getPhoneErr() {
        return phoneErr;
    }

    public String getConfirmErr() {
        return confirmErr;
    }
    
    
    
}
