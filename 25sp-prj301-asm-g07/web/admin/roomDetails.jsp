<%-- 
    Document   : roomDetails
    Created on : Feb 24, 2025, 7:13:36 PM
    Author     : TRAN PHU THINH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1> ROOM DETAILS</h1>
        <table>
            <tr><td>Room ID</td><td>${requestScope.room.roomID}</td></tr>
            <tr><td>Room Name</td><td>${requestScope.room.roomName}</td></tr>
            <tr><td>Type Name</td><td>${requestScope.room.typeName}</td></tr>	
            <tr><td>Price</td><td>${requestScope.room.price}</td></tr>
            <tr><td>Description</td><td>${requestScope.room.description}</td></tr>
        </table>

        <form action="manageRooms">
            <input type=hidden name="roomID" value="${requestScope.room.roomID}">
            <input type=hidden name="action" value="edit">
            <input type=submit value="Edit">
        </form>
    </body>
</html>
