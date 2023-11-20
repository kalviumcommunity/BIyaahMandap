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

INSERT INTO Bookings (user_id, venue_id, booking_date, payment_status)
VALUES
    (1, 1, '2023-10-20', 'paid'),
    (2, 2, '2023-11-05', 'unpaid'),
    (3, 3, '2023-12-15', 'paid');

UPDATE Venues
SET venue_vacancy = venue_vacancy - 1 
WHERE venue_id = 1;

INSERT INTO Payments (user_id, booking_id, payment_date, amount)

VALUES (1,1, '2023-12-01', 5000.00);

UPDATE Bookings
SET payment_status = 'paid'
WHERE booking_id = 1; 

SELECT b.booking_id, b.booking_date, v.venue_name
FROM Bookings b 
JOIN Venues v ON b.venue_id = v.venue_id

WHERE b.user_id = 1 AND b.booking_id IN (SELECT booking_id FROM Payments);

SELECT user_id, 
       (SELECT COALESCE(SUM(amount), 0) FROM Payments WHERE user_id = 1) AS total_paid
FROM Users
WHERE user_id = 1;
 
