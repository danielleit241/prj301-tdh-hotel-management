<%-- 
    Document   : signup
    Created on : Jan 11, 2025, 7:45:07 PM
    Author     : hoade
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up</title>
    </head>
    <body>
        <form action="./signup">
            <p>Name:
                <input type="text" name="name">
            </p>
            <p>Username:
                <input type="text" name="username"> 
            </p>
            <p>Password:
                <input type="password" name="pass1">
            </p>
            <p>Confirm Password:
                <input type="password" name="pass2">
            </p>
            <input type="submit" value="Sign Up">
        </form>
        
    </body>
</html>
