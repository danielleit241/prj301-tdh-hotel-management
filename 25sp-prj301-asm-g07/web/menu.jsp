<%-- 
    Document   : menu
    Created on : Feb 14, 2025, 5:32:36 PM
    Author     : hoade
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>THD-HOTEL</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .navbar {
                background-color: black !important;
            }

            .navbar-brand,
            .navbar-nav .nav-link { /* Combined selectors for efficiency */
                color: white !important;
            }

            .navbar-nav .nav-link.active {
                color: #cccccc !important; 
            }
        </style>
    </head>
    <body>
        <!--        <a href="login.jsp">Login</a>
                <a href="signup.jsp">Sign Up</a>
                <a href="login?action=logout">Logout</a>
                <a href="roomList?page=1">Our Room</a>-->

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" href="home.jsp">THD-Hotel</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">

                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="">Hello: ${sessionScope.user.name}</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="login.jsp">Log In</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="signup.jsp">Sign Up</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="login?action=logout">Log Out</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="roomList?page=1">Room List</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>
