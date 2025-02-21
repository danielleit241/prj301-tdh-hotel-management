/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.RoomBooking;

import java.math.BigDecimal;
import java.sql.Date;

/**
 *
 * @author ACER
 */
public class RoomBookingDTO {
    private int roomID;
    private String romeName;
    private String typeName;
    private BigDecimal totalPrice;
    private String description;
    private String phone;
    private String bookingID;
    private String bookedBy; 
    private Date checkInDate;
    private Date checkOutDate;
    private String status;

    public RoomBookingDTO() {
    }
    
    

    public RoomBookingDTO(int roomID, String romeName, String typeName, BigDecimal totalPrice, String description, String phone, String bookingID, String bookedBy, Date checkInDate, Date checkOutDate, String status) {
        this.roomID = roomID;
        this.romeName = romeName;
        this.typeName = typeName;
        this.totalPrice = totalPrice;
        this.description = description;
        this.phone = phone;
        this.bookingID = bookingID;
        this.bookedBy = bookedBy;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.status = status;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getRomeName() {
        return romeName;
    }

    public void setRomeName(String romeName) {
        this.romeName = romeName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getBookedBy() {
        return bookedBy;
    }

    public void setBookedBy(String bookedBy) {
        this.bookedBy = bookedBy;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
