/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import shopping.Cart;
import shopping.Product;
import shopping.ProductDAO;
import user.UserDTO;

/**
 *
 * @author admin
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "checkout.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart == null) {
                cart = new Cart();
                request.setAttribute("ERROR", "Your shopping cart is empty");
            }
            else {
                if (cart.getCart().size() == 0) {
                    request.setAttribute("ERROR", "Your shopping cart is empty");
                }
                else {
                    List<String> messages = new ArrayList<>();
                    double total = 0;
                    ProductDAO dao = new ProductDAO();
                    for (Product product : cart.getCart().values()) {
                        if (!dao.checkQuantity(product.getProductID(), product.getQuantity())) {
                            messages.add("We don't have enough " + product.getProductName());
                        }
                        total += product.getPrice() * product.getQuantity();
                    }
                    if (messages.size() > 0) {
                        request.setAttribute("MESSAGES", messages);
                    }
                    else {
                        UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
                        String orderID = dao.createOrder(user.getUserID(), total);
                        for (Product product : cart.getCart().values()) {
                            dao.createOrderDetail(orderID, product);
                            dao.updateQuantity(product);
                        }
                        request.setAttribute("ORDER_ID", orderID);
                        request.setAttribute("CART", cart);
                        url = SUCCESS;
                        session.removeAttribute("CART");  
                    }
                }
            }
        }
        catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
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
