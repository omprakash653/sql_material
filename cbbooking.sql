create database cabbooking;
use cabbooking;

-- Customers Table
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  registration_date DATE
);

-- Drivers Table
CREATE TABLE Drivers (
  driver_id INT PRIMARY KEY,
  name VARCHAR(100),
  phone VARCHAR(15),
  license_no VARCHAR(20)
);

-- Cabs Table
CREATE TABLE Cabs (
  cab_id INT PRIMARY KEY,
  vehicle_no VARCHAR(20),
  cab_type VARCHAR(20),       -- e.g. 'Sedan', 'SUV'
  driver_id INT,
  FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- Bookings Table
CREATE TABLE Bookings (
  booking_id INT PRIMARY KEY,
  customer_id INT,
  cab_id INT,
  driver_id INT,
  booking_time DATETIME,
  pickup_location VARCHAR(100),
  dropoff_location VARCHAR(100),
  status VARCHAR(20),                 -- 'Completed', 'Cancelled', 'Ongoing'
  cancellation_reason VARCHAR(100),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (cab_id) REFERENCES Cabs(cab_id),
  FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- TripDetails Table
CREATE TABLE TripDetails (
  trip_id INT PRIMARY KEY,
  booking_id INT,
  trip_start_time DATETIME,
  trip_end_time DATETIME,
  distance_km DECIMAL(6,2),
  fare DECIMAL(10,2),
  FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Feedback Table
CREATE TABLE Feedback (
  feedback_id INT PRIMARY KEY,
  booking_id INT,
  rating DECIMAL(2,1),
  comments VARCHAR(255),
  feedback_time DATETIME,
  FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

INSERT INTO Customers VALUES
  (1, 'Anjali Sharma', 'anjali.sharma@email.com', '2024-01-10'),
  (2, 'Rohit Verma', 'rohit.verma@email.com', '2024-01-15'),
  (3, 'Priya Singh', 'priya.singh@email.com', '2024-02-02'),
  (4, 'Amit Patel', 'amit.patel@email.com', '2024-02-12'),
  (5, 'Sneha Iyer', 'sneha.iyer@email.com', '2024-03-01');
  
  INSERT INTO Drivers VALUES
  (101, 'Sunil Kumar', '9000000001', 'DL202001'),
  (102, 'Seema Reddy', '9000000002', 'DL202002'),
  (103, 'Rajesh Yadav', '9000000003', 'DL202003'),
  (104, 'Rakesh Nair', '9000000004', 'DL202004'),
  (105, 'Meena Sharma', '9000000005', 'DL202005');
  
  INSERT INTO Cabs VALUES
  (201, 'MH01AB1234', 'Sedan', 101),
  (202, 'DL01BC2345', 'SUV', 102),
  (203, 'KA01DE3456', 'Sedan', 103),
  (204, 'GJ01FG4567', 'Hatchback', 104),
  (205, 'TN01HI5678', 'SUV', 105);
  
INSERT INTO Bookings VALUES
  (301, 1, 201, 101, '2025-07-28 09:00:00', 'Connaught Place', 'Airport', 'Completed', NULL),
  (302, 2, 202, 102, '2025-07-29 13:30:00', 'MG Road', 'Cyber City', 'Cancelled', 'Changed plans'),
  (303, 3, 202, 102, '2025-07-29 18:00:00', 'Home', 'Market', 'Completed', NULL),
  (304, 5, 203, 103, '2025-07-30 09:45:00', 'Powai', 'Thane', 'Completed', NULL),
  (305, 4, 204, 104, '2025-07-30 11:00:00', 'Gandhinagar', 'Ahmedabad', 'Completed', NULL);

INSERT INTO TripDetails VALUES
  (401, 301, '2025-07-28 09:10:00', '2025-07-28 09:50:00', 18.5, 450.00),
  (402, 303, '2025-07-29 18:05:00', '2025-07-29 18:20:00', 4.2, 120.00),
  (403, 304, '2025-07-30 09:55:00', '2025-07-30 10:45:00', 22.0, 500.00),
  (404, 305, '2025-07-30 11:05:00', '2025-07-30 11:55:00', 25.7, 630.00);


INSERT INTO Feedback VALUES
  (501, 301, 4.2, 'Smooth ride!', '2025-07-28 10:00:00'),
  (502, 303, 2.8, 'Driver was late', '2025-07-29 18:25:00'),
  (503, 304, 5.0, 'Excellent service', '2025-07-30 10:50:00'),
  (504, 305, 3.0, 'Cab was not clean', '2025-07-30 12:00:00');
  
-- List all customers who have at least one completed booking.
SELECT DISTINCT c.customer_id, c.name
FROM Customers c
JOIN Bookings b ON c.customer_id = b.customer_id
WHERE b.status = 'Completed';

--  Show all feedback with a rating below 4.
SELECT f.feedback_id, c.name AS customer, f.rating, f.comments
FROM Feedback f
JOIN Bookings b ON f.booking_id = b.booking_id
JOIN Customers c ON b.customer_id = c.customer_id
WHERE f.rating < 4;

--  Find the total fare paid in completed bookings by each customer.
SELECT c.customer_id, c.name, SUM(t.fare) AS total_fare
FROM Customers c
JOIN Bookings b ON c.customer_id = b.customer_id
JOIN TripDetails t ON b.booking_id = t.booking_id
WHERE b.status = 'Completed'
GROUP BY c.customer_id, c.name;

-- List all drivers' names and their assigned cab numbers.
SELECT d.name AS driver, c.vehicle_no AS cab_number
FROM Drivers d
JOIN Cabs c ON d.driver_id = c.driver_id;

-- Which cab type has generated the highest revenue so far?
SELECT c.cab_type, SUM(t.fare) AS total_revenue
FROM Cabs c
JOIN Bookings b ON c.cab_id = b.cab_id
JOIN TripDetails t ON b.booking_id = t.booking_id
WHERE b.status = 'Completed'
GROUP BY c.cab_type
ORDER BY total_revenue DESC
LIMIT 1;

--  For each pickup location, what is the average trip distance?
SELECT b.pickup_location, AVG(t.distance_km) AS avg_distance
FROM Bookings b
JOIN TripDetails t ON b.booking_id = t.booking_id
WHERE b.status = 'Completed'
GROUP BY b.pickup_location;

-- Which driver has received the lowest average feedback rating?
SELECT d.driver_id, d.name, AVG(f.rating) AS avg_rating
FROM Drivers d
JOIN Bookings b ON d.driver_id = b.driver_id
JOIN Feedback f ON b.booking_id = f.booking_id
GROUP BY d.driver_id, d.name
ORDER BY avg_rating ASC
LIMIT 1;

-- Find all customers whose last booking was cancelled.
SELECT c.customer_id, c.name
FROM Customers c
JOIN Bookings b ON c.customer_id = b.customer_id
WHERE b.booking_time = (
   SELECT MAX(b2.booking_time)
   FROM Bookings b2
   WHERE b2.customer_id = c.customer_id
)
AND b.status = 'Cancelled';

