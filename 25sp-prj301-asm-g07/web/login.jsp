<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <% String error = (String) request.getAttribute("error");%>        

        <form action="./login" method="GET">
            <p>Username:
                <input type="text" name="username"> 
            </p>
            <p>Password:
                <input type="password" name="password">
            </p>
            <input type="submit" value="Login">
            
        </form>
        <%
            if(error != null){%>
            <h4><%=error%></h4>
            <a href="signup.jsp">Sign Up</a>
        <%}%>
    </body>
</html>
