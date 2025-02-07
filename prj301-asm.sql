create database HotelManagement
go

use HotelManagement

CREATE TABLE users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    email VARCHAR(70) NOT NULL UNIQUE,
    role VARCHAR(6) NOT NULL CHECK (role IN ('admin', 'member')) DEFAULT 'member',
    createAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE roomTypes (
    typeName NVARCHAR(50) NOT NULL PRIMARY KEY,
    description NVARCHAR(MAX)
);

CREATE TABLE rooms (
    roomID INT PRIMARY KEY,
    romeName NVARCHAR(100) NOT NULL,
    typeName NVARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    description NVARCHAR(1000),
    FOREIGN KEY (typeName) REFERENCES roomTypes(typeName) ON DELETE CASCADE
);

CREATE TABLE bookings (
    bookingID VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    roomID INT NOT NULL,
    checkInDate DATE NOT NULL,
    checkOutDate DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('confirmed', 'cancel', 'pending')) DEFAULT 'pending',
    totalPrice DECIMAL(10, 2) NOT NULL CHECK (totalPrice >= 0),
    createAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    FOREIGN KEY (roomID) REFERENCES rooms(roomID) ON DELETE CASCADE
);

CREATE TABLE payments (
    paymentID VARCHAR(50) PRIMARY KEY,
    bookingID VARCHAR(50) NOT NULL,
    paymentMethod VARCHAR(10) NOT NULL,  
    paymentStatus VARCHAR(10) DEFAULT 'pending' CHECK (paymentStatus IN ('paid', 'failed', 'pending')),
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (bookingID) REFERENCES bookings(bookingID) ON DELETE CASCADE
);

CREATE TABLE feedback (
    feedbackID INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    roomID INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment NVARCHAR(1000),
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    FOREIGN KEY (roomID) REFERENCES rooms(roomID) ON DELETE CASCADE
);

INSERT INTO users(username, password, email, role) 
VALUES ('hoa', 'hoa', 'hoalvpse181951@fpt.edu.vn', 'admin');


