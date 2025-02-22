<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Room List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
        <style>
            /*            body {
                            font-family: Arial, sans-serif;
                            background-color: #f8f9fa;
                            margin: 0;
                            padding: 0;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            height: 100vh;
                        }
            
                        .container {
                            display: grid;
                            grid-template-columns: repeat(3, 1fr);  Hiển thị 3 cột 
                            gap: 20px;  Khoảng cách giữa các phần tử 
                            justify-content: center;
                            align-content: center;
                        }
            
                        .card {
                            background-color: #fff;
                            border-radius: 10px;
                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                            overflow: hidden;
                            width: 300px;  Đặt chiều rộng cố định 
                            transition: transform 0.3s ease;
                            position: relative;
                        }
            
                        .card:hover {
                            transform: translateY(-10px);
                        }
            
                        .card img {
                            width: 100%;
                            height: 180px;
                            object-fit: cover;
                        }
            
                        .card-content {
                            padding: 15px;
                        }
            
                        .card-content h3 {
                            font-size: 18px;
                            margin: 10px 0;
                            color: #333;
                        }
            
                        .card-content p {
                            font-size: 14px;
                            color: #777;
                            margin: 5px 0;
                        }
            
                        .card-content .rating {
                            display: flex;
                            align-items: center;
                            gap: 5px;
                            margin: 10px 0;
                        }
            
                        .rating span {
                            background-color: #0066cc;
                            color: white;
                            font-size: 12px;
                            font-weight: bold;
                            padding: 3px 7px;
                            border-radius: 5px;
                        }
            
                        .card-content .price {
                            font-size: 16px;
                            font-weight: bold;
                            color: #333;
                            margin-top: 10px;
                        }
            
                        .favorite-icon {
                            position: absolute;
                            top: 10px;
                            right: 10px;
                            background-color: white;
                            border-radius: 50%;
                            padding: 8px;
                            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                            cursor: pointer;
                        }
            
                         Đảm bảo tính responsive 
                        @media (max-width: 768px) {
                            .container {
                                grid-template-columns: repeat(2, 1fr);  Hiển thị 2 cột trên màn hình nhỏ 
                            }
            
                            .card {
                                width: auto;  Card sẽ tự động điều chỉnh kích thước 
                            }
                        }
            
                        @media (max-width: 480px) {
                            .container {
                                grid-template-columns: 1fr;  Hiển thị 1 cột trên màn hình rất nhỏ 
                            }
                        }*/
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">THD-Hotel</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="">Hello: ${sessionScope.user.name}</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="login.jsp">Log In</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="signup.jsp">Sign Up</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="login?action=logout">Log Out</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="roomList?page=1">Room List</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div>
            <form action="./roomList">
                <input type="hidden" name="page" value="${currentPage != null ? currentPage : 1}" />
                <input type="text" name="typeRoom" value="${search != null ? search : ""}">
                <input type="submit" value="Search">
            </form>
        </div>
        <div class="container">
            <c:forEach var="room" items="${list}">
                <div class="card">
                    <a href="roomDetails?roomID=${room.roomID}">
                        <img src="images/${room.roomID}/${room.roomID}.jpg" alt="Room Image">
                    </a>
                    <div class="favorite-icon">❤️</div>
                    <div class="card-content">
                        <h3>${room.roomName}</h3>
                        <p>Type room: ${room.typeName}</p>
                        <p class="price">Starting from: 
                            <fmt:formatNumber value="${room.price}" pattern="#,##0" /> VNĐ
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>

    </body>
</html>