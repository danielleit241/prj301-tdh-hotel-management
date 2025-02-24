<%-- 
    Document   : booking
    Created on : Feb 23, 2025, 9:16:10 PM
    Author     : hoade
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="./booking">
            <p>BookingID: 123</p>
            <p>Booked by: ${sessionScope.user.name}</p>
            <p>
                <input type="number" name="phone">     
            </p>
            <p>Room name:
                ${sessionScope.room.roomName}
            </p>
            
            <p>Check In Date:
                <input type="date" name="checkindate"> 
            </p>
            <p>
                Check Out Date:
                <input type="date" name="checkoutdate"> 
            </p>
            <p>Total price:
                
            </p>
            <input type="hidden" name="action" value="payment"> 
            <p>
                <input type="submit" name="Payment">
            </p>
        </form>
    </body>
</html>
