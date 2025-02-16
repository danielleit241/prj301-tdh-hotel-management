/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301.asm.Room;

import java.math.BigDecimal;

/**
 *
 * @author ACER
 */
public class RoomDTO {
    private int roomID;
    private String romeName;
    private String typeName;
    private BigDecimal price;
    private String description;

    public RoomDTO(int roomID, String romeName, String typeName, BigDecimal price, String description) {
        this.roomID = roomID;
        this.romeName = romeName;
        this.typeName = typeName;
        this.price = price;
        this.description = description;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
