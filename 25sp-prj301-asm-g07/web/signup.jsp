<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f4f4;
            }
            .signup-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .signup-form {
                background-color: #ffffff;
                padding: 60px;
                border-radius: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                width: 600px;
                .signup-form h2 {
                    text-align: center;
                    margin-bottom: 20px;
                    color: #333;
                }
                .form-label {
                    font-weight: 500;
                    color: #555;
                }
                .btn-primary {
                    background-color: rgb(200, 67, 97); /* Green button for signup */
                    border-color: #28a745;
                    width: 100%;
                }
                .btn-primary:hover {
                    background-color: rgb(180, 67, 97);
                    border-color: #1e7e34;
                }
                .login-link {
                    text-align: center;
                    margin-top: 15px;
                }
            </style>
        </head>
        <body>

            <div class="signup-container">
                <div class="signup-form">
                    <h2>Sign Up</h2>
                    <form action="./signup" method="POST"> <%-- Changed to POST for signup --%>
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" name="name" class="form-control" id="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" id="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" name="pass1" class="form-control" id="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" name="pass2" class="form-control" id="confirmPassword" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Sign Up</button>
                        <div class="login-link">
                            Already have an account? <a href="login.jsp">Login here.</a>
                        </div>
                    </form>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>
    </html>