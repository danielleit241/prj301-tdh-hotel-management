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

    public List<BookingDTO> getListUserBooking(String username) {
        List<BookingDTO> userBooked = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE username = ?";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingDTO booking = new BookingDTO();
                    booking.setBookingID(rs.getString("bookingID"));
                    booking.setUsername(rs.getString("username"));
                    booking.setRoomID(rs.getInt("roomID"));
                    booking.setCheckInDate(rs.getDate("checkInDate"));
                    booking.setCheckOutDate(rs.getDate("checkOutDate"));
                    booking.setTotalPrice(rs.getInt("totalPrice"));
                    userBooked.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userBooked;
    }

    public Integer findAvailableRoomID(int typeRoomID, Date dateIn, Date dateOut) {
        Integer roomIDExist = null;
        String sql = "SELECT TOP 1 r.roomID "
                + "FROM rooms r INNER JOIN typeRoom t "
                + "	ON t.typeRoomID = r.typeRoomID "
                + "WHERE r.typeRoomID = ? "
                + "AND r.roomID NOT IN ( "
                + "    SELECT DISTINCT b.roomID "
                + "    FROM bookings b "
                + "    WHERE NOT( "
                + "        b.checkOutDate <= ? "
                + "        OR b.checkInDate >= ? "
                + "    )"
                + ") ORDER BY r.roomID ";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, typeRoomID);
            ps.setDate(2, dateIn);
            ps.setDate(3, dateOut);

            ResultSet rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                roomIDExist = rs.getInt("roomID");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roomIDExist;
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
        String sql = " SELECT \n "
                + "    b.bookingID,\n "
                + "    r.roomID,\n "
                + "    r.roomName,\n "
                + "    r.typeName,\n "
                + "    b.totalPrice,\n "
                + "    r.description,\n "
                + "    b.phone,\n "
                + "    u.name AS BookedBy,\n "
                + "    b.checkInDate,\n "
                + "    b.checkOutDate,\n "
                + "    CASE \n"
                + "    WHEN b.bookingID IS NOT NULL THEN N'đang đặt (chưa thanh toán)'\n "
                + "    ELSE N'chưa đặt'\n"
                + "	END AS status\n"
                + " FROM Rooms r\n "
                + " LEFT JOIN bookings b ON r.RoomID = b.RoomID\n "
                + " LEFT JOIN users u ON b.username = u.username; ";

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
                    roomBooking.setTotalPrice(rs.getInt("totalPrice"));
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

    public boolean addBooking(BookingDTO booking) {
        String sql = "INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, totalPrice) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, booking.getBookingID());
            stmt.setString(2, booking.getUsername());
            stmt.setInt(3, booking.getRoomID());
            stmt.setString(4, booking.getPhone());
            stmt.setDate(5, booking.getCheckInDate());
            stmt.setDate(6, booking.getCheckOutDate());
            stmt.setInt(7, booking.getTotalPrice());
            if (stmt.executeUpdate() > 0) {
                return true;
            }
            conn.close();
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
