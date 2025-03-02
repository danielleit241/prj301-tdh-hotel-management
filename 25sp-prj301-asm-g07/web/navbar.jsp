<%-- 
    Document   : home
    Created on : Jan 11, 2025, 8:02:13 PM
    Author     : hoade
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container d-flex justify-content-between">
                <a class="navbar-brand" href="home.jsp">THD-Hotel</a>
                <div class="navbar-nav">
                    <ul class="navbar-nav me-auto">
                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                            </c:when>
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose>
                        <li class="nav-item">
                            <a class="nav-link" href="home.jsp">HOME</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="roomList?page=1">OUR ROOM</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="booking?action=list">BOOKING</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">CONTACT</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">ABOUT </a>
                        </li>
                    </ul>
                </div>
                <div class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <span class="nav-link">Hello: ${sessionScope.user.name} | <a href="login?action=logout" class="logout-link">Log Out</a></span>
                        </c:when>
                        <c:otherwise>
                            <span class="nav-link"><a href="login.jsp">Log In</a> | <a href="login?action=signup">Sign Up</a></span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </nav>
    </body>
</html>
