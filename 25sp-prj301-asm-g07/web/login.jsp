<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f4f4; /* Light gray background */
            }
            .login-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .login-form {
                background-color: #ffffff;
                padding: 60px;
                border-radius: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                width: 600px;
            }
            .login-form h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
            .form-label {
                font-weight: 500;
                color: #555;
            }
            .btn-primary {
                background-color: rgb(200, 67, 97); 
                border-color: #007bff;
                width: 100%; 
                margin-top: 25px;
            }
            .btn-primary:hover {
                background-color: rgb(180, 67, 97);
                border-color: #0062cc;
            }
            .signup-link {
                text-align: center;
                margin-top: 15px;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-form">
                <h2>Login</h2>
                <% String error = (String) request.getAttribute("error");%>
                <form action="./login" method="GET">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" id="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" id="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Login</button>
                    <% if (error != null) {%>
                    <div class="alert alert-danger mt-3" role="alert">
                        <%=error%>
                    </div>
                    <%}%>
                    <div class="signup-link">
                        Don't have an account? <a href="signup.jsp">Sign up here.</a>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>