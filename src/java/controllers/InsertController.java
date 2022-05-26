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
import shopping.Product;
import shopping.ProductDAO;
import shopping.ProductError;
import utils.Validators;

/**
 *
 * @author admin
 */
@WebServlet(name = "InsertController", urlPatterns = {"/InsertController"})
public class InsertController extends HttpServlet {

    private static final String ERROR = "GetCategoryIDController";
    private static final String SUCCESS = "GetCategoryIDController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        ProductError productErr = new ProductError();
        try {
            String productID = request.getParameter("productID");
            String productName = request.getParameter("productName");
            String image = request.getParameter("image");
            Double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String categoryID = request.getParameter("categoryID");
            String importDate = request.getParameter("importDate");
            String expiredDate = request.getParameter("expiredDate");
            ProductDAO dao = new ProductDAO();
            boolean checkValidation = true;
            boolean checkDuplicate = dao.checkDuplicate(productID);
            if (checkDuplicate) {
                productErr.setProductIDErr("Duplicate productID");
                checkValidation = false;
            }
            if (productID.length() < 2 || productID.length() > 10) {
                productErr.setProductIDErr("Product ID must be in [2; 10]");
                checkValidation = false;
            }
            if (productName.length() < 3 || productName.length() > 50) {
                productErr.setProductNameError("Product Name must be in [3; 50]");
                checkValidation = false;
            }
            if (!Validators.checkDate(importDate, expiredDate)) {
                productErr.setDateError("Invalid import date or expired date");
                checkValidation = false;
            }
            if (checkValidation) {
                Product product = new Product(productID, productName, image, price, quantity, importDate, expiredDate);
                boolean checkInsert = dao.insert(product, categoryID);
                if (checkInsert) {
                    url = SUCCESS;
                    request.setAttribute("MESSAGE", "Inserted successfully.");
                }
            }
            else {
                request.setAttribute("PRODUCT_ERROR", productErr);
            }
        }
        catch (Exception e) {
            log("Error at insertController: " + e.toString());
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
