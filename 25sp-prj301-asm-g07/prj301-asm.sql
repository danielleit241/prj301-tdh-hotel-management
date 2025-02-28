create database TestHotelManagement
go


use TestHotelManagement

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
    typeName NVARCHAR(100) NOT NULL  -- Ví dụ: 'Special King Room'
);

-- Bảng chứa thông tin chi tiết của loại phòng
CREATE TABLE typeRoomDetails (
    typeRoomID INT PRIMARY KEY,
    price INT NOT NULL CHECK(price > 0),
    roomSize NVARCHAR(50) NOT NULL,            -- Ví dụ: '50 m2'
    bedSize NVARCHAR(100) NOT NULL,            -- Ví dụ: '1 x Special King size – 1m8 x 2m'
    maxOccupancy NVARCHAR(50) NOT NULL,        -- Ví dụ: '02 - 03 Adults'
    viewDetail NVARCHAR(50) NOT NULL,                -- Ví dụ: 'City view'
    bathroom NVARCHAR(200) NOT NULL,           -- Ví dụ: 'Toilet room, shower room, washbasin and bathtub'
    smoking NVARCHAR(10) NOT NULL CHECK (smoking IN ('Yes', 'No')),
    FOREIGN KEY (typeRoomID) REFERENCES typeRoom(typeRoomID) ON DELETE CASCADE
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
    roomID INT NOT NULL,
    phone VARCHAR(11) NOT NULL,
    checkInDate DATE NOT NULL,
    checkOutDate DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('confirmed', 'cancel', 'pending')) DEFAULT 'pending',
    totalPrice int NOT NULL CHECK (totalPrice >= 0),
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
	
--------------------------------------------------------------------------------------------------------------------------

insert into users(username, password, name, role) 
	values('hoa', 'hoa', N'Hòa Lê', 'admin'),
		('dat', 'dat', N'Đạt 09', 'admin'),
		('thinh', 'thinh', N'Thịnh Tu', 'admin');

INSERT INTO typeRoom (typeRoomID, typeName) VALUES (1, 'Family Room');
INSERT INTO typeRoom (typeRoomID, typeName) VALUES (2, 'King Suite with Balcony');
INSERT INTO typeRoom (typeRoomID, typeName) VALUES (3, 'Deluxe Double Room with Bath');
INSERT INTO typeRoom (typeRoomID, typeName) VALUES (4, 'Deluxe Twin Room with Balcony');
INSERT INTO typeRoom (typeRoomID, typeName) VALUES (5, 'Junior Suite with Balcony city view');
INSERT INTO typeRoom (typeRoomID, typeName) VALUES (6, 'King Room With Sea View');
INSERT INTO typeRoom (typeRoomID, typeName) VALUES (7, 'King Room with Balcony');
INSERT INTO typeRoom (typeRoomID, typeName) VALUES (8, 'Executive Suite');
INSERT INTO typeRoom (typeRoomID, typeName) VALUES (9, 'Junior Suite With Balcony sea view');


INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (1, 150, '30 m2', '2 x Queen size – 1m6 x 2m', '02 - 04 Adults', 'City view', 'Toilet room, shower room and washbasin', 'No');

INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (2, 200, '50 m2', '1 x Special King size – 1m8 x 2m', '02 - 03 Adults', 'City view', 'Toilet room, shower room, washbasin and bathtub', 'No');

INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (3, 180, '30 m2', '1 x King size – 1m8 x 2m', '02 Adults', 'City view or Ocean view', 'Toilet, shower room and washbasin', 'No');

INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (4, 170, '35 m2', '2 x Queen size – 1m6 x 2m', '02 Adults', 'City view or Ocean view', 'Toilet, shower room and washbasin', 'No');

INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (5, 190, '40 m2', '1 x King size – 1m8 x 2m', '02 Adults', 'City view', 'Toilet room, shower room, washbasin and bathtub', 'No');

INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (6, 160, '25 m2', '1 x Queen size – 1m6 x 2m', '02 Adults', 'Ocean view', 'Toilet room, shower room, washbasin and bathtub', 'No');

INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (7, 155, '25 m2', '1 x King size – 1m8 x 2m', '02 Adults', 'City view', 'Toilet room, shower room, washbasin and bathtub', 'No');

INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (8, 250, '65 m2', '1 x Super King – 2m2 Cyrcle', '02 Adults', 'Ocean view and Rooftops', 'Toilet room, shower room, washbasin and oversize bathtub', 'No');

INSERT INTO typeRoomDetails (typeRoomID, price, roomSize, bedSize, maxOccupancy, viewDetail, bathroom, smoking)
VALUES (9, 185, '35 m2', '1 x King size – 1m8 x 2m', '02 Adults', 'Sea view', 'Toilet room, shower room, washbasin and bathtub', 'No');

