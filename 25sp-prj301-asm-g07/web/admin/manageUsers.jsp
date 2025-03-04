<%-- 
    Document   : manageUser
    Created on : Feb 27, 2025, 1:39:29 AM
    Author     : TRAN PHU THINH
--%>

<%@page import="java.util.List"%>
<%@page import="prj301asm.User.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Người Dùng</title>

    </head>
    <body>
        <%@include file="adminNavbar.jsp" %>
        <table >
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Name</th>
                    <th>Role</th>

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
                    <td><a href="ManageUser?action=delete&username=${user.username}" 
                           onclick="return confirm('Are you sure you want to delete this student?');">Xóa</a></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

    </body>
</html>





