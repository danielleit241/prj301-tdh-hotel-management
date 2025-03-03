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
    private int roomID;
    private int typeRoomID;
    private String username;
    private String phone;
    private Date checkInDate;
    private Date checkOutDate;
    private int totalPrice;
    private String status;

    public BookingDTO() {
    }

    public BookingDTO(String bookingID, int roomID, int typeRoomID, String username, String phone, Date checkInDate, Date checkOutDate, int totalPrice) {
        this.bookingID = bookingID;
        this.roomID = roomID;
        this.typeRoomID = typeRoomID;
        this.username = username;
        this.phone = phone;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.totalPrice = totalPrice;
    }

    public BookingDTO(String bookingID, int roomID, int typeRoomID, String username, String phone, Date checkInDate, Date checkOutDate, int totalPrice, String status) {
        this.bookingID = bookingID;
        this.roomID = roomID;
        this.typeRoomID = typeRoomID;
        this.username = username;
        this.phone = phone;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getTypeRoomID() {
        return typeRoomID;
    }

    public void setTypeRoomID(int typeRoomID) {
        this.typeRoomID = typeRoomID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
