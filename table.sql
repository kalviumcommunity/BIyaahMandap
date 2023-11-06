CREATE DATABASE BiyaahMandap; 

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') NOT NULL
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
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    booking_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

ALTER TABLE Bookings
ADD COLUMN booking_description TEXT;

ALTER TABLE Bookings
DROP COLUMN booking_description; 
SELECT * FROM Bookings;
