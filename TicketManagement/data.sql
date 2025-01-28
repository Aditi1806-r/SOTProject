use ticketingsystem;
--DROP TABLE IF EXISTS booking, payment, routes, schedule, station, ticket, trains, user;

CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    password VARCHAR(100),
    role ENUM('admin', 'customer')
);

CREATE TABLE Station (
    station_id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Trains (
    train_number VARCHAR(10) PRIMARY KEY,
    train_name VARCHAR(50),
    number_of_seats INT,
    type ENUM('local', 'express')
);

CREATE TABLE Schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    arrival_time TIME,
    departure_time TIME,
    train_number VARCHAR(10),
    station_id INT,
    FOREIGN KEY (train_number) REFERENCES Trains(train_number),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

CREATE TABLE Routes (
    route_id int AUTO_INCREMENT PRIMARY KEY,
    train_number VARCHAR(10),
    station_id INT,
    stop_order INT,
    distance_from_start DECIMAL(5, 2),
    FOREIGN KEY (train_number) REFERENCES Trains(train_number),
    FOREIGN KEY (station_id) REFERENCES Station(station_id)
);

CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    train_number VARCHAR(10),
    schedule_id INT,
    date DATE,
    status ENUM('Booked', 'cancelled', 'confirmed'),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (train_number) REFERENCES Trains(train_number),
    FOREIGN KEY (schedule_id) REFERENCES Schedule(schedule_id)
);

CREATE TABLE Ticket (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    seat_number INT,
    price DECIMAL(10, 2),
    start_station_id INT,
    end_station_id INT,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (start_station_id) REFERENCES Station(station_id),
    FOREIGN KEY (end_station_id) REFERENCES Station(station_id)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    date DATE,
    amount DECIMAL(10, 2),
    payment_method ENUM('Cash', 'Card'),
    payment_status ENUM('failed', 'success', 'pending'),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);






INSERT INTO User (first_name, last_name, phone_number, email, password, role) VALUES
('John', 'Doe', '1234567890', 'john.doe@example.com', 'password1', 'customer'),
('Jane', 'Smith', '2345678901', 'jane.smith@example.com', 'password2', 'customer'),
('Alice', 'Johnson', '3456789012', 'alice.johnson@example.com', 'password3', 'admin'),
('Bob', 'Brown', '4567890123', 'bob.brown@example.com', 'password4', 'customer'),
('Charlie', 'Davis', '5678901234', 'charlie.davis@example.com', 'password5', 'customer');




INSERT INTO Station (station_id, station_name, city) VALUES
(1, 'Kashmere Gate', 'Delhi'),
(2, 'Lal Quila', 'Delhi'),
(3, 'Jama Masjid', 'Delhi'),
(4, 'Delhi Gate', 'Delhi'),
(5, 'ITO', 'Delhi'),
(6, 'Mandi House', 'Delhi'),
(7, 'Janpath', 'Delhi'),
(8, 'Central Secretariat', 'Delhi'),
(9, 'Khan Market', 'Delhi'),
(10, 'Jawaharlal Nehru Stadium', 'Delhi'),
(11, 'Jangpura', 'Delhi'),
(12, 'Lajpat Nagar', 'Delhi'),
(13, 'Moolchand', 'Delhi'),
(14, 'Kailash Colony', 'Delhi'),
(15, 'Nehru Place', 'Delhi'),
(16, 'Kalkaji Mandir', 'Delhi'),
(17, 'Govind Puri', 'Delhi'),
(18, 'Okhla', 'Delhi'),
(19, 'Jasola', 'Delhi'),
(20, 'Sarita Vihar', 'Delhi'),
(21, 'Mohan Estate', 'Delhi'),
(22, 'Tughlakabad', 'Delhi'),
(23, 'Badarpur Border', 'Delhi'),
(24, 'Sarai', 'Faridabad'),
(25, 'NHPC Chowk', 'Faridabad'),
(26, 'Mewala Maharajpur', 'Faridabad'),
(27, 'Sector 28 Faridabad', 'Faridabad'),
(28, 'Badkal Mor', 'Faridabad'),
(29, 'Old Faridabad', 'Faridabad'),
(30, 'Neelam Chowk Ajronda', 'Faridabad'),
(31, 'Bata Chowk', 'Faridabad'),
(32, 'Escorts Mujesar', 'Faridabad');



INSERT INTO Trains (train_number, train_name, number_of_seats, type) VALUES
('T001', 'Express 1', 120, 'express'),
('T002', 'Express 2', 150, 'express'),
('T003', 'Local 1', 200, 'local'),
('T004', 'Local 2', 180, 'local'),
('T005', 'Express 3', 160, 'express');

INSERT INTO Schedule (arrival_time, departure_time, train_number, station_id) VALUES
('08:00:00', '08:10:00', 'T001', 1),
('08:20:00', '08:30:00', 'T001', 2),
('08:40:00', '08:50:00', 'T001', 3),
('09:00:00', '09:10:00', 'T001', 4),
('09:20:00', '09:30:00', 'T001', 5),
('09:40:00', '09:50:00', 'T001', 6),
('10:00:00', '10:10:00', 'T001', 7),
('10:20:00', '10:30:00', 'T001', 8),
('10:40:00', '10:50:00', 'T001', 9),
('11:00:00', '11:10:00', 'T001', 10);

INSERT INTO Booking (user_id, train_number, schedule_id, date, status) VALUES
(1, 'T001', 1, '2023-10-01', 'Booked'),
(2, 'T002', 6, '2023-10-02', 'Booked'),
(3, 'T003', 2, '2023-10-03', 'cancelled'),
(4, 'T004', 3, '2023-10-04', 'confirmed'),
(5, 'T005', 4, '2023-10-05', 'Booked');

Select * from booking;

INSERT INTO Ticket (booking_id, seat_number, price, start_station_id, end_station_id) VALUES
(1, 1, 50.00, 1, 5),
(2, 2, 60.00, 6, 10),
(3, 3, 40.00, 2, 4),
(4, 4, 30.00, 3, 6),
(5, 5, 70.00, 1, 10);


INSERT INTO Routes (train_number, station_id, stop_order, distance_from_start) VALUES
('T001', 1, 1, 0),
('T001', 2, 2, 1.5),
('T001', 3, 3, 2.3),
('T001', 4, 4, 3.7),
('T001', 5, 5, 5),
('T001', 6, 6, 5.8),
('T001', 7, 7, 7.2),
('T001', 8, 8, 8.5),
('T001', 9, 9, 10),
('T001', 10, 10, 11.4);




INSERT INTO Payment (booking_id, date, amount, payment_method, payment_status) VALUES
(1, '2023-10-01', 50.00, 'Card', 'success'),
(2, '2023-10-02', 60.00, 'Cash', 'success'),
(3, '2023-10-03', 40.00, 'Card', 'failed'),
(4, '2023-10-04', 30.00, 'Cash', 'pending'),
(5, '2023-10-05', 70.00, 'Card', 'success');

Select * from payment;
