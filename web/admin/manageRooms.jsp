<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Phòng</title>
        <link rel="icon" href="images/thd-icon.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
        
        <style>
            .custom-edit-button {
                padding: 5px;
                margin: 2px;
                background-color: #F8BB00; 
                border-radius: 5px;        
                text-decoration: none;    
                color: white;             
                font-weight: bold;         
                display: inline-block;    
                text-align: center;       
                transition: background-color 0.3s ease; 
            }

            .custom-edit-button:hover {
                background-color: #ffcc00; 
            }
        </style>
    </head>
    <body>
        <%@include file="adminNavbar.jsp" %>
        <div class="custom-edit-button">
            <a href="?action=create" class="custom-edit-button">Create</a>
        </div>
        <table class="admin-manage-rooms">
            <thead>
                <tr>
                    <th>TypeRoomID</th>
                    <th>Type Name</th>
                    <th>Price</th>
                    <th>Size</th>
                    <th>Bed Size</th>
                    <th>Max Occupancy</th>
                    <th>View Detail</th>
                    <th>Bathroom</th>
                    <th>Smoking</th>
                    <th>Discription</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${list}">
                    <tr>
                        <td><c:out value="${room.typeRoomID}"/></td>
                        <td><c:out value="${room.typeName}"/></td>
                        <td><c:out value="${room.price}"/></td>
                        <td><c:out value="${room.roomSize}"/></td>
                        <td><c:out value="${room.bedSize}"/></td>
                        <td><c:out value="${room.maxOccupancy}"/></td>
                        <td><c:out value="${room.viewDetail}"/></td>
                        <td><c:out value="${room.bathroom}"/></td>
                        <td><c:out value="${room.smoking}"/></td>
                        <td class="description"><c:out value="${room.typeDes}"/></td>
                <td class="actions">
                    <a href="?action=details&typeRoomID=${room.typeRoomID}" class="custom-edit-button">Edit</a>
                    <a href="?action=delete&typeRoomID=${room.typeRoomID}" onclick="return confirm('Are you sure you want to delete this Type Room?');" class="custom-edit-button-1">Delete</a>
                    
                </td>
               
            </tr>
        </c:forEach>
    </tbody>
</table>
        
        
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
