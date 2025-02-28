<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Navbar</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container d-flex justify-content-between">
                <a class="navbar-brand" href="#">THD-Hotel</a>
                <div class="navbar-nav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="dashboard.jsp">Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./manageRooms">Danh sách phòng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./manageBookings">Quản Lí Đặt phòng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Quản Lí Đánh Giá</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../home.jsp">Liên hệ</a>
                        </li>
                    </ul>
                </div>
                <div class="navbar-nav">
                    <span class="nav-link">
                        Hello: ${sessionScope.user.name} |
                        <a href="../login?action=logout" class="logout-link">Đăng xuất</a>
                    </span>
                </div>
            </div>
        </nav>
    </body>
</html>
