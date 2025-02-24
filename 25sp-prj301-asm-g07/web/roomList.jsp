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

        </style>
    </head>
    <body>
        <%@include file="/navbar.jsp"%>
        <div class="search-container"> 
            <form action="./roomList" class="search-form"> 
                <input type="hidden" name="page" value="${currentPage!= null? currentPage: 1}" />
                <input type="text" name="typeRoom" value="${search!= null? search: ""}" class="search-input"> 
                <input type="submit" value="Search" class="search-button"> 
            </form>
        </div>
        <div class="container">
            <c:forEach var="room" items="${list}">
                <div class="card">
                    <a href="roomDetails?roomID=${room.roomID}">
                        <img src="images/${room.roomID}/${room.roomID}.jpg" alt="Room Image">
                    </a>
                    <div class="card-content">
                        <h5>${room.roomName}</h5>
                        <p>Type room: ${room.typeName}</p>
                        <p class="price">Price:
                            <fmt:formatNumber value="${room.price}" pattern="#,##0" /> VNĐ
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="./roomList?page=${currentPage - 1}&typeRoom=${search}" class="prev">Prev</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="./roomList?page=${i}&typeRoom=${search}" <c:if test="${currentPage == i}">class="active"</c:if>>${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="./roomList?page=${currentPage + 1}&typeRoom=${search}" class="next">Next</a>
            </c:if>
        </div>


    </body>
</html>