/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301.asm.Booking;

import java.sql.Date;



/**
 *
 * @author ACER
 */
public class BookingDTO {
    private String bookingID;
    private String phone;
    private Date checkInDate;
    private Date checkOutDate;
    private String status;
    private double totalPrice;

<<<<<<< HEAD
    public BookingDTO(String bookingID, String phone, Date checkInDate, Date checkOutDate, String status,double totalPrice) {
=======
    
    public BookingDTO(String bookingID, String phone, Date checkInDate, Date checkOutDate, double totalPrice) {
>>>>>>> f7529ab4d775dd154231fc216d4d3d9688bb4f2d
        this.bookingID = bookingID;
        this.phone = phone;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.status = status;
        this.totalPrice = totalPrice;
        
    }
<<<<<<< HEAD

    public String getStatus() {
        return status;
    }
<<<<<<< Updated upstream
    
    
=======

    public void setStatus(String status) {
        this.status = status;
    }
=======
    
>>>>>>> f7529ab4d775dd154231fc216d4d3d9688bb4f2d
    
>>>>>>> Stashed changes
    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    
}
