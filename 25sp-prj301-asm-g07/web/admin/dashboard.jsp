<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <%@include file="./adminNavbar.jsp"%>
        <div class="container mt-5">
            <<div class="container admin-dashboard">
                <h2>Quản trị viên - Bảng điều khiển</h2>
                <div class="dashboard-buttons">
                    <a href="./manageRooms" class="dashboard-button">Quản lý Phòng</a>
                    <a href="./manageBookings" class="dashboard-button">Quản lý Đặt Phòng</a>
                    <a href="./manageReviews" class="dashboard-button">Quản lý Đánh giá</a>
                </div>
            </div>
        </div>
    </body>
</html>
