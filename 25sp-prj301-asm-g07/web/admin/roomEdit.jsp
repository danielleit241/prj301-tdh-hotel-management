<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Edit</title>
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

            table {
                width: 100%;
                font-size: 16px;
            }

            td {
                padding: 10px;
                vertical-align: middle;
            }

            input[type="text"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            .error-msg {
                color: red;
                font-weight: bold;
                text-align: center;
                margin-bottom: 15px;
            }

            .save-btn {
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

            .save-btn:hover {
                background: #218838;
            }
        </style>
    </head>
    <body>
        <%@include file="adminNavbar.jsp"%>

        <div class="container">
            <h1>ROOM EDIT</h1>
            <form action="manageRooms" method="GET">
                <table>
                    <tr>
                        <td><strong>ID</strong></td>
                        <td><input type="text" name="typeRoomID" value="${requestScope.room.typeRoomID}" readonly></td>
                    </tr>

                    <tr>
                        <td><strong>Type Name</strong></td>
                        <td><input name="typeName" value="${requestScope.room.typeName}" type="text"></td>
                    </tr>

                    <tr>
                        <td><strong>Description</strong></td>
                        <td><input name="typeDes" value="${requestScope.room.typeDes}" type="text"></td>
                    </tr>

                    <tr>
                        <td><strong>Price</strong></td>
                        <td><input name="price" value="${requestScope.room.price}" type="text"></td>
                    </tr>

                    <tr>
                        <td><strong>Room Size</strong></td>
                        <td><input name="roomSize" value="${requestScope.room.roomSize}" type="text"></td>
                    </tr>

                    <tr>
                        <td><strong>Bed Size</strong></td>
                        <td><input name="bedSize" value="${requestScope.room.bedSize}" type="text"></td>
                    </tr>

                    <tr>
                        <td><strong>Max Occupancy</strong></td>
                        <td><input name="maxOccupancy" value="${requestScope.room.maxOccupancy}" type="text"></td>
                    </tr>

                    <tr>
                        <td><strong>View Detail</strong></td>
                        <td><input name="viewDetail" value="${requestScope.room.viewDetail}" type="text"></td>
                    </tr>

                    <tr>
                        <td><strong>Bathroom</strong></td>
                        <td><input name="bathroom" value="${requestScope.room.bathroom}" type="text"></td>
                    </tr>

                    <tr>
                        <td><strong>Smoking</strong></td>
                        <td><input name="smoking" value="${requestScope.room.smoking}" type="text"></td>
                    </tr>
                </table>  

                <p class="error-msg">${error}</p>

                <input name="action" value="update" type="hidden">                 
                <input type="submit" class="save-btn" value="Save">
            </form>
        </div>
    </body>
</html>
