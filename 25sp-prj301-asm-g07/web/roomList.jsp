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
        <!--icon cây chổi-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=refresh" />
        <script>
            function resetForm() {
                window.location.href = "./roomList?action=list";
            }
        </script>
    </head>
    <body>
        <%@include file="/navbar.jsp"%>
        <div class="search-container">
            <div class="date-selection">
                <input type="date" name="dateIn" value="${dateIn}">
                <input type="date" name="dateOut" value="${dateOut}">
            </div>

            <form action="./roomList" class="search-form">
                <input type="text" name="keyword" placeholder="Search..."  value="${keyword}">

                <select name="type">
                    <option value="">Room Type</option>
                    <option value="DELUXE KING" ${type == 'DELUXE KING' ? 'selected' : ''}>DELUXE KING</option>
                    <option value="DELUXE DOUBLE" ${type == 'DELUXE DOUBLE' ? 'selected' : ''}>DELUXE DOUBLE</option>
                    <option value="PREMIER KING" ${type == 'PREMIER KING' ? 'selected' : ''}>PREMIER KING</option>
                    <option value="JUNIOR SUITE" ${type == 'JUNIOR SUITE' ? 'selected' : ''}>JUNIOR SUITE</option>
                    <option value="DELUXE ONE BEDROOM SUITE" ${type == 'DELUXE ONE BEDROOM SUITE' ? 'selected' : ''}>DELUXE ONE BEDROOM SUITE</option>
                    <option value="PREMIER ONE BEDROOM SUITE" ${type == 'PREMIER ONE BEDROOM SUITE' ? 'selected' : ''}>PREMIER ONE BEDROOM SUITE</option>
                    <option value="TWO BEDROOM SUITE" ${type == 'TWO BEDROOM SUITE' ? 'selected' : ''}>TWO BEDROOM SUITE</option>
                    <option value="THD PENTHOUSE SUITE" ${type == 'THD PENTHOUSE SUITE' ? 'selected' : ''}>THD PENTHOUSE SUITE</option>
                    <option value="ONE BEDROOM SUITE" ${type == 'ONE BEDROOM SUITE' ? 'selected' : ''}>ONE BEDROOM SUITE</option>
                </select>
                <select name="view">
                    <option value="">View Details</option>
                    <option value="City view" ${view == 'City view' ? 'selected' : ''}>City view</option>
                    <option value="River view" ${view == 'River view' ? 'selected' : ''}>River view</option>
                    <option value="Skyline view" ${view == 'Skyline view' ? 'selected' : ''}>Skyline view</option>
                </select>

                <input type="hidden" name="page" value="${currentPage != null ? currentPage : 1}" />
                <input type="hidden" name="action" value="list"/>
                <input type="submit" value="Search" class="search-button">

                <button type="button" onclick="resetForm()" class="reset-button">
                    <span class="material-symbols-outlined">
                        refresh
                    </span>
                </button>
            </form>
        </div>

        <div class="room-list-container">
            <c:forEach var="room" items="${list}">
                <div class="room-card">
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
                <a href="./roomList?page=${currentPage - 1}&dateIn=${dateIn}&dateOut=${dateOut}&keyword=${keyword}&type=${type}&view=${view}" class="prev">Prev</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="./roomList?page=${i}&dateIn=${dateIn}&dateOut=${dateOut}&keyword=${keyword}&type=${type}&view=${view}" 
                   <c:if test="${currentPage == i}">class="active"</c:if>>${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="./roomList?page=${currentPage + 1}&dateIn=${dateIn}&dateOut=${dateOut}&keyword=${keyword}&type=${type}&view=${view}" class="next">Next</a>
            </c:if>
        </div>

    </body>

</html>
