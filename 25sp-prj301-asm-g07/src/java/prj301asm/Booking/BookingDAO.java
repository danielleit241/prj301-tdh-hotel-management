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

    
}
