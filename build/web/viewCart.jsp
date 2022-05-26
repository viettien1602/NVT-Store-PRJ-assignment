<%-- 
    Document   : viewCart
    Created on : Mar 9, 2022, 8:16:12 PM
    Author     : admin
--%>

<%@page import="user.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="shopping.Product"%>
<%@page import="shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/user.css">
    </head>

    <body>
        <div><h1><h1>Your shopping cart:</h1></h1></div>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !loginUser.getRoleID().equals("US")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <header>
            <nav class="navbar navbar-expand-sm navbar-dark bg-light fixed-top header">
                <div class="container-fluid">
                    <h1 class="navbar-brand" href="javascript:void(0)">Welcome user <%=loginUser.getFullName()%> to NVT store !</h1>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="mynavbar">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="javascript:void(0)"></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="javascript:void(0)"></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="javascript:void(0)"></a>
                            </li>
                        </ul>
                        <div class="d-flex">
                            <form action="userInfo.jsp">
                                <button class="btn" type="submit">Profile</button>
                            </form>
                            <form action="MainController">
                                <button class="btn" type="submit" name="action" value="View cart">View Cart</button>
                            </form>
                            <form action="MainController">
                                <button class="btn" type="submit" name="action" value="Logout">Logout</button>
                            </form>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
        <!-- ================================================================== -->

        <!-- Cover photo -->
        <div class = "cover-photo" style="background-image: url('images/ve1.jpg');background-size: cover; background-attachment: fixed;">
            <div class="slide">
                <div class="text">
                    <h1>NVT <br> FOOD AND VEGETABLE <br> STORE</h1>
                </div>
            </div>
        </div>

        <!-- ======================================================================================== -->
        <!-- CONTENT -->

        <div class = "body">

            <%
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart == null || cart.getCart().size() == 0) {
            %>
            <div style="text-align: center; color: red; margin-top: 20px">
                <h1>:( You haven't chosen any products yet !</h1>
            </div>
            <%
            } else {
            %>

            <div class="table">
                <table border="2" class="table table-striped " style="box-sizing: border-box">
                    <thead>
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Total</th>
                            <th scope="col">Delete</th>
                            <th scope="col">Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int count = 1;
                            double total = 0;
                            for (Product product : cart.getCart().values()) {
                                total += product.getPrice() * product.getQuantity();
                        %>
                    <form action="MainController">
                        <tr>
                            <td><%= count++%></td>
                            <td>
                                <%= product.getProductName()%>
                            </td>
                            <td>
                                <%= product.getPrice()%>$
                            </td>
                            <td>
                                <input type="number" name="quantity" value="<%= product.getQuantity()%>" min="1" />
                            </td>
                            <td>
                                <%= product.getPrice() * product.getQuantity()%>$
                            </td>
                            <td>
                                <input type="submit" name="action" value="Edit" />
                            </td>
                            <td>
                                <input type="submit" name="action" value="Remove" />
                            </td>
                        <input type="hidden" name="productID" value="<%=product.getProductID()%>" />
                        </tr>
                    </form>
                    <%
                        }
                    %> 
                    </tbody>
                    <div><h1><h1>Total price: <%=total%>$</h1></h1></div>
                </table>
                
            </div>
                
            <%
                List<String> messages = (List<String>) request.getAttribute("MESSAGES");
                if (messages != null) {
                    for (String mess : messages) {
            %>
            <div class="inform-text not-enough">* <%= mess%> *</div>
            <%
                    }
                }
            %>
            
            <div class = "checkout-button">
                <form>
                    <input type="submit" name="action" value="Check out" />
                </form>
            </div>
            <%
                }
            %>
            <div class = "addmore-button">
                <a href="GetAllController">Get back to shopping</a>
            </div>
        </div>


        <!-- ======================================================================================== -->
        <!-- FOOTER -->
        <footer>
            <div>CONTACT ME AT: VIETTIEN1602@GMAIL.COM</div>
        </footer>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


    </body>
</html>
