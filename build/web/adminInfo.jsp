<%-- 
    Document   : adminInfo
    Created on : Mar 12, 2022, 2:09:19 PM
    Author     : admin
--%>

<%@page import="user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin info Page</title>
    </head>
    <body>
        <% 
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !loginUser.getRoleID().equals("AD")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <h1><%=loginUser.getFullName()%> profile:</h1>
        <div>UserID: <%= loginUser.getUserID()%></div>
        <div>Full Name: <%= loginUser.getFullName()%></div>
        <div>RoleID: <%= loginUser.getRoleID()%></div>
        <div>Address: <%= loginUser.getAddress()%></div>
        <div>Birthday: <%= loginUser.getBirthday()%></div>
        <div>Phone: <%= loginUser.getPhone()%></div>
        <div>Email: <%= loginUser.getEmail()%></div>
        <a href="GetAllController">Get back to shopping</a>
    </body>
</html>
