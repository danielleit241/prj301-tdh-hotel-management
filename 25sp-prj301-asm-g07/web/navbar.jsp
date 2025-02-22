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
            <div class="container">
                <a class="navbar-brand" href="#">THD-Hotel</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="">Hello: ${sessionScope.user.name}</a>
                        </li>
                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <li class="nav-item">
                                    <a class="nav-link" aria-current="page" href="login.jsp">Log In</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="signup.jsp">Sign Up</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="login?action=logout">Log Out</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        <li class="nav-item">
                            <a class="nav-link" href="roomList?page=1">Room List</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
</body>
</html>
