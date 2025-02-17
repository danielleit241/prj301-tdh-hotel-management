/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301.asm.Booking;

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
    public List<BookingDTO> getAllBookings() {
        List<BookingDTO> bookings = new ArrayList<>();
        try{ 
            Connection conn = DBUtils.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String bookingID = rs.getString("bookingID");
                String phone = rs.getString("phone");
                Date checkInDate = rs.getDate("checkInDate");
                Date checkOutDate = rs.getDate("checkOutDate");
                double totalPrice = rs.getDouble("total_price");
                BookingDTO booking = new BookingDTO(bookingID, phone, checkInDate, checkOutDate, totalPrice);
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    public void addBooking(String bookingID, String phone, Date checkInDate, Date checkOutDate, double price) {
        long days = (checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24);
        double totalPrice = days * price;               
        try{ 
            Connection conn = DBUtils.getConnection();
            String sql = "INSERT INTO booking (bookingID, phone, checkInDate, checkOutDate, totalPrice) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookingID);
            stmt.setString(2, phone);
            stmt.setDate(3, checkInDate);
            stmt.setDate(4, checkOutDate);
            stmt.setDouble(5, totalPrice);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateBooking(int bookingID, String phone, Date checkInDate, Date checkOutDate, double price) {
        long days = (checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 * 24);
        double totalPrice = days * price;                      
        try{ 
            Connection conn = DBUtils.getConnection(); 
            String updateSql = "UPDATE bookings SET phone = ?, checkInDate = ?, checkOutDate = ?, totalPrice = ? WHERE bookingID = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, phone);
            updateStmt.setDate(2, checkInDate);
            updateStmt.setDate(3, checkOutDate);
            updateStmt.setDouble(4, totalPrice);
            updateStmt.setInt(5, bookingID);
            updateStmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBooking(int bookingID) {
        try {
            Connection conn = DBUtils.getConnection(); 
            String deleteSql = "DELETE FROM bookings WHERE bookingID = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
            deleteStmt.setInt(1, bookingID);
            deleteStmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
