<%-- 
    Document   : admin
    Created on : Mar 7, 2022, 4:17:02 PM
    Author     : admin
--%>

<%@page import="java.util.List"%>
<%@page import="shopping.Product"%>
<%@page import="user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
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

        <div class = "body">
            <div class = "get-all-button">
                <form action="MainController">
                    <input type="submit" name="action" value="Get all products"/>
                    <input type="hidden" name="search" value="[a-zA-Z1-9]" />
                </form>
            </div>

            <div class = "search">
                <form action="MainController">
                    <input type="text" name="search" required="" placeholder="Name of the product." class = "search-box"/>
                    <input type="submit" name="action" value="Search" class = "search-button"/>
                </form>
            </div>

            <%
                List<Product> listProduct = (List<Product>) request.getAttribute("LIST_PRODUCT");
                if (listProduct != null) {
                    if (listProduct.size() > 0) {
            %> 

            <div class="table" style="padding-left: 4%; padding-right: 4%;">
                <table border="2" class="table table-striped " style="box-sizing: border-box">
                    <thead>
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Image</th>
                            <th scope="col">Price</th>
                            <th scope="col">Available Quantity</th>
                            <th scope="col">Import Date</th>
                            <th scope="col">Expired Date</th>
                            <th scope="col">Update</th>
                            <th scope="col">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        int count = 1;
                        for (Product product : listProduct) {
                    %>
                    <form action="MainController">
                        <tr>
                        <input type="hidden" name="productID" value="<%=product.getProductID()%>" />
                        <%
                            String search = (String) request.getParameter("search");
                            if (search == null) search = "[a-zA-Z1-9]";
                        %>
                        <input type="hidden" name="search" value="<%=search%>" />
                        <td scope="row"><%= count++%></td>
                        <td>
                            <input class="small" type="text" name="productName" value="<%= product.getProductName()%>" required="" />
                        </td>
                        <td>
                            <img src="<%= product.getImage()%>" alt="Image" class="img-thumbnail" style="width: 200px"></br>
                            Link: <input type="text" name="image" value="<%= product.getImage()%>"  required=""/>
                        </td>
                        <td>
                            <input class="small" type="number" step="0.01" min="0" name="price" value="<%= product.getPrice()%>" required="" />$
                        </td>
                        <td>
                            <input class="small" type="number" name="quantity" min="1" value="<%= product.getQuantity()%>" required="" />
                        </td>
                        <td>
                            <input type="date" name="importDate" value="<%= product.getImportDate()%>" required="" />
                        </td>
                        <td>
                            <input type="date" name="expiredDate" value="<%= product.getExpiredDate()%>" required="" />
                        </td>
                        <td>
                            <input type="submit" name="action" value="Update" /> </br>
                            <%
                                if (product.getProductID().equals(request.getParameter("productID"))) {
                            %>
                            <div class="inform-text">${requestScope.MESSAGE}</div>
                            <%
                                }
                            %>
                        </td>
                        <td>  
                            <input type="submit" name="action" value="Delete" />
                        </td>
                        </tr>
                    </form>

                    <%
                        }
                    %>
                    </tbody>
                </table>
                <%
                        }
                    }
                %>
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
