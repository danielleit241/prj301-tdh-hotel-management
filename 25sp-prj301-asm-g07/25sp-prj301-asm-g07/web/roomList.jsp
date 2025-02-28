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
        <!-- Font Family -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <%@include file="/navbar.jsp"%>

        <div class="search-container"> 
            <form action="./roomList" class="search-form" style="gap: 50px">
                <input type="date" name="dateIn" value="${dateIn}">
                <input type="date" name="dateOut" value="${dateOut}">
                <input type="text" name="keyword" placeholder="Search..." value="${keyword}">
                <input type="hidden" name="page" value="${currentPage != null ? currentPage : 1}" />
                <input type="hidden" name="action" value="list" />
                <input type="submit" value="Search" class="search-button"> 
            </form>
        </div>

        <div class="container">
            <c:forEach var="room" items="${list}">
                <div class="card">
                    <img src="images/${room.typeRoomID}/${room.typeRoomID}.jpg" alt="Room Image">
                    <div class="card-content">
                        <h5>${room.typeName}</h5>
                        <p>${room.typeDes}</p>
                        <p>${room.roomSize}</p>
                        <p>${room.bedSize}</p>
                        <p>${room.maxOccupancy}</p>
                        <p>${room.viewDetail}</p>
                        <p>${room.bathroom}</p>
                        <p>${room.smoking}</p>

                        <p class="price">
                            Price: <fmt:formatNumber value="${room.price}" pattern="#,##0" /> VNĐ
                        </p>
                    </div>
                    <form action="roomList" method="get">
                        <lable>

                        </lable>
                        <input type="hidden" name="typeRoomID" value="${room.typeRoomID}">
                        <input type="hidden" name="dateIn" value="${dateIn}">
                        <input type="hidden" name="dateOut" value="${dateOut}">
                        <input type="hidden" name="action" value="details">
                        <input type="submit" value="BookNow!">
                    </form>
                </div>
            </c:forEach>

        </div>

        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="./roomList?page=${currentPage - 1}&keyword=${keyword}&dateIn=${dateIn}&dateOut=${dateOut}" class="prev">Prev</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="./roomList?page=${i}&keyword=${keyword}&dateIn=${dateIn}&dateOut=${dateOut}" 
                   <c:if test="${currentPage == i}">class="active"</c:if>>${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="./roomList?page=${currentPage + 1}&keyword=${keyword}&dateIn=${dateIn}&dateOut=${dateOut}" class="next">Next</a>
            </c:if>
        </div>

    </body>

</html>
