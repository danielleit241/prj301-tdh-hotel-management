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
 * @author Phu Thinh
 */
public class BookingDAO {

    public List<BookingDTO> getAllBookings() {
        List<BookingDTO> bookings = new ArrayList<>();
        String sql = " SELECT * FROM bookings ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    String bookingID = rs.getString("bookingID");
                    String phone = rs.getString("phone");
                    Date checkInDate = rs.getDate("checkInDate");
                    Date checkOutDate = rs.getDate("checkOutDate");
                    String status = rs.getString("status");
                    double totalPrice = rs.getDouble("totalPrice");
                    //...
                    BookingDTO booking = new BookingDTO(bookingID, phone, checkInDate, checkOutDate, status, totalPrice);
                    bookings.add(booking);
                }
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return bookings;
    }

    public boolean addBooking(String bookingID, String phone, Date checkInDate, Date checkOutDate, double totalPrice) {
//        long days = (checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24);
//        double totalPrice = days * price;
        String sql = " INSERT INTO bookings (bookingID, phone, checkInDate, checkOutDate, totalPrice) VALUES (?, ?, ?, ?, ?) ";
        try {
            Connection conn = DBUtils.getConnection();

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookingID);
            stmt.setString(2, phone);
            stmt.setDate(3, checkInDate);
            stmt.setDate(4, checkOutDate);
            stmt.setDouble(5, totalPrice);
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
