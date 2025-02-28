/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Booking;

import java.sql.Date;

/**
 *
 * @author ACER
 */
public class BookingDTO {
    //Important Information
    private String bookingID;
    private String bookedBy;
    private String username;
    private String phone;
    private String roomName;
    private Date checkInDate;
    private Date checkOutDate;
    private int totalPrice; 
    private String status;
    //Not required
    private String description;
    private int roomID;
    private String typeName;

    public BookingDTO() {
    }

    

    public BookingDTO(String bookingID, String username, int roomID, String phone, Date checkInDate, Date checkOutDate, int totalPrice) {
        this.bookingID = bookingID;
        this.username = username;
        this.phone = phone;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.totalPrice = totalPrice;
        this.roomID = roomID;
    }


    public BookingDTO(int roomID, String roomName, String typeName, int totalPrice, String description, String phone, String bookingID, String bookedBy, Date checkInDate, Date checkOutDate, String status) {
        this.roomID = roomID;
        this.roomName = roomName;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
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
