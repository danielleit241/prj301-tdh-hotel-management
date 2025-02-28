<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <%@include file="adminNavbar.jsp"%>
        <h1> ROOM DETAILS</h1>
        <table>
            <tr><td>ID</td><td>${requestScope.room.typeRoomID}</td></tr>	
            <tr><td>Type Name</td><td>${requestScope.room.typeName}</td></tr>	
            <tr><td>Description</td><td>${requestScope.room.typeDes}</td></tr>	
            <tr><td>Price</td><td>${requestScope.room.price}</td></tr>
            <tr><td>Room Size</td><td>${requestScope.room.roomSize}</td></tr>
            <tr><td>Bed Size</td><td>${requestScope.room.bedSize}</td></tr>	
            <tr><td>Max Occupancy</td><td>${requestScope.room.maxOccupancy}</td></tr>	
            <tr><td>View</td><td>${requestScope.room.viewDetail}</td></tr>
            <tr><td>Bathroom</td><td>${requestScope.room.bathroom}</td></tr>
            <tr><td>Smoking</td><td>${requestScope.room.smoking}</td></tr>	
        </table>

        <form action="manageRooms">
            <input type=hidden name="typeRoomID" value="${requestScope.room.typeRoomID}">
            <input type=hidden name="action" value="edit">
            <input type=submit value="Edit">
        </form>
    </body>
</html>
