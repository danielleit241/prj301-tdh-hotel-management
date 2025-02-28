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
    private int typeRoomID;
    private String typeDes;
    private int price;
    private String typeName;
    private String roomSize;
    private String bedSize;
    private String maxOccupancy;
    private String viewDetail;
    private String bathroom;
    private String smoking;
    
    private int roomID;

    public RoomDTO() {
    }
    
    public RoomDTO(int typeRoomID, String typeDes, int price, String typeName, String roomSize, String bedSize, String maxOccupancy, String viewDetail, String bathroom, String smoking) {
        this.typeRoomID = typeRoomID;
        this.typeDes = typeDes;
        this.price = price;
        this.typeName = typeName;
        this.roomSize = roomSize;
        this.bedSize = bedSize;
        this.maxOccupancy = maxOccupancy;
        this.viewDetail = viewDetail;
        this.bathroom = bathroom;
        this.smoking = smoking;
    }
    
    public RoomDTO(int typeRoomID, int roomID, String typeDes, int price, String typeName, String roomSize, String bedSize, String maxOccupancy, String viewDetail, String bathroom, String smoking) {
        this.typeRoomID = typeRoomID;
        this.roomID = roomID;
        this.typeDes = typeDes;
        this.price = price;
        this.typeName = typeName;
        this.roomSize = roomSize;
        this.bedSize = bedSize;
        this.maxOccupancy = maxOccupancy;
        this.viewDetail = viewDetail;
        this.bathroom = bathroom;
        this.smoking = smoking;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }
    
    public String getTypeDes() {
        return typeDes;
    }

    public void setTypeDes(String typeDes) {
        this.typeDes = typeDes;
    }

    
    public int getTypeRoomID() {
        return typeRoomID;
    }

    public void setTypeRoomID(int typeRoomID) {
        this.typeRoomID = typeRoomID;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getRoomSize() {
        return roomSize;
    }

    public void setRoomSize(String roomSize) {
        this.roomSize = roomSize;
    }

    public String getBedSize() {
        return bedSize;
    }

    public void setBedSize(String bedSize) {
        this.bedSize = bedSize;
    }

    public String getMaxOccupancy() {
        return maxOccupancy;
    }

    public void setMaxOccupancy(String maxOccupancy) {
        this.maxOccupancy = maxOccupancy;
    }

    public String getViewDetail() {
        return viewDetail;
    }

    public void setViewDetail(String viewDetail) {
        this.viewDetail = viewDetail;
    }

    public String getBathroom() {
        return bathroom;
    }

    public void setBathroom(String bathroom) {
        this.bathroom = bathroom;
    }

    public String getSmoking() {
        return smoking;
    }

    public void setSmoking(String smoking) {
        this.smoking = smoking;
    }
    
    
}
