/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Room;

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
public class RoomDAO {

    public List<RoomDTO> getListPaging(int page, int pageSize, String keyword, Date desiredCheckIn, Date desiredCheckOut) {
        List<RoomDTO> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "SELECT DISTINCT tr.typeName, tr.typeDes, trd.* "
                + "FROM rooms r "
                + "JOIN typeRoomDetails trd ON r.typeRoomID = trd.typeRoomID "
                + "JOIN typeRoom tr ON r.typeRoomID = tr.typeRoomID "
                + "WHERE NOT EXISTS ( "
                + "    SELECT 1 "
                + "    FROM bookings b "
                + "    WHERE b.roomID = r.roomID "
                + "      AND b.status IN ('confirmed', 'pending') "
                + "      AND (? <= b.checkOutDate) "
                + "      AND (? >= b.checkInDate) "
                + ") ";

        if (keyword != null) {
            sql += "AND ( "
                    + "    tr.typeName LIKE ? "
                    + " OR trd.bedSize LIKE ? "
                    + " OR trd.maxOccupancy LIKE ? "
                    + " OR trd.viewDetail LIKE ? "
                    + " OR trd.bathroom LIKE ? "
                    + ") ";
        }

        sql += "ORDER BY trd.typeRoomID "
                + "OFFSET ? ROWS "
                + "FETCH NEXT ? ROWS ONLY;";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, desiredCheckIn);
            ps.setDate(2, desiredCheckOut);

            if (keyword != null) {
                String pattern = "%" + keyword + "%";
                for (int i = 3; i <= 7; i++) {
                    ps.setString(i, pattern);
                }
                ps.setInt(8, offset);
                ps.setInt(9, pageSize);
            } else {
                ps.setInt(3, offset);
                ps.setInt(4, pageSize);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RoomDTO room = new RoomDTO();
                    room.setTypeRoomID(rs.getInt("typeRoomID"));
                    room.setTypeName(rs.getString("typeName"));
                    room.setTypeDes(rs.getString("typeDes"));
                    room.setPrice(rs.getInt("price"));
                    room.setRoomSize(rs.getString("roomSize"));
                    room.setBedSize(rs.getString("bedSize"));
                    room.setMaxOccupancy(rs.getString("maxOccupancy"));
                    room.setViewDetail(rs.getString("viewDetail"));
                    room.setBathroom(rs.getString("bathroom"));
                    room.setSmoking(rs.getString("smoking"));
                    list.add(room);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

//    public boolean addRoom(int roomID, String roomName, String typeName, int price, String description) {
//        String sql = "INSERT INTO rooms (roomID, roomName, typeName, price, description) VALUES (?, ?, ?, ?, ?)";
//        try {
//            Connection con = DBUtils.getConnection();
//            PreparedStatement stmt = con.prepareStatement(sql);
//            stmt.setInt(1, roomID);
//            stmt.setString(2, roomName);
//            stmt.setString(3, typeName);
//            stmt.setInt(4, price);
//            stmt.setString(5, description);
//            if (stmt.executeUpdate() > 0) {
//                return true;
//            }
//            con.close();
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return false;
//    }
    public RoomDTO updateRoom(RoomDTO room) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false); 

            String sql = "UPDATE typeRoomDetails "
                    + "SET price = ?, roomSize = ?, bedSize = ?, maxOccupancy = ?, viewDetail = ?, bathroom = ?, smoking = ? "
                    + "WHERE typeRoomID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, room.getPrice());
            ps.setString(2, room.getRoomSize());
            ps.setString(3, room.getBedSize());
            ps.setString(4, room.getMaxOccupancy());
            ps.setString(5, room.getViewDetail());
            ps.setString(6, room.getBathroom());
            ps.setString(7, room.getSmoking());
            ps.setInt(8, room.getTypeRoomID());

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {

                sql = "UPDATE typeRoom SET typeName = ?, typeDes = ? WHERE typeRoomID = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, room.getTypeName());
                ps.setString(2, room.getTypeDes());
                ps.setInt(3, room.getTypeRoomID());
                ps.executeUpdate();

                conn.commit();
                return room; 
            } else {
                conn.rollback(); 
            }

        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback(); 
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return null; // Trả về null nếu cập nhật thất bại
    }
