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
            <h2 class="text-center">Quản trị viên - Bảng điều khiển</h2>
            <div class="row mt-4">
                <div class="col-md-4">
                    <a href="./manageRooms" class="btn btn-outline-primary w-100">Quản lý Phòng</a>
                </div>
                <div class="col-md-4">
                    <a href="./manageBookings" class="btn btn-outline-primary w-100">Quản lý Đặt Phòng</a>
                </div>
                <div class="col-md-4">
                    <a href="manageReviews.jsp" class="btn btn-outline-primary w-100">Quản lý Đánh giá</a>
                </div>
            </div>
        </div>
    </body>
</html>
