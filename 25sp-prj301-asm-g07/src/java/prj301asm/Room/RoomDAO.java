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

    public List<RoomDTO> getListPaging(int page, int pageSize, String keyword, String type, String view, Date desiredCheckIn, Date desiredCheckOut) {
        List<RoomDTO> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "SELECT DISTINCT tr.* "
                + "FROM rooms r "
                + "JOIN typeRoom tr ON r.typeRoomID = tr.typeRoomID "
                + "WHERE NOT EXISTS ( "
                + "    SELECT 1 "
                + "    FROM bookings b "
                + "    WHERE b.roomID = r.roomID "
                + "    AND b.status IN ('confirmed', 'pending') "
                + "    AND (? <= b.checkOutDate) "
                + "    AND (? >= b.checkInDate) "
                + ") ";

        if (keyword != null) {
            sql += " AND tr.typeDes LIKE ? ";
        }

        if (type != null && !type.trim().isEmpty()) {
            sql += " AND tr.typeName = ? ";
        }

        if (view != null && !view.trim().isEmpty()) {
            sql += " AND tr.viewDetail = ? ";
        }

        sql += " ORDER BY tr.typeRoomID "
                + " OFFSET ? ROWS "
                + " FETCH NEXT ? ROWS ONLY;";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, desiredCheckIn);
            ps.setDate(2, desiredCheckOut);

            int parameterIndex = 3;
            if (keyword != null) {
                ps.setString(parameterIndex++, "%" + keyword + "%");
            }

            if (type != null && !type.trim().isEmpty()) {
                ps.setString(parameterIndex++, type);
            }

            if (view != null && !view.trim().isEmpty()) {
                ps.setString(parameterIndex++, view);
            }

            ps.setInt(parameterIndex++, offset);
            ps.setInt(parameterIndex, pageSize);

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

    public int countRooms(Date dateIn, Date dateOut, String keyword, String type, String view) {
        String sql = "SELECT COUNT(DISTINCT tr.typeRoomID) AS countType "
                + "FROM rooms r "
                + "JOIN typeRoom tr ON r.typeRoomID = tr.typeRoomID "
                + "WHERE NOT EXISTS ( "
                + "    SELECT 1 "
                + "    FROM bookings b "
                + "    WHERE b.roomID = r.roomID "
                + "    AND b.status IN ('confirmed', 'pending') "
                + "    AND (? <= b.checkOutDate) "
                + "    AND (? >= b.checkInDate) "
                + ") ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND tr.typeDes LIKE ? ";
        }

        if (type != null && !type.trim().isEmpty()) {
            sql += " AND tr.typeName = ? ";
        }

        if (view != null && !view.trim().isEmpty()) {
            sql += " AND tr.viewDetail = ? ";
        }

        int count = 0;
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDate(1, dateIn);
            stmt.setDate(2, dateOut);

            int parameterIndex = 3;
            if (keyword != null && !keyword.trim().isEmpty()) {
                stmt.setString(parameterIndex++, "%" + keyword + "%");
            }

            if (type != null && !type.trim().isEmpty()) {
                stmt.setString(parameterIndex++, type);
            }

            if (view != null && !view.trim().isEmpty()) {
                stmt.setString(parameterIndex++, view);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("countType");
                }
            }
        } catch (SQLException e) {
            System.out.println("SQLException in countRooms: " + e.getMessage());
        }
        return count;
    }

    public RoomDTO updateRoom(RoomDTO room) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);

            String sql = "UPDATE typeRoom "
                    + "SET price = ?, roomSize = ?, bedSize = ?, maxOccupancy = ?, viewDetail = ?, bathroom = ?, smoking = ? "
                    + "WHERE typeRoomID = ? ";
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

    public RoomDTO getTypeDetails(int typeRoomID) {
        RoomDTO typeRoom = null;

        String sql = "SELECT "
                + "   tr.* "
                + "FROM "
                + "    typeRoom tr "
                + "WHERE "
                + "    tr.typeRoomID = ? ";
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
        String sql = " SELECT "
                + "    tr.* "
                + "FROM "
                + "    typeRoom tr ";
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
}
