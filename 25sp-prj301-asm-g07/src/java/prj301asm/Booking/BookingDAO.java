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

    public boolean isBooked(int roomID, Date CheckIn, Date CheckOut) {

        boolean booked = false;
        
        String sql = "SELECT COUNT(*) FROM bookings "
                + "WHERE roomID = ? "
                + "AND checkInDate <= ? "
                + "AND checkoutdate >= ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, roomID);
            ps.setDate(2, CheckIn);
            ps.setDate(3, CheckOut);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    booked = true;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return booked;
    }

    public String getMaxBookingId() {
        String sql = "SELECT MAX(bookingID) as maxID FROM bookings";
        String maxBookingID = null;
        try (Connection con = DBUtils.getConnection();
                PreparedStatement stmt = con.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                maxBookingID = rs.getString("maxID");
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maxBookingID;
    }

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
                    roomBooking.setTotalPrice(rs.getInt("price"));
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

    public boolean addBooking(String bookingID, String username, int roomID, String phone, 
                            String checkIn, String checkOut, int totalPrice) {
    String sql = "INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, totalPrice) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?)";
    try (Connection conn = DBUtils.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
         
         stmt.setString(1, bookingID);
         stmt.setString(2, username);
         stmt.setInt(3, roomID);
         stmt.setString(4, phone);
         stmt.setString(5, checkIn);
         stmt.setString(6, checkOut);
         stmt.setInt(7, totalPrice);
         
         int rowsAffected = stmt.executeUpdate();
         return rowsAffected > 0;
    } catch (SQLException e) {
         e.printStackTrace();
    }
    return false;
}


    public boolean updateBooking(String bookingID, String phone, Date checkInDate, Date checkOutDate, String status, int totalPrice) {
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
            updateStmt.setInt(5, totalPrice);
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
