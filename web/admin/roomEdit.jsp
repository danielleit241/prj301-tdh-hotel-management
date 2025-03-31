<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Edit</title>
        <link rel="icon" href="images/thd-icon.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css" />
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
        <style>
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
        </style>
    </head>
    <body>
        <%@include file="adminNavbar.jsp" %>

        <div class="container">
            <h1 style="text-align: center">ROOM EDIT</h1>
            <p class="error-msg">${error}</p>
            <form action="manageRooms" method="POST" enctype="multipart/form-data">
                <table class="table-roomEdit">
                    <tr>
                        <td><strong>ID</strong></td>
                        <td><input type="text" name="typeRoomID" value="${requestScope.room.typeRoomID}" readonly></td>
                    </tr>
                    <tr>
                        <td><strong>Type Name</strong></td>
                        <td><input name="typeName" value="${requestScope.room.typeName}" type="text" required></td>
                    </tr>
                    <tr>
                        <td><strong>Description</strong></td>
                        <td><input name="typeDes" value="${requestScope.room.typeDes}" type="text" required></td>
                    </tr>
                    <tr>
                        <td><strong>Price</strong></td>
                        <td><input name="price" value="${requestScope.room.price}" type="text" required></td>
                    </tr>
                    <tr>
                        <td><strong>Room Size</strong></td>
                        <td><input name="roomSize" value="${requestScope.room.roomSize}" type="text" required></td>
                    </tr>
                    <tr>
                        <td><strong>Bed Size</strong></td>
                        <td><input name="bedSize" value="${requestScope.room.bedSize}" type="text" required></td>
                    </tr>
                    <tr>
                        <td><strong>Max Occupancy</strong></td>
                        <td><input name="maxOccupancy" value="${requestScope.room.maxOccupancy}" type="text" required></td>
                    </tr>
                    <tr>
                        <td><strong>View Detail</strong></td>
                        <td><input name="viewDetail" value="${requestScope.room.viewDetail}" type="text" required></td>
                    </tr>
                    <tr>
                        <td><strong>Bathroom</strong></td>
                        <td><input name="bathroom" value="${requestScope.room.bathroom}" type="text" required></td>
                    </tr>
                    <tr>
                        <td><strong>Smoking</strong></td>
                        <td><input name="smoking" value="${requestScope.room.smoking}" type="text" required></td>
                    </tr>
                    <%
                        String action = request.getParameter("action");
                        if (!action.equals("create")) {
                    %>
                    <tr>
                        <td><strong>Room List</strong></td>
                        <td>
                            <table class="table-roomEdit room-list-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>
                                            <div class="row">
                                                <div class="col-10">Action</div>
                                                <div class="col-2">
                                                    <button type="button" class="btn-add_roomEdit" onclick="showAddRoomForm()">+</button>
                                                </div>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="r" items="${listRoom}">
                                        <tr>
                                            <td>${r.roomID}</td>
                                            <td>
                                                <a href="manageRooms?action=deleteRoom&typeRoomID=${requestScope.room.typeRoomID}&roomID=${r.roomID}"
                                                   class="btn-delete_roomEdit"
                                                   onclick="return confirm('Are you sure you want to delete this room?');">
                                                    Delete
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <%
                    } else if (action.equals("create")) {
                    %>
                    <tr>
                        <td><strong>Upload Image</strong></td>
                        <td><input type="file" name="roomImages" accept="image/*" multiple></td>
                    </tr>
                    <%}%>
                </table>
                <input name="action" value="${requestScope.nextActionTypeRoom}" type="hidden">
                <input type="submit" class="save-btn_roomEdit" value="Save">
            </form>

            <!-- Overlay chứa form tạo phòng mới -->
            <div class="overlay-roomEdit" id="addRoomOverlay">
                <div class="add-room-form" style="width: 600px">
                    <span class="close-roomEdit-btn" onclick="hideAddRoomForm()">×</span>
                    <h3 style="text-align: center; font-weight: 600; margin: 10px;">Add New Room</h3>
                    <form action="manageRooms" method="POST">
                        <table class="table-roomEdit">
                            <tr>
                                <td><strong>Room ID</strong></td>
                                <td><input type="text" name="roomID" required placeholder="Enter Room ID (e.g., typeRoomID + 1...)"></td>
                            </tr>
                            <tr>
                                <td><strong>Type Room ID</strong></td>
                                <td><input type="text" name="typeRoomID" value="${requestScope.room.typeRoomID}" readonly></td>
                            </tr>
                        </table>
                        <input type="hidden" name="action" value="insertRoom">
                        <input type="submit" class="save-btn_roomEdit add-room-btn" value="Add Room">
                    </form>
                </div>
            </div>
        </div>

        <script>
            function showAddRoomForm() {
                document.getElementById("addRoomOverlay").style.display = "flex";
            }

            function hideAddRoomForm() {
                document.getElementById("addRoomOverlay").style.display = "none";
            }
        </script>
    </body>
</html>