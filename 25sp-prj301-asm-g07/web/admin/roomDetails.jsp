<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Details</title>
        <link rel="icon" href="images/thd-icon.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
        <style>


            h1 {
                text-align: center;
                font-weight: bold;
                margin-bottom: 20px;
            }



            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background: #f0f0f0;
                font-weight: bold;
                text-transform: uppercase;
            }

            tr:hover {
                background: #f9f9f9;
            }

            .edit-btn {
                display: block;
                width: 150px;
                margin: 20px auto;
                padding: 10px;
                text-align: center;
                background: #ffc107;
                color: black;
                font-size: 16px;
                font-weight: bold;
                border: none;
                border-radius: 5px;
                text-decoration: none;
            }

            .edit-btn:hover {
                background: #e0a800;
            }
        </style>
    </head>
    <body>
        <%@include file="adminNavbar.jsp"%>
        <div class="container">
            <h1>ROOM DETAILS</h1>
            <table>
                <tr><td><strong>ID</strong></td><td>${requestScope.room.typeRoomID}</td></tr>	
                <tr><td><strong>Type Name</strong></td><td>${requestScope.room.typeName}</td></tr>	
                <tr><td><strong>Description</strong></td><td>${requestScope.room.typeDes}</td></tr>	
                <tr><td><strong>Price</strong></td><td>${requestScope.room.price}</td></tr>
                <tr><td><strong>Room Size</strong></td><td>${requestScope.room.roomSize}</td></tr>
                <tr><td><strong>Bed Size</strong></td><td>${requestScope.room.bedSize}</td></tr>	
                <tr><td><strong>Max Occupancy</strong></td><td>${requestScope.room.maxOccupancy}</td></tr>	
                <tr><td><strong>View</strong></td><td>${requestScope.room.viewDetail}</td></tr>
                <tr><td><strong>Bathroom</strong></td><td>${requestScope.room.bathroom}</td></tr>
                <tr><td><strong>Smoking</strong></td><td>${requestScope.room.smoking}</td></tr>	
            </table>

            <form action="manageRooms">
                <input type="hidden" name="typeRoomID" value="${requestScope.room.typeRoomID}">
                <input type="hidden" name="action" value="edit">
                <input type="submit" class="edit-btn" value="Edit">
            </form>
        </div>
    </body>
</html>
