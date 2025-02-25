/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import prj301asm.utils.DBUtils;

/**
 *
 * @author DUNGHUYNH
 */
public class UserDAO {
    
    public boolean createAccount(String username, String password, String name){
        String sql = " insert into users(username, password, name) values (?, ?, ?) ";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, username);
            sttm.setString(2, password);
            sttm.setString(3, name);
            int row = sttm.executeUpdate();
            if(row != 0){
                return true;
            }
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public UserDTO checkUsername(String username){
        UserDTO user = null;
        String sql = " select username from users where username = ? ";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, username);
            ResultSet rs = sttm.executeQuery();
            if(rs != null){
                if(rs.next()){
                    user = new UserDTO();
                    user.setUsername(rs.getString("username"));
                    return user;
                }
            }
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }

    public UserDTO login(String username, String password) {

        UserDTO user = null;
        try {

            Connection con = DBUtils.getConnection();
            String sql = " SELECT name, role ,username FROM users ";
            sql += " WHERE username = ?  AND password = ?";

            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs != null) {
                if (rs.next()) {

                    user = new UserDTO();
                    user.setName(rs.getString("name"));
                    user.setRole(rs.getString("role"));
                    user.setUsername(rs.getString("username"));
                    
                }
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
        return user;

    }

}
