/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import user.UserDAO;
import user.UserDTO;
import user.UserError;
import utils.Validators;

/**
 *
 * @author admin
 */
@WebServlet(name = "CreateController", urlPatterns = {"/CreateController"})
public class CreateController extends HttpServlet {

    private static final String ERROR = "create.jsp";
    private static final String SUCCESS = "login.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserError userErr = new UserError();
        try {
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String roleID = request.getParameter("roleID");
            String address = request.getParameter("address");
            String birthday = request.getParameter("birthday");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            UserDAO dao = new UserDAO();
            boolean checkValidation = true;
            boolean checkDuplicate = dao.checkDuplicate(userID);
            if (checkDuplicate) {
                userErr.setUserIDErr("Duplicate UserID.");
                checkValidation = false;
            }
            if (userID.length() < 2 || userID.length() > 20) {
                userErr.setUserIDErr("UserID must be in [2; 20]");
                checkValidation = false;
            }
            if (fullName.length() < 5 || fullName.length() > 50) {
                userErr.setFullNameErr("Full name must be in [5; 50]");
                checkValidation = false;
            }
            if (!roleID.equals("US")) {
                userErr.setRoleIDErr("RoleID is not supported.");
                checkValidation = false;
            }
            if (!Validators.validatePhone(phone)) {
                userErr.setPhoneErr("Invalid phone number.");
                checkValidation = false;
            }
            if (!confirm.equals(password)) {
                userErr.setConfirmErr("Confirm password does not match.");
                checkValidation = false;
            }
            
            if (checkValidation) {
                UserDTO user = new UserDTO(userID, fullName, password, roleID, address, birthday, phone, email, true);
                boolean checkCreate = dao.create(user);
                if (checkCreate) url = SUCCESS;
            }
            else {
                request.setAttribute("USER_ERROR", userErr);
            }
        }
        catch (Exception e) {
            log("Error at CreateController: " + e.toString());
        }
        finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
