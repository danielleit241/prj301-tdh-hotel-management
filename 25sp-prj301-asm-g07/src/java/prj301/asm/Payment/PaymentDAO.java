/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301.asm.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import prj301asm.utils.DBUtils;

/**
 *
 * @author hoade
 */
public class PaymentDAO {
    
    public boolean createPayment(String paymentID, String bookingID, String method){
        String sql = "insert into payments (paymentID, bookingID, paymentMethod) values (?, ?, ?)";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, paymentID);
            ps.setString(2, bookingID);
            ps.setString(2, method);
            
            if(ps.executeUpdate() > 0){
                return true;
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public String getMaxPaymentId() {
        String sql = "SELECT MAX(paymentID) as maxID FROM payments";
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
}
