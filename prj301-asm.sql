create database HotelManagement
go


use HotelManagement

CREATE TABLE users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    name NVARCHAR(24) NOT NULL,
    role VARCHAR(6) NOT NULL CHECK (role IN ('admin', 'member')) DEFAULT 'member',
    createAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE roomTypes (
    typeName NVARCHAR(50) NOT NULL PRIMARY KEY,
    description NVARCHAR(MAX)
);

CREATE TABLE rooms (
    roomID INT PRIMARY KEY,
    roomName NVARCHAR(100) NOT NULL,
    typeName NVARCHAR(50) NOT NULL,
    price int NOT NULL CHECK (price > 0),
    description NVARCHAR(1000),
    FOREIGN KEY (typeName) REFERENCES roomTypes(typeName) ON DELETE CASCADE
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

-- Insert data into table roomTypes
INSERT INTO roomTypes (typeName, description)
VALUES 
    (N'Single Room', N'Room designed for one person, offering basic yet modern amenities.'),
    (N'Double Room', N'Room designed for two people, cozy and cost-effective.'),
    (N'Twin Room', N'Room with two single beds, ideal for small families or groups of friends.'),
    (N'Quad Room', N'Spacious room, perfect for larger families or groups of friends.');

-- Insert data into table rooms with 50 rooms, each having a unique name and description
INSERT INTO rooms (roomID, roomName, typeName, price, description)
VALUES
    -- Group 1 (5 rooms)
    (101, N'Modern Single Room with Air Conditioner', N'Single Room', 500000,
     N'Modern single room equipped with an air conditioner, a 32-inch LED TV, and premium ceramic tile flooring; the bathroom features a convenient shower and a compact washing machine.'),
     
    (102, N'Luxurious Double Room with Bathtub', N'Double Room', 700000,
     N'Double room offering a cost-effective solution for families or couples, featuring an air conditioner, a 40-inch LED TV, and a private balcony; it has anti-slip tiled flooring and a bathroom equipped with a warm bathtub and premium bathrobe.'),
     
    (103, N'Comfortable Twin Room with Natural Wood Floor', N'Twin Room', 750000,
     N'Twin room with two comfortable single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom is fitted with an efficient shower, an integrated washing machine, and a heater.'),
     
    (104, N'Spacious Quad Room with Large Bathtub', N'Quad Room', 1200000,
     N'Quad room offering ample space, equipped with a powerful air conditioner, a 55-inch LED TV, and granite flooring; the bathroom features a large bathtub, a washing machine, and a heater—ideal for larger families.'),
     
    (105, N'Minimalist Single Room with LED TV', N'Single Room', 480000,
     N'Minimalist single room featuring an air conditioner, a 32-inch LED TV, and refined ceramic tile flooring; the bathroom uses a convenient shower and includes a compact washing machine.'),
     
    -- Group 2 (5 rooms)
    (201, N'Elegant Single Room with Wardrobe', N'Single Room', 510000,
     N'Single room equipped with a modern air conditioner, a 32-inch LED TV, and glossy ceramic tile flooring; the bathroom has a contemporary shower and ample natural light.'),
     
    (202, N'Cozy Double Room with Balcony', N'Double Room', 710000,
     N'Double room featuring an air conditioner, a 40-inch LED TV, and a charming balcony; it has anti-slip tiled flooring and a bathroom with a warm bathtub and soft bathrobe.'),
     
    (203, N'Modern Twin Room with Washing Machine', N'Twin Room', 760000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom includes an efficient shower and an integrated washing machine.'),
     
    (204, N'Contemporary Quad Room with Granite Floor', N'Quad Room', 1210000,
     N'Quad room equipped with an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom features a large bathtub, a washing machine, and a heater.'),
     
    (205, N'Practical Single Room with Washing Machine', N'Single Room', 490000,
     N'Single room featuring an air conditioner, a 32-inch LED TV, and refined ceramic tile flooring; the bathroom has a convenient shower and a compact washing machine.'),
     
    -- Group 3 (5 rooms)
    (301, N'Modern Single Room with Sleek Tile Floor', N'Single Room', 520000,
     N'Single room with an air conditioner, a 32-inch LED TV, and premium ceramic tile flooring; the bathroom is equipped with a convenient shower and plenty of natural light.'),
     
    (302, N'Romantic Double Room with Natural Light', N'Double Room', 720000,
     N'Double room featuring an air conditioner, a 40-inch LED TV, and a private balcony; it has anti-slip tiled flooring and a bathroom with a warm bathtub and premium bathrobe.'),
     
    (303, N'Modern Twin Room with Efficient Shower', N'Twin Room', 770000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom includes an efficient shower, an integrated washing machine, and a heater.'),
     
    (304, N'Luxurious Quad Room with LED Entertainment', N'Quad Room', 1220000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom comes with a large bathtub, a washing machine, and a heater—ideal for larger groups.'),
     
    (305, N'Contemporary Single Room with Large Window', N'Single Room', 500000,
     N'Single room with an air conditioner, a 32-inch LED TV, and refined ceramic tile flooring; the bathroom features a convenient shower and a compact washing machine that creates a relaxing space.'),
     
    -- Group 4 (4 rooms)
    (401, N'Modern Single Room with Elegant Interior', N'Single Room', 530000,
     N'Single room featuring an air conditioner, a 32-inch LED TV, and bright ceramic tile flooring; the bathroom is fitted with a contemporary shower and a compact washing machine for optimal space utilization.'),
     
    (402, N'Luxurious Double Room with Warm Bathtub', N'Double Room', 730000,
     N'Double room equipped with an air conditioner, a 40-inch LED TV, and a private balcony; it offers anti-slip tiled flooring and a bathroom with a warm bathtub and premium bathrobe.'),
     
    (403, N'Practical Twin Room with Heater', N'Twin Room', 780000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and cozy natural wood flooring; the modern bathroom features an efficient shower, an integrated washing machine, and a heater.'),
     
    (404, N'Spacious Quad Room with Wardrobe', N'Quad Room', 1230000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom is equipped with a large bathtub, a washing machine, and a heater—ideal for large families.'),
     
    -- Group 5 (4 rooms)
    (501, N'Modern Single Room with Air Conditioner', N'Single Room', 540000,
     N'Single room featuring an air conditioner, a 32-inch LED TV, and premium ceramic tile flooring; the bathroom has a modern shower and a compact washing machine for a relaxing ambiance.'),
     
    (502, N'Cozy Double Room with Private Balcony', N'Double Room', 740000,
     N'Double room equipped with an air conditioner, a 40-inch LED TV, and a private balcony; it features anti-slip tiled flooring and a bathroom with a warm bathtub and soft bathrobe.'),
     
    (503, N'Modern Twin Room with Wooden Floor', N'Twin Room', 790000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom includes an efficient shower, an integrated washing machine, and a heater.'),
     
    (504, N'Luxurious Quad Room with Large Bathtub', N'Quad Room', 1240000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom boasts a large bathtub, a washing machine, and a heater—perfect for larger groups.'),
     
    -- Group 6 (4 rooms)
    (601, N'Contemporary Single Room with LED Display', N'Single Room', 550000,
     N'Single room featuring an air conditioner, a 32-inch LED TV, and ceramic tile flooring; the bathroom has an efficient shower and a compact washing machine that creates a peaceful atmosphere.'),
     
    (602, N'Luxurious Double Room with Bathtub', N'Double Room', 750000,
     N'Double room equipped with an air conditioner, a 40-inch LED TV, and a refined balcony; it offers anti-slip tiled flooring and a bathroom with a warm bathtub and premium bathrobe.'),
     
    (603, N'Modern Twin Room with Washing Machine', N'Twin Room', 800000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom features an efficient shower, with an integrated washing machine and heater.'),
     
    (604, N'Spacious Quad Room with Granite Flooring', N'Quad Room', 1250000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom comes with a large bathtub, a washing machine, and an integrated heater.'),
     
    -- Group 7 (4 rooms)
    (701, N'Minimalist Single Room with Modern Design', N'Single Room', 560000,
     N'Single room with an air conditioner, a 32-inch LED TV, and ceramic tile flooring; the bathroom features an efficient shower and a compact washing machine that creates a relaxing space.'),
     
    (702, N'Romantic Double Room with Balcony', N'Double Room', 760000,
     N'Double room featuring an air conditioner, a 40-inch LED TV, and a private balcony; it has anti-slip tiled flooring and a bathroom with a warm bathtub and premium bathrobe.'),
     
    (703, N'Practical Twin Room with Heater', N'Twin Room', 810000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom includes an efficient shower, with an integrated washing machine and heater.'),
     
    (704, N'Luxurious Quad Room with LED Entertainment', N'Quad Room', 1260000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom is equipped with a large bathtub, a washing machine, and a heater—ideal for larger groups.'),
     
    -- Group 8 (5 rooms)
    (801, N'Modern Single Room with Elegant Interior', N'Single Room', 570000,
     N'Single room with an air conditioner, a 32-inch LED TV, and refined ceramic tile flooring; the bathroom features a modern shower and a compact washing machine for a relaxing ambiance.'),
     
    (802, N'Cozy Double Room with Private Balcony', N'Double Room', 770000,
     N'Double room featuring an air conditioner, a 40-inch LED TV, and a private balcony; it offers anti-slip tiled flooring and a bathroom with a warm bathtub and soft bathrobe.'),
     
    (803, N'Modern Twin Room with Natural Wood Floor', N'Twin Room', 820000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom includes an efficient shower, an integrated washing machine, and a heater.'),
     
    (804, N'Spacious Quad Room with Large Bathtub', N'Quad Room', 1270000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom comes with a large bathtub, a washing machine, and an integrated heater.'),

    (805, N'Modern Single Room with Elegant Interior', N'Single Room', 500000,
     N'Single room with an air conditioner, a 32-inch LED TV, and ceramic tile flooring; the bathroom features a modern shower and a compact washing machine in a minimalist style.'),
     
    -- Group 9 (5 rooms)
    (901, N'Practical Single Room with Washing Machine', N'Single Room', 580000,
     N'Single room with an air conditioner, a 32-inch LED TV, and premium ceramic tile flooring; the bathroom features a convenient shower, a compact washing machine, and plenty of natural light.'),
     
    (902, N'Luxurious Double Room with Bathtub', N'Double Room', 780000,
     N'Double room featuring an air conditioner, a 40-inch LED TV, and a private balcony; it offers anti-slip tiled flooring and a bathroom with a warm bathtub and premium bathrobe.'),
     
    (903, N'Modern Twin Room with LED Display', N'Twin Room', 830000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom includes an efficient shower, with an integrated washing machine and heater.'),
     
    (904, N'Luxurious Quad Room with Granite Floor', N'Quad Room', 1280000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom comes with a large bathtub, a washing machine, and an integrated heater—perfect for larger families.'),
     
    (905, N'Minimalist Single Room with Modern Design', N'Single Room', 490000,
     N'Single room with an air conditioner, a 32-inch LED TV, and refined ceramic tile flooring; the bathroom features a convenient shower and a compact washing machine in a modern style.'),
     
    -- Group 10 (5 rooms)
    (1001, N'Elegant Single Room with Large Window', N'Single Room', 590000,
     N'Single room featuring an air conditioner, a 32-inch LED TV, and ceramic tile flooring; the bathroom includes a modern shower, a compact washing machine, and a large window for abundant natural light.'),
     
    (1002, N'Romantic Double Room with Warm Bathtub', N'Double Room', 790000,
     N'Double room with an air conditioner, a 40-inch LED TV, and a private balcony; it offers anti-slip tiled flooring and a bathroom with a warm bathtub and premium bathrobe.'),
     
    (1003, N'Modern Twin Room with Washing Machine', N'Twin Room', 840000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom features an efficient shower, with an integrated washing machine and heater for optimal convenience.'),
     
    (1004, N'Contemporary Quad Room with LED Entertainment', N'Quad Room', 1290000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom comes with a large bathtub, a washing machine, and an integrated heater.'),
     
    (1005, N'Modern Single Room with Elegant Interior', N'Single Room', 500000,
     N'Single room with an air conditioner, a 32-inch LED TV, and ceramic tile flooring; the bathroom features a modern shower and a compact washing machine in a minimalist style.'),
     
    -- Group 11 (5 rooms)
    (1101, N'Practical Single Room with LED TV', N'Single Room', 600000,
     N'Single room with an air conditioner, a 32-inch LED TV, and premium ceramic tile flooring; the bathroom features a convenient shower and a compact washing machine that creates a bright space.'),
     
    (1102, N'Luxurious Double Room with Bathtub', N'Double Room', 800000,
     N'Double room featuring an air conditioner, a 40-inch LED TV, and a private balcony; it has anti-slip tiled flooring and a bathroom with a warm bathtub and premium bathrobe.'),
     
    (1103, N'Modern Twin Room with Natural Wood Floor', N'Twin Room', 850000,
     N'Twin room with two single beds, an air conditioner, a 43-inch LED TV, and natural wood flooring; the modern bathroom includes an efficient shower, with an integrated washing machine and heater.'),
     
    (1104, N'Spacious Quad Room with Large Bathtub', N'Quad Room', 1300000,
     N'Quad room featuring an air conditioner, a 55-inch LED TV, and granite flooring; the bathroom comes with a large bathtub, a washing machine, and an integrated heater—ideal for large families.'),
     
    (1105, N'Modern Single Room with Minimalist Design', N'Single Room', 510000,
     N'Single room with an air conditioner, a 32-inch LED TV, and ceramic tile flooring; the bathroom features a convenient shower and a compact washing machine in a minimalist style.')
;

SELECT * FROM rooms WHERE typeName LIKE '%single%' ORDER BY price
