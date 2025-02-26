/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Room;


/**
 *
 * @author ACER
 */
public class RoomDTO {
    private int roomID;
    private String roomName;
    private String typeName;
    private int price;
    private String description;

    public RoomDTO() {
    }
    
    public RoomDTO(int roomID, String roomName, String typeName, int price, String description) {
        this.roomID = roomID;
        this.roomName = roomName;
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

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
