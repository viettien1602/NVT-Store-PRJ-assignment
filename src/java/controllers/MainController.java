/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class MainController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    //Login, logout, create new user
    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    private static final String CREATE = "Create";
    private static final String CREATE_CONTROLLER = "CreateController";
    //Search, add, view cart, edit, remove, checkout products
    private static final String GET_ALL = "Get all products";
    private static final String GET_ALL_CONTROLLER = "GetAllController";
    private static final String SEARCH = "Search";
    private static final String SEARCH_CONTROLLER = "SearchController";
    private static final String ADD = "Add to cart";
    private static final String ADD_CONTROLLER = "AddController";
    private static final String VIEW = "View cart";
    private static final String VIEW_CONTROLLER = "viewCart.jsp";
    private static final String EDIT = "Edit";
    private static final String EDIT_CONTROLLER = "EditController";
    private static final String REMOVE = "Remove";
    private static final String REMOVE_CONTROLLER = "RemoveController";
    private static final String CHECKOUT = "Check out";
    private static final String CHECKOUT_CONTROLLER = "CheckoutController";
    //update, delete, insert products
    private static final String UPDATE = "Update";
    private static final String UPDATE_CONTROLLER = "UpdateController";
    private static final String DELETE = "Delete";
    private static final String DELETE_CONTROLLER = "DeleteController";
    private static final String INSERT = "Insert";
    private static final String INSERT_CONTROLLER = "InsertController";
    private static final String GET_CATEGORYID = "GetCategoryID";
    private static final String GET_CATEGORYID_CONTROLLER = "GetCategoryIDController";
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            switch(action) {
                case LOGIN:
                    url = LOGIN_CONTROLLER;
                    break;
                case LOGOUT:
                    url = LOGOUT_CONTROLLER;
                    break;
                case CREATE:
                    url = CREATE_CONTROLLER;
                    break;
                case GET_ALL:
                    url = GET_ALL_CONTROLLER;
                    break;
                case SEARCH:
                    url = SEARCH_CONTROLLER;
                    break;
                case ADD:
                    url = ADD_CONTROLLER;
                    break;
                case VIEW:
                    url = VIEW_CONTROLLER;
                    break;
                case EDIT:
                    url = EDIT_CONTROLLER;
                    break;
                case REMOVE:
                    url = REMOVE_CONTROLLER;
                    break;
                case CHECKOUT:
                    url = CHECKOUT_CONTROLLER;
                    break;
                case UPDATE:
                    url = UPDATE_CONTROLLER;
                    break;
                case DELETE:
                    url = DELETE_CONTROLLER;
                    break;
                case INSERT:
                    url = INSERT_CONTROLLER;
                    break;
                case GET_CATEGORYID:
                    url = GET_CATEGORYID_CONTROLLER;
                    break;
            }
        }
        catch (Exception e) {
            log("Error at MainController: " + e.toString());
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
