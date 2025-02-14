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

    public UserDTO login(String username, String password) {

        UserDTO user = null;
        try {

            Connection con = DBUtils.getConnection();
            String sql = " SELECT name, role FROM users ";
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
