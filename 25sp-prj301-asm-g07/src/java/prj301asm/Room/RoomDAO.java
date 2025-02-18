/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Room;

import java.math.BigDecimal;
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
public class RoomDAO {

    public List<RoomDTO> getRoomsByPage(int page, int pageSize) {
        List<RoomDTO> list = new ArrayList<RoomDTO>();
        int offSet = (page - 1) * pageSize;

        String sql = " SELECT * FROM Rooms ORDER BY roomID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, offSet);
            sttm.setInt(2, pageSize);
            ResultSet rs = sttm.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    int id = rs.getInt("roomID");
                    String romeName = rs.getString("romeName");
                    String description = rs.getString("description");
                    BigDecimal price = rs.getBigDecimal("price");
                    String typeName = rs.getString("typeName");
                    RoomDTO room = new RoomDTO(id, romeName, typeName, price, description);
                    list.add(room);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<RoomDTO> getAllRooms() {
        List<RoomDTO> rooms = new ArrayList<>();

        String sql = "SELECT * FROM rooms";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("roomID");
                String romeName = rs.getString("romeName");
                String description = rs.getString("description");
                BigDecimal price = rs.getBigDecimal("price");
                String typeName = rs.getString("typeName");
                RoomDTO room = new RoomDTO(id, romeName, typeName, price, description);
                rooms.add(room);
            }
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return rooms;
    }

    public boolean addRoom(String roomID, String romeName, String typeName, BigDecimal price, String description) {
        String sql = "INSERT INTO rooms (roomID, romeName, typeName, price, description) VALUES (?, ?, ?, ?, ?)";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, roomID);
            stmt.setString(2, romeName);
            stmt.setString(3, typeName);
            stmt.setBigDecimal(4, price);
            stmt.setString(5, description);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateRoom(String roomID, String romeName, String typeName, BigDecimal price, String description) {
        String sql = "UPDATE rooms SET roomID = ?, romeName = ?, typeName = ?, price = ?, description = ? WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomID);
            stmt.setString(2, romeName);
            stmt.setString(3, typeName);
            stmt.setBigDecimal(4, price);
            stmt.setString(5, description);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteRoom(String roomID) {
        String sql = "DELETE FROM rooms WHERE roomID = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomID);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public RoomDTO getRoomByID(int roomID) {
        RoomDTO room = new RoomDTO();

        String sql = " SELECT * FROM rooms WHERE roomID = ? ";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, roomID);

            ResultSet rs = stmt.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int id = rs.getInt("roomID");
                    String romeName = rs.getString("romeName");
                    String description = rs.getString("description");
                    BigDecimal price = rs.getBigDecimal("price");
                    String typeName = rs.getString("typeName");
                    
                    room = new RoomDTO(id, romeName, typeName, price, description);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
            e.printStackTrace();
        }
        return room;
    }
}
