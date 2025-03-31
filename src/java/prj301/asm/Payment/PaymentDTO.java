/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301.asm.Payment;

/**
 *
 * @author hoade
 */
public class PaymentDTO {
    private String paymentID;
    private String bookingID;
    private String method;

    public PaymentDTO() {
    }

    public PaymentDTO(String paymentID, String bookingID, String method) {
        this.paymentID = paymentID;
        this.bookingID = bookingID;
        this.method = method;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }
    
    
}
