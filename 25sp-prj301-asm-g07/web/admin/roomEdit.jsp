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
        <h1> ROOM EDIT</h1>
        <form action = "manageRooms" method="GET">
            <table>
                <tr><td>ID</td><td><input type="text" name="typeRoomID" value="${requestScope.room.typeRoomID}" readonly></td></tr>

                <tr><td>Type Name</td><td><input name="typeName" value="${requestScope.room.typeName}" type="text"></td></tr>

                <tr><td>Description</td><td><input name="typeDes" value="${requestScope.room.typeDes}" type="text"></td></tr>

                <tr><td>Price</td><td><input name="price" value="${requestScope.room.price}" type="text"></td></tr>

                <tr><td>Room Size</td><td><input name="roomSize" value="${requestScope.room.roomSize}" type="text"></td></tr>

                <tr><td>Bed Size</td><td><input name="bedSize" value="${requestScope.room.bedSize}" type="text"></td></tr>

                <tr><td>Max Occupancy</td><td><input name="maxOccupancy" value="${requestScope.room.maxOccupancy}" type="text"></td></tr>

                <tr><td>View Detail</td><td><input name="viewDetail" value="${requestScope.room.viewDetail}" type="text"></td></tr>

                <tr><td>Bathroom</td><td><input name="bathroom" value="${requestScope.room.bathroom}" type="text"></td></tr>

                <tr><td>Smoking</td><td><input name="smoking" value="${requestScope.room.smoking}" type="text"></td></tr>

                <p>${error}</p>
                <tr><td colspan="2">
                        <input name="action" value="update" type="hidden">                 
                        <input type="Submit" value="Save">
                    </td></tr>
            </table>  

        </form>


    </body>
</html>
