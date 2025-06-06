﻿create database HotelManagement
go


use HotelManagement

CREATE TABLE users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    name NVARCHAR(24) NOT NULL,
    role VARCHAR(6) NOT NULL CHECK (role IN ('admin', 'member')) DEFAULT 'member',
    createAt DATETIME DEFAULT GETDATE()
);

-- Bảng danh mục loại phòng: lưu mã và tên loại phòng
CREATE TABLE typeRoom (
    typeRoomID INT PRIMARY KEY,
    typeName NVARCHAR(100) NOT NULL,
	typeDes NVARCHAR(255),
	price INT NOT NULL CHECK(price > 0),
    roomSize NVARCHAR(50) NOT NULL,
    bedSize NVARCHAR(100) NOT NULL,
    maxOccupancy NVARCHAR(50) NOT NULL, 
    viewDetail NVARCHAR(50) NOT NULL,
    bathroom NVARCHAR(200) NOT NULL,
    smoking NVARCHAR(10) NOT NULL CHECK (smoking IN ('Yes', 'No')),
);

-- Bảng chứa thông tin các phòng cụ thể, chỉ lưu roomID và tham chiếu đến typeRoom
CREATE TABLE rooms (
    roomID INT PRIMARY KEY,
    typeRoomID INT NOT NULL,
    FOREIGN KEY (typeRoomID) REFERENCES typeRoom(typeRoomID) ON DELETE CASCADE
);


CREATE TABLE bookings (
    bookingID VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
	typeRoomID INT NOT NULL,
    roomID INT NOT NULL,
    phone VARCHAR(11) NOT NULL,
    checkInDate DATE NOT NULL,
    checkOutDate DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('confirmed', 'cancel', 'pending')) DEFAULT 'pending',
    totalPrice int NOT NULL CHECK (totalPrice >= 0),
    createAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    FOREIGN KEY (roomID) REFERENCES rooms(roomID) ON DELETE CASCADE,
	FOREIGN KEY (typeRoomID) REFERENCES typeRoom(typeRoomID)
);


