create database car_rental_app;
use car_rental_app;

CREATE TABLE Vehicle (
    vehicleID INT  PRIMARY KEY,
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    dailyRate DOUBLE,
    status ENUM('available', 'notAvailable'),
    passengerCapacity INT,
    engineCapacity DOUBLE
);

-- Create Vehicle Table
CREATE TABLE Vehicle (
    vehicleID INT AUTO_INCREMENT PRIMARY KEY,
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    dailyRate DECIMAL(10,2),
    status VARCHAR(15),
    passengerCapacity INT,
    engineCapacity DECIMAL(5,2),
    CONSTRAINT chk_status CHECK (status IN ('available', 'notAvailable'))
);

-- Create Customer Table
CREATE TABLE Customer (
    customerID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(255),
    phoneNumber VARCHAR(20)
);

-- Create Lease Table
CREATE TABLE Lease (
    leaseID INT  PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    type VARCHAR(20),
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

-- Create Payment Table
CREATE TABLE Payment (
    paymentID INT AUTO_INCREMENT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);

-- Insert into Vehicle Table
INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES
    (1, 'Toyota', 'Camry', 2022, 50.00, 'available', 5, 2.5),
    (2, 'Honda', 'Civic', 2021, 45.00, 'available', 5, 2.0),
    (3, 'Ford', 'F-150', 2020, 70.00, 'notAvailable', 3, 3.5);

-- Insert into Customer Table
INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES
    (1, 'Ajay', 'Krishna', 'ajay@yahoo.com', '1234567890'),
    (2, 'Sandheep', 'Kumar', 'sandheep@gmail.com', '9876543210');

-- Insert into Lease Table
INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES
    (1, 1, 1, '2024-05-01', '2024-05-07', 'DailyLease'),
    (2, 2, 2, '2024-05-03', '2024-06-03', 'MonthlyLease');

-- Insert into Payment Table
INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES
    (1, 1, '2024-05-07', 350.00),
    (2, 2, '2024-05-03', 800.00);
