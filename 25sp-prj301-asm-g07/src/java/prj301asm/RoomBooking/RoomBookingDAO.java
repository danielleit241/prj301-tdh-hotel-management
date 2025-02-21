/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.RoomBooking;

import java.sql.Connection;
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
public class RoomBookingDAO {

    public List<RoomBookingDTO> getAllRoomBookings() {
        List<RoomBookingDTO> list = new ArrayList<>();
        String sql = "SELECT b.bookingID,\n"
                + "       r.RoomID,\n"
                + "       r.romeName,\n"
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
                    RoomBookingDTO roomBooking = new RoomBookingDTO();

                    roomBooking.setBookingID(rs.getString("bookingID"));
                    roomBooking.setRoomID(rs.getInt("RoomID"));
                    roomBooking.setRomeName(rs.getString("romeName"));
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
        } catch (SQLException e) {
            System.out.println(e);
            e.printStackTrace();
        }
        return list;
    }
}
