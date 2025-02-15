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
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT * FROM rooms";
            PreparedStatement stmt = conn.prepareStatement(query);
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public boolean addRoom(String roomID, String romeName, String typeName, BigDecimal price, String description) {
        try (Connection con = DBUtils.getConnection()) {
            String query = "INSERT INTO rooms (roomID, romeName, typeName, price, description) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomID);
            stmt.setString(2, romeName);
            stmt.setString(3, typeName);
            stmt.setBigDecimal(4, price);
            stmt.setString(5, description);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRoom(String roomID, String romeName, String typeName, BigDecimal price, String description) {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "UPDATE rooms SET roomID = ?, romeName = ?, typeName = ?, price = ?, description = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, roomID);
            stmt.setString(2, romeName);
            stmt.setString(3, typeName);
            stmt.setBigDecimal(4, price);
            stmt.setString(5, description);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteRoom(String roomID) {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "DELETE FROM rooms WHERE roomID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, roomID);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
