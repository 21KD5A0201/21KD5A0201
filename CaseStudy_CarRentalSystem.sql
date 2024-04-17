create database CarRentalSystem
create table Vehicle(
Vehicle_Id int primary key,
Make varchar(30) not null,
Model varchar(20) not null,
V_Year int,
DailyRate decimal(10,2),
V_Status varchar(20) check (V_Status in ('available','not available')),
PassengerCapacity int,
EngineCapacity int not null)
create table Customer(
Customer_Id int primary key,
First_Name varchar(20) not null,
Last_Name varchar(50) not null,
Email varchar(50) not null,
PhoneNumber varchar(15)) 
create table Lease(
Lease_Id int primary key,
Vehicle_Id int  foreign key references Vehicle(Vehicle_Id),
Customer_Id int foreign key references Customer(Customer_Id),
StartDate date,
EndDate date,
Lease_Type varchar(50) check (Lease_Type in ('Daily Lease', 'Monthly Lease')))
create table Payment(
Payment_Id int primary key,
Lease_Id int foreign key references Lease(Lease_Id),
PaymentDate date,
Amount decimal(10,2))
insert into Vehicle values('1','Ford', 'Fusion', '2022',' 50.00', 'Available','9', '2000'),
('2','Honda', 'Civic', '2024', '70.00', 'Not Available','5','1500'),
('3','Suzuki', 'Civic', '2023', '75.00', 'Available', '7', '3000'),
('4','Toyota', 'Camry', '2021', '50.00', 'Not Available','6',' 2000'),
('5','Ford', 'Fusion', '2022',' 50.00', 'Available','9', '2000'),
('6','Honda', 'Civic', '2024', '70.00', 'Not Available','5','1500'),
('7','Suzuki', 'Civic', '2023', '75.00', 'Available', '7', '3000'),
('8','Toyota', 'Camry', '2021', '50.00', 'Not Available','6',' 2000'),
('9', 'Toyota', 'Camry', '2022', '50.00', 'Available', '8', '2000'),
('10', 'Honda', 'Accord', '2021', '45.00', 'Available', '5', '1800')
insert into Customer values('1','Ann', 'Joseph', 'annjoseph@example.com', '9442301569'),
('2', 'Anu', 'Josh', 'anujosh@example.com', '9265982569'),
('3', 'Anil', 'kumar', 'anilkumar@example.com', '9589753641'),
('4', 'Varun', 'Shah', 'varunshah@example.com', '7894562310'),
('5','Akhil', 'Reddy', 'akhilreddy@example.com', '9485211569'),
('6', 'Mani', 'Kumar', 'manikumar@example.com', '6985423075'),
('7', 'Neelima', 'Devi', 'neelimadevi@example.com', '9865741230'),
('8', 'Naga', 'Lakhshmi', 'nagalakshmi@example.com', '7894568530'),
('9', 'Yuvraj', 'singh', 'yuvrajsingh@example.com', '9458093569'),
('10', 'Sushant', 'Dev', 'dsushant@example.com', '9653457821')
insert into Lease values('1','1','1','2024-03-10','2024-03-15','Daily Lease'),
('2','2','2','2024-03-10','2024-04-10','Monthly Lease'),
('3','3','3','2024-03-20','2024-03-25','Daily Lease'),
('4','4','4','2024-03-14','2024-04-15','Monthly Lease'),
('5','5','5','2024-03-18','2024-03-15','Daily Lease'),
('6','6','6','2024-03-10','2024-04-20','Monthly Lease'),
('7','7','7','2024-03-12','2024-03-17','Daily Lease'),
('8','8','8','2024-03-14','2024-04-05','Monthly Lease'),
('9','9','9','2024-03-20','2024-03-23','Daily Lease'),
('10','10','10','2024-03-14','2024-04-18','Monthly Lease')
insert into Payment values('1','1','2024-03-15','10000'),
('2','2','2024-03-19','25000.50'),
('3','3','2024-03-25','17500'),
('4','4','2024-03-20','36000'),
('5','5','2024-03-15','10000'),
('6','6','2024-03-22','25000.50'),
('7','7','2024-03-26','17500'),
('8','8','2024-04-17','36000'),
('9','9','2024-03-29','17500'),
('10','10','2024-04-05','36000')
select * from Vehicle
select * from Customer
select * from Lease
select * from Payment
