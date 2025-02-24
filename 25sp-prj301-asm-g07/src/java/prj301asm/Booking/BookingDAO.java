/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Booking;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import prj301asm.utils.DBUtils;

/**
 *
 * @author ACER
 */
public class BookingDAO {

    public List<BookingDTO> getAllRoomBookings() {
        List<BookingDTO> list = new ArrayList<>();
        String sql = "SELECT b.bookingID,\n"
                + "       r.roomID,\n"
                + "       r.roomName,\n"
                + "       r.typeName,\n"
                + "       r.price,\n"
                + "       r.description,\n"
                + "       b.phone,\n"
                + "       u.name AS BookedBy,\n"
                + "       b.checkInDate,\n"
                + "       b.checkOutDate,\n"
                + "       CASE \n"
                + "           WHEN b.checkInDate IS NULL OR b.checkOutDate IS NULL \n"
                + "                OR CAST(GETDATE() AS DATE) < b.checkInDate \n"
                + "                THEN N'chưa đặt'\n"
                + "           WHEN CAST(GETDATE() AS DATE) BETWEEN b.checkInDate AND b.checkOutDate \n"
                + "                THEN N'đang đặt'\n"
                + "           WHEN CAST(GETDATE() AS DATE) > b.checkOutDate \n"
                + "                THEN N'đã đặt'\n"
                + "       END AS status \n" // Changed to 'status'
                + "FROM Rooms r\n"
                + "LEFT JOIN bookings b ON r.RoomID = b.RoomID\n"
                + "LEFT JOIN users u ON b.username = u.username;";

        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    BookingDTO roomBooking = new BookingDTO();

                    roomBooking.setBookingID(rs.getString("bookingID"));
                    roomBooking.setRoomID(rs.getInt("roomID"));
                    roomBooking.setRoomName(rs.getString("roomName"));
                    roomBooking.setTypeName(rs.getString("typeName"));
                    roomBooking.setTotalPrice(rs.getBigDecimal("price"));
                    roomBooking.setDescription(rs.getString("description"));
                    roomBooking.setPhone(rs.getString("phone"));
                    roomBooking.setBookedBy(rs.getString("BookedBy"));
                    roomBooking.setCheckInDate(rs.getDate("checkInDate"));
                    roomBooking.setCheckOutDate(rs.getDate("checkOutDate"));
                    roomBooking.setStatus(rs.getString("status")); // Now matches the query

                    list.add(roomBooking);
                }
            }
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean addBooking(String bookingID, String username, int roomID, String phone, Date checkInDate, Date checkOutDate, double totalPrice) {
//        long days = (checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24);
//        double totalPrice = days * price;
        String sql = " INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, totalPrice) VALUES (?, ?, ?, ?, ?, ?, ?) ";
        try {
            Connection conn = DBUtils.getConnection();

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookingID);
            stmt.setString(2, username);
            stmt.setInt(3, roomID);
            stmt.setString(4, phone);
            stmt.setDate(5, checkInDate);
            stmt.setDate(6, checkOutDate);
            stmt.setDouble(7, totalPrice);
            //...
            if (stmt.executeUpdate() > 0) {
                return true;
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateBooking(String bookingID, String phone, Date checkInDate, Date checkOutDate, String status, double totalPrice) {
//        long days = (checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24);
//        double totalPrice = days * price;
        try {
            Connection conn = DBUtils.getConnection();
            String updateSql = " UPDATE bookings SET phone = ?, checkInDate = ?, checkOutDate = ?, status = ?, totalPrice = ? WHERE bookingID = ? ";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, phone);
            updateStmt.setDate(2, checkInDate);
            updateStmt.setDate(3, checkOutDate);
            updateStmt.setString(4, status);
            updateStmt.setDouble(5, totalPrice);
            updateStmt.setString(6, bookingID);
            if (updateStmt.executeUpdate() > 0) {
                return true;
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean deleteBooking(String bookingID) {
        try {
            Connection conn = DBUtils.getConnection();
            String deleteSql = " DELETE FROM bookings WHERE bookingID = ? ";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
            deleteStmt.setString(1, bookingID);
            deleteStmt.executeUpdate();
            if (deleteStmt.executeUpdate() > 0) {
                return true;
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
}
