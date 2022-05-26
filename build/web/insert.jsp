<%-- 
    Document   : insert
    Created on : Mar 10, 2022, 8:47:36 PM
    Author     : admin
--%>

<%@page import="user.UserDTO"%>
<%@page import="shopping.ProductError"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/user.css">
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !loginUser.getRoleID().equals("AD")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <header>
            <nav class="navbar navbar-expand-sm navbar-dark bg-light fixed-top header">
                <div class="container-fluid">
                    <h1 class="navbar-brand" href="javascript:void(0)">Welcome admin <%=loginUser.getFullName()%> to NVT store !</h1>
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
                            <form action="adminInfo.jsp">
                                <button class="btn" type="submit">Profile</button>
                            </form>
                            <form action="MainController">
                                <button class="btn" type="submit" name="action" value="GetCategoryID">Add</button>
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
        <%
            ProductError productErr = (ProductError) request.getAttribute("PRODUCT_ERROR");
            if (productErr == null) {
                productErr = new ProductError();
            }
        %>
        <div class = "body">
            <div class="main">
                <div class="col-md-5 col-sm-12">
                    <div class="login-form">
                        <div style="text-align: center; margin-top: 20px"><h2>Please fill out the information</h2></div>
                        <form action="MainController" method="POST">
                            <div class="form-group">
                                <label>Product ID</label>
                                <input type="text" name="productID" class="form-control" required=""/>
                                <div class="message"><%= productErr.getProductIDErr()%></div>
                            </div>
                            <div class="form-group">
                                <label>Product Name</label>
                                <input type="text" name="productName" class="form-control" required=""/>
                                <div class="message"><%= productErr.getProductNameError()%></div>
                            </div>
                            <div class="form-group">
                                <label>Link image</label>
                                <input type="text" name="image" class="form-control" required="" placeholder="Input link of the image"/>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input type="number" step="0.01" min="0" name="price" class="form-control" required="" placeholder="$"/>
                            </div>
                            <div class="form-group">
                                <label>Quantity</label>
                                <input type="number" min="1" name="quantity" class="form-control" required=""/>
                            </div>
                            <div class="form-group">
                                <label>Category ID</label>
                                <select name="categoryID" class="form-control">
                                    <%
                                        List<String> listCategory = (List<String>) request.getAttribute("CATEGORY_ID");
                                        if (listCategory != null) {
                                            if (listCategory.size() > 0) {
                                                for (String categoryID : listCategory) {
                                    %>
                                    <option value="<%=categoryID%>"><%=categoryID%></option>
                                    <%
                                                }
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Import date</label>
                                <input type="date" name="importDate" class="form-control" required=""/>
                                <div class="message"><%= productErr.getDateError()%></div>
                            </div>
                            <div class="form-group">
                                <label>Expired date</label>
                                <input type="date" name="expiredDate" class="form-control" required=""/>
                                <div class="message"><%= productErr.getDateError()%></div>
                            </div>
                            <div class="message">${requestScope.MESSAGE}</div>
                            <button type="submit" name="action" value="Insert" class="btn btn-black">Add</button>
                            <button type="submit" class="btn btn-secondary"><a href="GetAllController">Back</a></button>
                        </form>
                    </div>
                </div>
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
