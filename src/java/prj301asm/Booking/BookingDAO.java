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
import prj301asm.Room.RoomDTO;
import prj301asm.utils.DBUtils;

/**
 *
 * @author ACER
 */
public class BookingDAO {

    public List<BookingDTO> getUserBooking(String username) {
        List<BookingDTO> userBooked = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE username = ? order by bookingID DESC";
        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingDTO booking = new BookingDTO();
                    booking.setBookingID(rs.getString("bookingID"));
                    booking.setUsername(rs.getString("username"));
                    booking.setRoomID(rs.getInt("roomID"));
                    booking.setTypeRoomID(rs.getInt("typeRoomID"));
                    booking.setCheckInDate(rs.getDate("checkInDate"));
                    booking.setCheckOutDate(rs.getDate("checkOutDate"));
                    booking.setTotalPrice(rs.getInt("totalPrice"));
                    booking.setStatus(rs.getString("status"));
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

    public List<RoomDTO> findAllAvailableRoom(int typeRoomID, Date dateIn, Date dateOut) {
        List<RoomDTO> list = new ArrayList<RoomDTO>();
        String sql = "SELECT r.roomID "
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

            while (rs.next()) {
                list.add(new RoomDTO(rs.getInt("roomID")));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
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

    public List<BookingDTO> getAdminBooking(String keyword) {
        List<BookingDTO> list = new ArrayList<>();
        String sql = " SELECT \n"
                + "    b.bookingID,\n"
                + "    b.username AS BookedBy,\n"
                + "    b.roomID,\n"
                + "	b.typeRoomID,\n"
                + "    r.typeName,\n"
                + "    b.totalPrice,\n"
                + "    b.phone,\n"
                + "    b.checkInDate,\n"
                + "    b.checkOutDate,\n"
                + "    CASE \n"
                + "        WHEN b.status = 'pending' THEN N'đang đặt (chưa thanh toán)' \n"
                + "        WHEN b.status = 'confirmed' THEN N'đã xác nhận' \n"
                + "        ELSE N'chưa đặt' \n"
                + "    END AS status \n"
                + "FROM bookings b JOIN typeRoom r\n"
                + "ON b.typeRoomID = r.typeRoomID ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " WHERE b.bookingID LIKE ? "
                    + "OR b.username LIKE ? "
                    + "OR b.roomID LIKE ? "
                    + "OR r.typeName LIKE ? "
                    + "OR CONVERT(varchar, b.checkInDate, 23) LIKE ? "
                    + "OR CONVERT(varchar, b.checkOutDate, 23) LIKE ? "
                    + "OR CAST(b.totalPrice AS varchar) LIKE ? "
                    + "OR b.phone LIKE ?";
        }
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword.trim() + "%";
                stmt.setString(1, searchPattern); // bookingID
                stmt.setString(2, searchPattern); // username
                stmt.setString(3, searchPattern); // roomID
                stmt.setString(4, searchPattern); // typeName
                stmt.setString(5, searchPattern); // checkInDate (đã chuyển thành chuỗi)
                stmt.setString(6, searchPattern); // checkOutDate (đã chuyển thành chuỗi)
                stmt.setString(7, searchPattern); // totalPrice (đã chuyển thành chuỗi)
                stmt.setString(8, searchPattern); // phone
            }
            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    BookingDTO roomBooking = new BookingDTO();

                    roomBooking.setBookingID(rs.getString("bookingID"));
                    roomBooking.setRoomID(rs.getInt("roomID"));
                    roomBooking.setUsername(rs.getString("BookedBy"));
                    roomBooking.setTypeRoomID(rs.getInt("typeRoomID"));
                    roomBooking.setTypeRoomName(rs.getString("typeName"));
                    roomBooking.setTotalPrice(rs.getInt("totalPrice"));
                    roomBooking.setPhone(rs.getString("phone"));
                    roomBooking.setCheckInDate(rs.getDate("checkInDate"));
                    roomBooking.setCheckOutDate(rs.getDate("checkOutDate"));
                    roomBooking.setStatus(rs.getString("status"));

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

    public boolean confirmedBooking(String bookingID) {
        String sql = " update bookings set status = ? where bookingID = ? ";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "confirmed");
            ps.setString(2, bookingID);
            if (ps.executeUpdate() > 0) {
                return true;
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public BookingDTO load(String bookingID) {
        String sql = " select b.bookingID,\n"
                + "    b.username AS BookedBy,\n"
                + "    b.roomID,\n"
                + "    b.typeRoomID,\n"
                + "    b.totalPrice,\n"
                + "    b.phone,\n"
                + "    b.checkInDate,\n"
                + "    b.checkOutDate,"
                + "    b.status from bookings b where b.bookingID = ? ";
        BookingDTO booking = null;
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, bookingID);
            ResultSet rs = ps.executeQuery();
            if (rs != null && rs.next()) {
                booking = new BookingDTO();
                booking.setBookingID(rs.getString("bookingID"));
                booking.setUsername(rs.getString("BookedBy"));
                booking.setRoomID(rs.getInt("roomID"));
                booking.setTypeRoomID(rs.getInt("typeRoomID"));
                booking.setCheckInDate(rs.getDate("checkInDate"));
                booking.setCheckOutDate(rs.getDate("checkOutDate"));
                booking.setTotalPrice(rs.getInt("totalPrice"));
                booking.setPhone(rs.getString("phone"));
                booking.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return booking;
    }

    public boolean addBooking(BookingDTO booking) {
        String sql = "INSERT INTO bookings (bookingID, username, roomID, typeRoomID, phone, checkInDate, checkOutDate, totalPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, booking.getBookingID());
            stmt.setString(2, booking.getUsername());
            stmt.setInt(3, booking.getRoomID());
            stmt.setInt(4, booking.getTypeRoomID());
            stmt.setString(5, booking.getPhone());
            stmt.setDate(6, booking.getCheckInDate());
            stmt.setDate(7, booking.getCheckOutDate());
            stmt.setInt(8, booking.getTotalPrice());
            if (stmt.executeUpdate() > 0) {
                return true;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBooking(String bookingID, String phone, String status, int roomID) {
        try {
            Connection conn = DBUtils.getConnection();
            String updateSql = " UPDATE bookings SET phone = ?, status = ?, roomID = ? WHERE bookingID = ? ";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, phone);
            updateStmt.setString(2, status);
            updateStmt.setInt(3, roomID);
            updateStmt.setString(4, bookingID);
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
