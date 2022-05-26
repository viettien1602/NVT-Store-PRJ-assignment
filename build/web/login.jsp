<%-- 
    Document   : login
    Created on : Mar 7, 2022, 2:38:06 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/login.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    </head>
    <body>
        <div class="sidenav" style="background-image: url('images/ve1.jpg'); background-size: cover; height: 101%;overflow-x: hidden; overflow: hidden;">
            <div class="shadow" style="background-color: #000; opacity: 0.7; height: 101%;">
                <div class="login-main-text">
                <h1 style="font-weight: bold;">NVT <br> Food and Vegetable Store</h1>
                </div>
            </div>
        </div>
        <div class="main">
            <div class="col-md-6 col-sm-12">
                <div class="login-form">
                    <h2>Please Login</h2>
                    <p>Login or register from here to access my store.</p>
                    <form action="MainController" method="POST">
                        <div class="form-group">
                            <label>User ID</label>
                            <input type="text" name="userID" class="form-control" placeholder="UserID" required=""/>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Password" required="" />
                        </div>
                        <button type="submit" name="action" value="Login" class="btn btn-black">Login</button>
                        <button type="submit" class="btn btn-secondary"><a href="create.jsp">Register</a></button>
                        <div class="message">${requestScope.ERROR}</div>
                    </form>
                </div>
            </div>
        </div>

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    </body>
</html>
