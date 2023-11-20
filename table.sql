-- Create Database
CREATE DATABASE IF NOT EXISTS BiyaahMandap;

-- Use Database
USE BiyaahMandap;

-- Create Tables
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user', 'manager') NOT NULL,
    INDEX idx_role (role)
);

CREATE TABLE Venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(255) NOT NULL,
    venue_capacity INT NOT NULL,
    venue_vacancy INT NOT NULL,
    venue_food BOOLEAN NOT NULL
);

CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_destination VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    venue_id INT NOT NULL,
    booking_date DATE NOT NULL,
    payment_status ENUM('paid', 'unpaid') NOT NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_venue_id (venue_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_booking_id (booking_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Insert Data
INSERT INTO Users (username, password, email, role)
VALUES
    ('admin1', 'adminpass', 'admin1@example.com', 'admin'),
    ('user1', 'userpass', 'user1@example.com', 'user'),
    ('manager1', 'managerpass', 'manager1@example.com', 'manager');

-- Queries

SELECT b.booking_id, b.booking_date, v.venue_name
FROM Bookings b 
JOIN Venues v ON b.venue_id = v.venue_id
WHERE b.user_id = 1 AND b.booking_id IN (SELECT booking_id FROM Payments)
AND (SELECT role FROM Users WHERE user_id = 1) = 'admin';

SELECT user_id, 
       (SELECT COALESCE(SUM(amount), 0) FROM Payments WHERE user_id = 1) AS total_paid
FROM Users
WHERE user_id = 1 AND role = 'manager';
