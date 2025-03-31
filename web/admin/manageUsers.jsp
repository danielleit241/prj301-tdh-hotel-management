<%@page import="java.util.List"%>
<%@page import="prj301asm.User.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Người Dùng</title>
        <link rel="icon" href="images/thd-icon.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            tr:hover {
                background-color: #f1f1f1;
            }
            .delete-btn {
                color: white;
                background-color: red;
                padding: 5px 10px;
                text-decoration: none;
                border-radius: 5px;
            }
            .delete-btn:hover {
                background-color: darkred;
            }
        </style>
    </head>
    <%@include file="adminNavbar.jsp" %>
    <table class="user-table"> <%-- Thêm class cho table --%>
        <thead>
            <tr>
                <th class="user-header">Username</th> <%-- Thêm class cho header --%>
                <th class="user-header">Password</th> <%-- Thêm class cho header --%>
                <th class="user-header">Name</th> <%-- Thêm class cho header --%>
                <th class="user-header">Role</th> <%-- Thêm class cho header --%>
                <th class="user-header">Status</th>
                <th class="user-header">Action</th> <%-- Thêm class cho header --%>

            </tr>
        </thead>
        <tbody>
            <%
                List<UserDTO> list = (List<UserDTO>) request.getAttribute("list");
                if (list != null && !list.isEmpty()) {
                    for (UserDTO user : list) {
                        pageContext.setAttribute("user", user);
            %>

            <tr>
                <td><%= user.getUsername()%></td>
                <td><%= user.getPassword()%></td>
                <td><%= user.getName()%></td>
                <td><%= user.getRole()%></td>
                <td><%= user.getStatus()%></td>
                <td><% if (user.getStatus().equals("active")) { %>
                    <a href="ManageUser?action=ban&username=${user.username}" 
                       class="delete-btn"
                       onclick="return confirm('Are you sure you want to ban this user?');">
                        <i class="fas fa-ban"></i> Ban
                    </a>
                    <% } else if (user.getStatus().equals("inactive")) { %>
                    <a href="ManageUser?action=unban&username=${user.username}" 
                       class="delete-btn"
                       style="background-color: green; color: white; padding: 5px; border-radius: 4px;"
                       onclick="return confirm('Are you sure you want to unban this user?');">
                        <i class="fas fa-check"></i> Unban
                    </a>
                    <% } %>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</body>



</html>
