/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import shopping.Product;
import shopping.ProductDAO;
import user.UserDTO;

/**
 *
 * @author admin
 */
@WebServlet(name = "GetAllController", urlPatterns = {"/GetAllController"})
public class GetAllController extends HttpServlet {

    private static final String ERROR_US = "user.jsp";
    private static final String SUCCESS_US = "user.jsp";
    private static final String ERROR_AD = "admin.jsp";
    private static final String SUCCESS_AD = "admin.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url;
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
        if (loginUser.getRoleID().equals("US")) url = ERROR_US;
        else url = ERROR_AD;
        
        
        try {
            ProductDAO dao = new ProductDAO();
            List<Product> listProduct = dao.getAllProduct();
            if (listProduct.size() > 0) {
                request.setAttribute("LIST_PRODUCT", listProduct);
                
                if (loginUser.getRoleID().equals("US")) url = SUCCESS_US;
                else url = SUCCESS_AD;
            }
        }
        catch (Exception e) {
            log("Error at GetAllController: " + e.toString());
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
