<%@page import="java.util.List"%>
<%@page import="prj301asm.User.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Người Dùng</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <%@include file="adminNavbar.jsp" %>
        <table class="user-table"> <%-- Thêm class cho table --%>
            <thead>
                <tr>
                    <th class="user-header">Username</th> <%-- Thêm class cho header --%>
                    <th class="user-header">Password</th> <%-- Thêm class cho header --%>
                    <th class="user-header">Name</th> <%-- Thêm class cho header --%>
                    <th class="user-header">Role</th> <%-- Thêm class cho header --%>
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
                <tr class="user-row"> <%-- Thêm class cho row --%>
                    <td class="user-data"><%= user.getUsername()%></td> <%-- Thêm class cho data --%>
                    <td class="user-data"><%= user.getPassword()%></td> <%-- Thêm class cho data --%>
                    <td class="user-data"><%= user.getName()%></td> <%-- Thêm class cho data --%>
                    <td class="user-data"><%= user.getRole()%></td> <%-- Thêm class cho data --%>
                    <td class="user-action"> <%-- Thêm class cho action --%>
                        <a href="ManageUser?action=delete&username=${user.username}"
                           onclick="return confirm('Are you sure you want to delete this student?');"
                           class="user-delete-link"> <%-- Thêm class cho link --%>
                            Xóa
                        </a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </body>
</html>