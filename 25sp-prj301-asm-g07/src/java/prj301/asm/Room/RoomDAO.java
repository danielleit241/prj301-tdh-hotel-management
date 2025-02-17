/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301.asm.Room;

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

    public List<RoomDTO> getAllRooms() {
        List<RoomDTO> rooms = new ArrayList<>();
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
        try (Connection conn = DBUtils.getConnection()) {
            String query = " SELECT * FROM rooms ";
            PreparedStatement stmt = conn.prepareStatement(query);
=======
>>>>>>> Stashed changes
        String sql = "SELECT * FROM rooms";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
<<<<<<< Updated upstream
=======
>>>>>>> f7529ab4d775dd154231fc216d4d3d9688bb4f2d
>>>>>>> Stashed changes
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
}
