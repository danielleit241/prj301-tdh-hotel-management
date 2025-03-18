<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>THD Hotel Sign Up</title>
        <link rel="icon" href="images/thd-icon.png">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/style.css"/>
        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="login-container">
            <div class="login-form">
                <h2><a href="home.jsp" style="color: black; text-decoration: none; font-weight: 600">Sign Up</a></h2>
                <%
                    String errorPassword = (String) request.getAttribute("errorPassword");
                    String errorUsername = (String) request.getAttribute("errorUsername");
                    String success = (String) request.getAttribute("success");
                    String fail = (String) request.getAttribute("fail");
                %>
                <form action="./login" method="get">
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" name="name" class="form-control" id="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" id="username" required>
                    </div>
                    <% if (errorUsername != null) {%>
                    <div class="alert alert-danger mt-3" role="alert">
                        <%= errorUsername%>
                    </div>
                    <% } %>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" id="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="passwordConfirm" class="form-label">Confirm Password</label>
                        <input type="password" name="passwordConfirm" class="form-control" id="passwordConfirm" required>
                    </div>
                    <% if (errorPassword != null) {%>
                    <div class="alert alert-danger mt-3" role="alert">
                        <%= errorPassword%>
                    </div>
                    <% } %>
                    <input type="hidden" name="action" value="${nextAction}">
                    <button type="submit" class="btn btn-primary">Sign Up</button>

                    <% if (success != null) {%>
                    <div class="alert alert-success mt-3" role="alert">
                        <%= success%>
                    </div>
                    <% } else if (fail != null) {%>
                    <div class="alert alert-danger mt-3" role="alert">
                        <%= fail%>
                    </div>
                    <% }%>
                    <div class="login-link mt-3">
                        Already have an account? <a href="login.jsp">Log in here.</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Bootstrap JS Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
