<%-- 
    Document   : roomEdit
    Created on : Feb 24, 2025, 6:50:10 PM
    Author     : TRAN PHU THINH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1> ROOM EDIT</h1>
        <form action = "manageRooms" method="GET">
            <table>
                <tr>
                    <td>
                        Room ID
                    </td>
                    <td>
                        <input name="roomID" value="${requestScope.room.roomID}">
                    </td>
                </tr>

                <tr>
                    <td>
                        Room Name
                    </td>
                    <td>
                        <input name="roomName" value="${requestScope.room.roomName}" type="text">
                    </td>
                </tr>
                <tr>
                    <td>
                        Type Name
                    </td>
                    <td>
                        <input name="typeName" value="${requestScope.room.typeName}" type="text">
                    </td>
                </tr>
                <tr>
                    <td>
                        Price
                    </td>
                    <td>
                        <input name="price" value="${requestScope.room.price}" type="text">
                    </td>
                </tr>


                <tr>
                    <td>
                        Description
                    </td>
                    <td>
                        <input name="description" value="${requestScope.room.description}" type="text">
                    </td>
                </tr>
                <p>${error}</p>
                <tr><td colspan="2">
                        <input name="action" value="update" type="hidden">                 
                        <input type="Submit" value="Save">
                    </td></tr>
            </table>  

        </form>


    </body>
</html>
