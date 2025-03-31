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
import java.util.ArrayList;
import java.util.List;
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
            String sql = " SELECT name, role, username, status FROM users ";
            sql += " WHERE username = ?  AND password = ? ";

            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs != null) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setName(rs.getString("name"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
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
    
    public List<UserDTO> getAllUser(){
        List<UserDTO> getAllUser = new ArrayList<>();
        String sql = " SELECT * FROM users ";
        try{
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
               String username = rs.getString("username");
               String password = rs.getString("password");
               String status = rs.getString("status");
               String name = rs.getString("name");
               String role = rs.getString("role");
               UserDTO user = new UserDTO(username, password, name, role, status);
               getAllUser.add(user);
            }
            con.close();
            
        }catch(SQLException ex){
            ex.printStackTrace();
        }
    
        
        return getAllUser;
}
    
    public boolean ban(String username){
        String sql = " UPDATE users SET status = 'inactive' WHERE username = ? ";
        try{
            
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.executeUpdate();           
            con.close();
            return ps.executeUpdate() >0;
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return false;
    }
    
    public boolean unban(String username){
        String sql = " UPDATE users SET status = 'active' WHERE username = ? ";
        try{
            
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.executeUpdate();           
            con.close();
            return ps.executeUpdate() >0;
        }catch(SQLException ex){
            ex.printStackTrace();
        }
        return false;
    }
    
     
    
    

}