//
//    public boolean deleteRoom(String roomID) {
//        String sql = "DELETE FROM rooms WHERE roomID = ?";
//        try {
//            Connection conn = DBUtils.getConnection();
//            PreparedStatement stmt = conn.prepareStatement(sql);
//            stmt.setString(1, roomID);
//            if (stmt.executeUpdate() > 0) {
//                return true;
//            }
//            conn.close();
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return false;
//    }
//

    public RoomDTO getTypeDetails(int typeRoomID) {
        RoomDTO typeRoom = null;

        String sql = "SELECT "
                + "    tr.typeRoomID, "
                + "    tr.typeName, "
                + "    tr.typeDes, "
                + "    trd.price, "
                + "    trd.roomSize, "
                + "    trd.bedSize, "
                + "    trd.maxOccupancy, "
                + "    trd.viewDetail, "
                + "    trd.bathroom, "
                + "    trd.smoking "
                + "FROM "
                + "    typeRoom tr "
                + "JOIN "
                + "    typeRoomDetails trd ON tr.typeRoomID = trd.typeRoomID "
                + "WHERE "
                + "    tr.typeRoomID = ?;";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, typeRoomID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    typeRoom = new RoomDTO();
                    typeRoom.setTypeRoomID(rs.getInt("typeRoomID"));
                    typeRoom.setTypeName(rs.getString("typeName"));
                    typeRoom.setTypeDes(rs.getString("typeDes"));
                    typeRoom.setPrice(rs.getInt("price"));
                    typeRoom.setRoomSize(rs.getString("roomSize"));
                    typeRoom.setBedSize(rs.getString("bedSize"));
                    typeRoom.setMaxOccupancy(rs.getString("maxOccupancy"));
                    typeRoom.setViewDetail(rs.getString("viewDetail"));
                    typeRoom.setBathroom(rs.getString("bathroom"));
                    typeRoom.setSmoking(rs.getString("smoking"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return typeRoom;
    }

    public List<RoomDTO> getAllRoom() {
        List<RoomDTO> list = new ArrayList<>();
        String sql = " 	SELECT\n"
                + "    tr.typeRoomID,\n"
                + "    tr.typeName,\n"
                + "    tr.typeDes,\n"
                + "    trd.price AS price,\n"
                + "    trd.roomSize AS roomSize,\n"
                + "    trd.bedSize AS bedSize,\n"
                + "    trd.maxOccupancy AS maxOccupancy,\n"
                + "    trd.viewDetail AS viewDetail,\n"
                + "    trd.bathroom AS bathroom,\n"
                + "    trd.smoking AS smoking\n"
                + "FROM\n"
                + "    typeRoom tr\n"
                + "JOIN\n"
                + "    typeRoomDetails trd ON tr.typeRoomID = trd.typeRoomID; ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    RoomDTO room = new RoomDTO();
                    room.setTypeRoomID(rs.getInt("typeRoomID"));
                    room.setTypeName(rs.getString("typeName"));
                    room.setTypeDes(rs.getString("typeDes"));
                    room.setPrice(rs.getInt("price"));
                    room.setRoomSize(rs.getString("roomSize"));
                    room.setBedSize(rs.getString("bedSize"));
                    room.setMaxOccupancy(rs.getString("maxOccupancy"));
                    room.setViewDetail(rs.getString("viewDetail"));
                    room.setBathroom(rs.getString("bathroom"));
                    room.setSmoking(rs.getString("smoking"));

                    list.add(room);
                }
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
            e.printStackTrace();
        }
        return list;
    }

    public int countRooms(Date dateIn, Date dateOut) {
        String sql = "SELECT COUNT(DISTINCT tr.typeRoomID) AS countType "
                + "FROM rooms r "
                + "JOIN typeRoomDetails trd ON r.typeRoomID = trd.typeRoomID "
                + "JOIN typeRoom tr ON r.typeRoomID = tr.typeRoomID "
                + "WHERE NOT EXISTS ( "
                + "      SELECT 1 "
                + "      FROM bookings b "
                + "      WHERE b.roomID = r.roomID "
                + "        AND b.status IN ('confirmed', 'pending') "
                + "        AND (? <= b.checkOutDate) "
                + "        AND (? >= b.checkInDate) "
                + ") ";
        int count = 0;
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setDate(1, dateIn);
            sttm.setDate(2, dateOut);
            ResultSet rs = sttm.executeQuery();
            if (rs != null && rs.next()) {
                count = rs.getInt("countType");
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("SQLException in countRoomsByTypeRoom: " + e.getMessage());
        }
        return count;
    }

}
