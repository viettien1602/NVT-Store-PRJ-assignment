<%-- 
    Document   : create
    Created on : Mar 9, 2022, 2:56:33 PM
    Author     : admin
--%>

<%@page import="user.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create new user Page</title>
        <link rel="stylesheet" href="css/create.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    </head>
    <body>
        <%
            UserError userErr = (UserError) request.getAttribute("USER_ERROR");
            if (userErr == null) userErr = new UserError();
        %>
        
        <a href="login.jsp">Back to login</a>
            
        <div class="sidenav" style="background-image: url('images/ve1.jpg'); 
             background-size: cover;
             height: 101%; overflow-x: hidden; overflow: hidden;">
            <div class="shadow" style="background-color: #000; opacity: 0.7; height: 101%; width:100%">
                <div class="login-main-text">
                <h1 style="font-weight: bold;">NVT <br> Food and Vegetable Store</h1>
                </div>
            </div>
        </div>
        <div class="main">
            <div class="col-md-7 col-sm-12">
                <div class="login-form">
                    <h2>Please fill out the information</h2>
                    <form action="MainController" method="POST">
                        <div class="form-group">
                            <label>User ID</label>
                            <input type="text" name="userID" class="form-control" required=""/>
                            <div class="message"><%= userErr.getUserIDErr()%></div>
                        </div>
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" class="form-control" required=""/>
                            <div class="message"><%= userErr.getFullNameErr()%></div>
                        </div>
                        <div class="form-group">
                            <label>Role ID</label>
                            <input type="text" name="roleID" class="form-control" required="" value="US" readonly=""/>
                            <div class="message"><%= userErr.getRoleIDErr()%></div>
                        </div>
                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" name="address" class="form-control" required=""/>
                        </div>
                        <div class="form-group">
                            <label>Birthday</label>
                            <input type="date" name="birthday" class="form-control" required=""/>
                        </div>
                        <div class="form-group">
                            <label>Phone</label>
                            <input type="text" name="phone" class="form-control" required=""/>
                            <div class="message"><%= userErr.getPhoneErr()%></div>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" required=""/>
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Password" required="" />
                        </div>
                        <div class="form-group">
                            <label>Confirm password</label>
                            <input type="password" name="confirm" class="form-control" placeholder="Password" required="" />
                            <div class="message"><%= userErr.getConfirmErr()%></div>
                        </div>
                        <button type="submit" name="action" value="Create" class="btn btn-black">Submit</button>
                        <button type="submit" class="btn btn-secondary"><a href="login.jsp">Back</a></button>
                    </form>
                </div>
            </div>
        </div>  
    </body>
</html>