CREATE TABLE payments (
    paymentID VARCHAR(50) PRIMARY KEY,
    bookingID VARCHAR(50) NOT NULL,
    paymentMethod VARCHAR(10) NOT NULL,  
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
	
SELECT * FROM typeRoom

--------------------------------------------------------------------------------------------------------------------------


-- Value Insert!

insert into users(username, password, name, role) 
	values('hoa', 'hoa', N'Hòa Lê', 'admin'),
		('dat', 'dat', N'Đạt 09', 'admin'),
		('thinh', 'thinh', N'Thịnh Tu', 'admin');

INSERT INTO typeRoom (typeRoomID, typeName, typeDes, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES 
  (1, 'DELUXE KING', N'The Deluxe King offers modern design and superior comfort with a luxurious king bed and a stunning City view—perfect for couples seeking a refined urban experience.', 500000, N'37 m2', N'1 x King size – 1m8 x 2m', N'02 Adults', N'City view', N'Toilet room, shower room and washbasin', N'No'),
  (2, 'DELUXE DOUBLE', N'The Deluxe Double provides extra space and style, featuring a sophisticated layout with a serene River view that soothes and inspires relaxation.', 1500000, N'50 m2', N'1 x Special Double setup – 1m8 x 2m', N'02 - 03 Adults', N'River view', N'Toilet room, shower room, washbasin and bathtub', N'No'),
  (3, 'PREMIER KING', N'The Premier King redefines luxury with a spacious layout, a premium king-size bed, and a breathtaking Skyline view—ideal for guests who appreciate refined design and dramatic vistas.', 1000000, N'40 m2', N'1 x King size – 1m8 x 2m', N'02 Adults', N'Skyline view', N'Toilet, shower room and washbasin', N'No'),
  (4, 'JUNIOR SUITE', N'The Junior Suite exudes elegance with a separate living area and modern amenities, complemented by a vibrant City view that energizes your stay.', 800000, N'35 m2', N'2 x Queen size – 1m6 x 2m', N'02 Adults', N'City view', N'Toilet, shower room and washbasin', N'No'),
  (5, 'DELUXE ONE BEDROOM SUITE', N'The Deluxe One Bedroom Suite offers a private retreat with a separate bedroom and living area, featuring a calming River view that enhances your relaxation.', 1000000, N'40 m2', N'1 x King size – 1m8 x 2m', N'02 Adults', N'River view', N'Toilet room, shower room, washbasin and bathtub', N'No'),
  (6, 'PREMIER ONE BEDROOM SUITE', N'The Premier One Bedroom Suite blends style and functionality with upscale furnishings and an impressive Skyline view that captivates and delights.', 800000, N'35 m2', N'1 x Queen size – 1m6 x 2m', N'02 Adults', N'Skyline view', N'Toilet room, shower room, washbasin and bathtub', N'No'),
  (7, 'TWO BEDROOM SUITE', N'The Two Bedroom Suite is perfect for families or groups, offering two distinct bedrooms and ample living space with a dynamic City view.', 1500000, N'50 m2', N'1 x King size – 1m8 x 2m (per bedroom)', N'04 Adults', N'City view', N'Toilet room, shower room, washbasin and bathtub', N'No'),
  (8, 'THD PENTHOUSE SUITE', N'The THD Penthouse Suite epitomizes luxury with expansive living spaces and an unrivaled Skyline view that captures the essence of urban sophistication.', 2000000, N'65 m2', N'1 x Super King – 2m2 Cyrcle', N'02 Adults', N'Skyline view', N'Toilet room, shower room, washbasin and oversize bathtub', N'No'),
  (9, 'ONE BEDROOM SUITE', N'The One Bedroom Suite combines sophisticated design with comfort, featuring a spacious layout and a picturesque River view that offers a tranquil retreat.', 800000, N'35 m2', N'1 x King size – 1m8 x 2m', N'02 Adults', N'River view', N'Toilet room, shower room, washbasin and bathtub', N'No');


-- Loại phòng 1: 6 phòng (roomID 110 đến 115)
INSERT INTO rooms (roomID, typeRoomID) VALUES (110, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (111, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (112, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (113, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (114, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (115, 1);

-- Loại phòng 2: 6 phòng (roomID 116 đến 121)
INSERT INTO rooms (roomID, typeRoomID) VALUES (210, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (211, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (212, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (213, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (214, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (215, 2);

-- Loại phòng 3: 6 phòng (roomID 122 đến 127)
INSERT INTO rooms (roomID, typeRoomID) VALUES (310, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (311, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (312, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (313, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (314, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (315, 3);

-- Loại phòng 4: 6 phòng (roomID 128 đến 133)
INSERT INTO rooms (roomID, typeRoomID) VALUES (410, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (411, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (412, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (413, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (414, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (415, 4);

-- Loại phòng 5: 6 phòng (roomID 134 đến 139)
INSERT INTO rooms (roomID, typeRoomID) VALUES (510, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (511, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (512, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (513, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (514, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (515, 5);

-- Loại phòng 6: 5 phòng (roomID 140 đến 144)
INSERT INTO rooms (roomID, typeRoomID) VALUES (610, 6);
INSERT INTO rooms (roomID, typeRoomID) VALUES (611, 6);
INSERT INTO rooms (roomID, typeRoomID) VALUES (612, 6);
INSERT INTO rooms (roomID, typeRoomID) VALUES (613, 6);
INSERT INTO rooms (roomID, typeRoomID) VALUES (614, 6);

-- Loại phòng 7: 5 phòng (roomID 145 đến 149)
INSERT INTO rooms (roomID, typeRoomID) VALUES (710, 7);
INSERT INTO rooms (roomID, typeRoomID) VALUES (712, 7);
INSERT INTO rooms (roomID, typeRoomID) VALUES (713, 7);
INSERT INTO rooms (roomID, typeRoomID) VALUES (714, 7);
INSERT INTO rooms (roomID, typeRoomID) VALUES (715, 7);

-- Loại phòng 8: 5 phòng (roomID 150 đến 154)
INSERT INTO rooms (roomID, typeRoomID) VALUES (810, 8);
INSERT INTO rooms (roomID, typeRoomID) VALUES (811, 8);
INSERT INTO rooms (roomID, typeRoomID) VALUES (812, 8);
INSERT INTO rooms (roomID, typeRoomID) VALUES (813, 8);
INSERT INTO rooms (roomID, typeRoomID) VALUES (814, 8);

-- Loại phòng 9: 5 phòng (roomID 155 đến 159)
INSERT INTO rooms (roomID, typeRoomID) VALUES (910, 9);
INSERT INTO rooms (roomID, typeRoomID) VALUES (911, 9);
INSERT INTO rooms (roomID, typeRoomID) VALUES (912, 9);
INSERT INTO rooms (roomID, typeRoomID) VALUES (913, 9);
INSERT INTO rooms (roomID, typeRoomID) VALUES (914, 9);