-- Loại phòng 1: 6 phòng (roomID 110 đến 115)
INSERT INTO rooms (roomID, typeRoomID) VALUES (110, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (111, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (112, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (113, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (114, 1);
INSERT INTO rooms (roomID, typeRoomID) VALUES (115, 1);

-- Loại phòng 2: 6 phòng (roomID 116 đến 121)
INSERT INTO rooms (roomID, typeRoomID) VALUES (116, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (117, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (118, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (119, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (120, 2);
INSERT INTO rooms (roomID, typeRoomID) VALUES (121, 2);

-- Loại phòng 3: 6 phòng (roomID 122 đến 127)
INSERT INTO rooms (roomID, typeRoomID) VALUES (122, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (123, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (124, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (125, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (126, 3);
INSERT INTO rooms (roomID, typeRoomID) VALUES (127, 3);

-- Loại phòng 4: 6 phòng (roomID 128 đến 133)
INSERT INTO rooms (roomID, typeRoomID) VALUES (128, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (129, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (130, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (131, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (132, 4);
INSERT INTO rooms (roomID, typeRoomID) VALUES (133, 4);

-- Loại phòng 5: 6 phòng (roomID 134 đến 139)
INSERT INTO rooms (roomID, typeRoomID) VALUES (134, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (135, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (136, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (137, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (138, 5);
INSERT INTO rooms (roomID, typeRoomID) VALUES (139, 5);

-- Loại phòng 6: 5 phòng (roomID 140 đến 144)
INSERT INTO rooms (roomID, typeRoomID) VALUES (140, 6);
INSERT INTO rooms (roomID, typeRoomID) VALUES (141, 6);
INSERT INTO rooms (roomID, typeRoomID) VALUES (142, 6);
INSERT INTO rooms (roomID, typeRoomID) VALUES (143, 6);
INSERT INTO rooms (roomID, typeRoomID) VALUES (144, 6);

-- Loại phòng 7: 5 phòng (roomID 145 đến 149)
INSERT INTO rooms (roomID, typeRoomID) VALUES (145, 7);
INSERT INTO rooms (roomID, typeRoomID) VALUES (146, 7);
INSERT INTO rooms (roomID, typeRoomID) VALUES (147, 7);
INSERT INTO rooms (roomID, typeRoomID) VALUES (148, 7);
INSERT INTO rooms (roomID, typeRoomID) VALUES (149, 7);

-- Loại phòng 8: 5 phòng (roomID 150 đến 154)
INSERT INTO rooms (roomID, typeRoomID) VALUES (150, 8);
INSERT INTO rooms (roomID, typeRoomID) VALUES (151, 8);
INSERT INTO rooms (roomID, typeRoomID) VALUES (152, 8);
INSERT INTO rooms (roomID, typeRoomID) VALUES (153, 8);
INSERT INTO rooms (roomID, typeRoomID) VALUES (154, 8);

-- Loại phòng 9: 5 phòng (roomID 155 đến 159)
INSERT INTO rooms (roomID, typeRoomID) VALUES (155, 9);
INSERT INTO rooms (roomID, typeRoomID) VALUES (156, 9);
INSERT INTO rooms (roomID, typeRoomID) VALUES (157, 9);
INSERT INTO rooms (roomID, typeRoomID) VALUES (158, 9);
INSERT INTO rooms (roomID, typeRoomID) VALUES (159, 9);

INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, status, totalPrice)
VALUES ('B001', 'hoa', 110, '0901234567', '2025-03-01', '2025-03-05', 'confirmed', 600);
INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, status, totalPrice)
VALUES ('B006', 'hoa', 111, '0901234567', '2025-03-01', '2025-03-05', 'confirmed', 600);

INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, status, totalPrice)
VALUES ('B002', 'dat', 115, '0902345678', '2025-03-10', '2025-03-12', 'pending', 400);

INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, status, totalPrice)
VALUES ('B003', 'thinh', 120, '0903456789', '2025-03-15', '2025-03-18', 'confirmed', 550);

INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, status, totalPrice)
VALUES ('B004', 'hoa', 130, '0904567890', '2025-03-20', '2025-03-25', 'cancel', 0);

INSERT INTO bookings (bookingID, username, roomID, phone, checkInDate, checkOutDate, status, totalPrice)
VALUES ('B005', 'dat', 140, '0905678901', '2025-03-27', '2025-03-30', 'confirmed', 500);

select * from bookings
SELECT DISTINCT b.roomID
FROM bookings b
WHERE NOT(
    b.checkOutDate <= '2025-03-01'
    OR b.checkInDate >= '2025-03-05'
);

select * from typeRoom t INNER JOIN rooms r
	ON t.typeRoomID = r.typeRoomID
	INNER JOIN bookings b
	ON b.roomID = r.roomID

SELECT r.*
FROM rooms r INNER JOIN typeRoom t
	ON t.typeRoomID = 1
WHERE r.typeRoomID = 2
AND r.roomID NOT IN (
    SELECT DISTINCT b.roomID
    FROM bookings b
    WHERE NOT(
        b.checkOutDate <= '2025-03-01'
        OR b.checkInDate >= '2025-03-05'
    )
);

select * from typeRoom t INNER JOIN rooms r
	ON t.typeRoomID = r.typeRoomID
	INNER JOIN bookings b
	ON b.roomID = r.roomID
select * from typeRoom t INNER JOIN rooms r
	ON t.typeRoomID = r.typeRoomID
	INNER JOIN bookings b
	ON b.roomID = r.roomID
	WHERE r.typeRoomID = 2
AND r.roomID NOT IN (
    SELECT DISTINCT b.roomID
    FROM bookings b
    WHERE NOT(
        b.checkOutDate <= '2025-03-01'
        OR b.checkInDate >= '2025-03-05'
    )
)

-------------------------------------------
select * from typeRoom t INNER JOIN rooms r
	ON t.typeRoomID = r.typeRoomID
	INNER JOIN bookings b
	ON b.roomID = r.roomID
SELECT r.roomID, r.typeRoomID
FROM rooms r
WHERE r.typeRoomID = 1
  AND NOT EXISTS (
        SELECT 1
        FROM bookings b
        WHERE b.roomID = r.roomID
          AND b.status IN ('confirmed', 'pending')
  );
-------------------------------------------
