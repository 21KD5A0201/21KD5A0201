-- lets create our database first
CREATE DATABASE TICKETBOOKINGSYSTEM;
-- now we will use the USE keyword to change the current used db to tbs(ticketbookingsystem)
USE TICKETBOOKINGSYSTEM
-- Lets Create Venu Table
CREATE TABLE venue (
	venue_id  INT PRIMARY KEY,
	venue_name VARCHAR(255),
	address VARCHAR(255)
);
--Lets Create Event Table
CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(255),
    event_date DATE,
    event_time TIME,
    venue_id INT,
    total_seats INT,
    available_seats INT,
    ticket_price DECIMAL(10, 3),
    event_type VARCHAR(50) CHECK (event_type IN ('Movie', 'Sports', 'Concert')),
    booking_id INT
);
--LETS CREATE CUSTOMER TABLE
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(15),
    booking_id INT
);
--LETS CREATE BOOKING TABLE
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT,
    total_cost DECIMAL(10, 2),
    booking_date DATETIME
);


--TASK 2 ---------- Select, Where, Between, AND, LIKE


---1. Insert 10 records into each table
-- Insert sample records into Venu table
INSERT INTO Venue (venue_id, venue_name, address)
VALUES
    (101, 'Park Avenue', 'Pune'),
    (102, 'Grand Plaza', 'Mumbai'),
    (103, 'Royal Palace', 'Rajasthan'),
    (104, 'Auditorium', 'Kolkata'),
    (105, 'Book Center', 'Hyderabad'),
    (106, 'Bus Stand', 'Kashmir'),
    (107, 'Library', 'Jaipur'),
    (108, 'Lotus Park', 'Punjab'),
    (109, 'Blue Resort', 'Haryana'),
    (110, 'Sea House', 'Sikkim');

	select * from Venue;

-- Insert sample records into Event table
INSERT INTO Event (event_id, event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id)
VALUES
    (1, 'Bollywood Night', '2024-03-10', '19:00:00', 1, 200, 150, 1200.00, 'Concert', 1),
    (2, 'Cricket Tournament', '2024-03-15', '15:30:00', 2, 500, 300, 500.00, 'Sports', 2),
    (3, 'Cultural Fest', '2024-03-20', '18:30:00', 3, 300, 200, 1500.00, 'Sports', 3),
    (4, 'Movie Premiere', '2024-03-25', '20:00:00', 4, 150, 100, 800.00, 'Movie', 4),
    (5, 'Rock Concert', '2024-04-05', '21:00:00', 5, 250, 200, 1800.00, 'Concert', 5),
    (6, 'Tech Conference', '2024-04-10', '10:00:00', 6, 100, 80, 2000.00, 'Sports', 6),
    (7, 'Stand-up Comedy', '2024-04-15', '19:30:00', 7, 120, 90, 1000.00, 'Sports', 7),
    (8, 'Classical Music Night', '2024-04-20', '18:00:00', 8, 180, 150, 1600.00, 'Concert', 8),
    (9, 'Flea Market', '2024-04-25', '12:00:00', 9, 200, 180, 500.00, 'Sports', 9),
    (10, 'Dance Performance', '2024-05-01', '17:30:00', 10, 120, 100, 1200.00, 'Sports', 10);
	select * from Event;

-- Insert sample records into Customer table
INSERT INTO Customer (customer_id, customer_name, email, phone_number, booking_id)
VALUES
    (1, 'Anju Patel', 'anjupatel@gmail.com', '9876543210', 1),
    (2, 'Devi Priya', 'devipriya@gmail.com', '8765432109', 2),
    (3, 'Sunil Sharma', 'sharmasunil@gmail.com', '7654321098', 3),
    (4, 'Sagar Kumar', 'skumar@gmail.com', '6543210987', 4),
    (5, 'Rupali Verma', 'rupaliverma@gmail.com', '9752109876', 5),
    (6, 'Naina Patek', 'nainap@gmail.com', '9361098765', 6),
    (7, 'Rajat Kumar', 'rajatkumar@gmail.com', '98480987654', 7),
    (8, 'Pooja Kumari', 'poojakumari@gmail.com', '7848276543', 8),
    (9, 'Ravi Shastri', 'ravishastri@gmail.com', '7848725432', 9),
    (10, 'Vani Shree', 'shreevani@gmail.com', '7848724800', 10);
	select * from Customer
-- Insert sample records into Booking table
INSERT INTO Booking (booking_id, customer_id, event_id, num_tickets, total_cost, booking_date)
VALUES
    (1, 1, 1, 40, 7000.00, '2024-02-05 15:30:00'),
    (2, 2, 2, 30, 8200.00, '2024-02-08 18:45:00'),
    (3, 3, 3, 54, 4000.00, '2024-02-17 10:15:00'),
    (4, 4, 4, 22, 5200.00, '2024-02-20 00:30:00'),
    (5, 5, 5, 51, 10000.00, '2024-02-22 22:00:00'),
    (6, 6, 6, 10, 25000.00, '2024-02-23 16:45:00'),
    (7, 7, 7, 30, 3900.00, '2024-02-23 10:30:00'),
    (8, 8, 8, 22, 7200.00, '2024-02-25 05:15:00'),
    (9, 9, 9, 47, 2500.00, '2024-02-28 19:30:00'),
    (10, 10, 50, 3, 3600.00, '2024-02-29 15:00:00');

	select * from Booking
ALTER TABLE Event
ADD CONSTRAINT EventFVenu FOREIGN KEY (venue_id) REFERENCES Venue(venue_id);

ALTER TABLE Event
ADD CONSTRAINT EventFBooking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE Customer
ADD CONSTRAINT CustomerFBooking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE Booking
ADD CONSTRAINT BookingFCustomer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

ALTER TABLE Booking
ADD CONSTRAINT BookingFEvent FOREIGN KEY (event_id) REFERENCES Event(event_id);

--2. List All Events
Select * From Event;
--3. Events With Available Seats
SELECT event_name [EVENT NAME]
	  ,event_date [EVENT DATE]
	  ,event_type [EVENT TYPE]
	  ,available_seats [AVAILABLE SEATS]
FROM dbo.Event
Where 7 > 0;
--4. Select events with names containing 'cup' modified as %com%
SELECT event_id, event_name
FROM dbo.Event
WHERE event_name LIKE '%com%';

--5. Select events with ticket prices between 1000 and 2500
SELECT event_id, event_name, ticket_price
FROM dbo.Event
WHERE ticket_price BETWEEN 1000 AND 2500;

-- Select events with dates between 'start_date' and 'end_date'
SELECT event_id, event_name, event_date
FROM dbo.Event
WHERE event_date BETWEEN '2024-03-05' AND '2024-03-27';

--7 Select events with available tickets and "Concert" in their name
SELECT event_name,available_seats FROM Event
WHERE (event_name LIKE '%concert%') AND (available_seats > 0);

--9. Retrieve bookings details with booked number of tickets more than 4
SELECT booking_id, customer_id, event_id, num_tickets FROM Booking
WHERE num_tickets>40 ;

--10 Retrieve customer information with phone numbers ending with '000' modified to 0
SELECT *
FROM Customer
WHERE RIGHT(phone_number, 1) = '0';

--11. Retrieve events with seat capacity more than 15000 in ascending order modified to 150
SELECT event_id, event_name, total_seats
FROM Event
WHERE total_seats > 250
ORDER BY total_seats ASC;

--12 Select events whose names do not start with 'x', 'y', or 'z'
SELECT event_id, event_name
FROM Event
WHERE NOT (event_name LIKE 'x%' OR event_name LIKE 'y%' OR event_name LIKE 'z%');



-----TASK 3-----Aggregate functions, Having, Order By, GroupBy and Joins

---1.List Events and Their Average Ticket Prices:

SELECT event_name, AVG(ticket_price) AS avg_ticket_price
FROM Event
GROUP BY event_name;

---2.Calculate the Total Revenue Generated by Events:
SELECT event_name, SUM(total_cost) AS total_revenue
FROM Booking
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name;

--3.Find the Event with the Highest Ticket Sales:
SELECT TOP 1 event_name, SUM(num_tickets) AS total_tickets_sold
FROM Booking
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name
ORDER BY total_tickets_sold DESC ;

--4.Calculate the Total Number of Tickets Sold for Each Event:
SELECT event_name, SUM(num_tickets) AS total_tickets_sold
FROM Booking
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name;

--5.Find Events with No Ticket Sales:
SELECT event_name
FROM Event
LEFT JOIN Booking ON Event.event_id = Booking.event_id
WHERE Booking.booking_id IS NULL;

--6.Find the User Who Has Booked the Most Tickets:
SELECT TOP 1 customer_name, SUM(num_tickets) AS total_tickets_booked
FROM Customer
JOIN Booking ON Customer.booking_id = Booking.booking_id
GROUP BY customer_name
ORDER BY total_tickets_booked DESC;

--7.List Events and the Total Number of Tickets Sold for Each Month:
SELECT event_name, MONTH(booking_date) AS month, SUM(num_tickets) AS total_tickets_sold
FROM Booking
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name, MONTH(booking_date);

--8.Calculate the Average Ticket Price for Events in Each Venue:
SELECT venue_name, AVG(ticket_price) AS avg_ticket_price
FROM Event
JOIN Venue ON Event.venue_id = Venue.venue_id
GROUP BY venue_name;

--9.Calculate the Total Number of Tickets Sold for Each Event Type:
SELECT event_type, SUM(num_tickets) AS total_tickets_sold
FROM Event
JOIN Booking ON Event.event_id = Booking.event_id
GROUP BY event_type;

--10.Calculate the Total Revenue Generated by Events in Each Year:
SELECT YEAR(booking_date) AS year, SUM(total_cost) AS total_revenue
FROM Booking
GROUP BY YEAR(booking_date);

USE TICKETBOOKINGSYSTEM
--11.List Users Who Have Booked Tickets for Multiple Events:
SELECT c.customer_id, c.customer_name, COUNT(DISTINCT b.event_id) AS events_booked
FROM Customer c
JOIN Booking b ON c.booking_id = b.booking_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT b.event_id) > 1;
-------------------------------------------------
--12.Calculate the Total Revenue Generated by Events for Each User:
SELECT customer_name, SUM(total_cost) AS total_revenue
FROM Customer
JOIN Booking ON Customer.booking_id = Booking.booking_id
GROUP BY customer_name;

--13.Calculate the Average Ticket Price for Events in Each Category and Venue:
SELECT venue_name, event_type, AVG(ticket_price) AS avg_ticket_price
FROM Event
JOIN Venue ON Event.venue_id = Venue.venue_id
GROUP BY venue_name, event_type;

--14. list Users and the Total Number of Tickets They've Purchased in the Last 30 Days.
SELECT customer_name, SUM(num_tickets) AS total_tickets_purchased
FROM Customer
JOIN Booking ON Customer.booking_id = Booking.booking_id
WHERE booking_date >= DATEADD(DAY, -30, GETDATE())
GROUP BY customer_name;


----------TASK 4-------------------
--1.Calculate the Average Ticket Price for Events in Each Venue Using a Subquery. 
SELECT v.venue_id,v.venue_name,
    (SELECT AVG(e.ticket_price) 
	FROM Event e 
	WHERE e.venue_id = v.venue_id) AS average_ticket_price
FROM Venue v;

--2: Find Events with More Than 50% of Tickets Sold using subquery.
SELECT event_name, (total_seats - available_seats) AS num
FROM Event
WHERE(SELECT SUM(num_tickets) 
	  FROM Booking
	  WHERE Booking.event_id = Event.event_id) > (0.003 * total_seats);
--3.Calculate the Total Number of Tickets Sold for Each Event. 
SELECT e.event_id, e.event_name,
    (SELECT SUM(b.num_tickets) 
	FROM Booking b 
	WHERE b.event_id = e.event_id) AS total_tickets_sold
	FROM Event e;

--4: Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.
SELECT c.customer_name
FROM Customer c
WHERE NOT EXISTS (SELECT 1 FROM Booking WHERE customer_id = c.customer_id);

--5: List Events with No Ticket Sales Using a NOT IN Subquery.
SELECT event_name
FROM Event
WHERE event_id NOT IN (SELECT DISTINCT event_id FROM Booking);

--6.Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause.
SELECT event_type, SUM(subquery.num_tickets) AS total_tickets_sold
FROM ( SELECT Event.event_id, Event.event_type, Booking.num_tickets
FROM Event
JOIN Booking ON Event.event_id = Booking.event_id) AS subquery
GROUP BY event_type;

--7: Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause.
SELECT event_name,ticket_price
FROM Event
WHERE ticket_price > (SELECT AVG(ticket_price) FROM Event);

--8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.
SELECT customer_id,customer_name,
    (SELECT SUM(Booking.total_cost)
     FROM Booking
     WHERE Booking.customer_id = Customer.customer_id) AS total_revenue
FROM Customer;

--9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause. 
SELECT c.customer_name
FROM Customer c
JOIN Booking b ON c.booking_id = b.booking_id
JOIN Event e ON b.event_id = e.event_id
JOIN Venue v ON e.venue_id = v.venue_id
WHERE v.venue_name = 'Epic Center';

--10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY. 
SELECT e.event_type, SUM(b.num_tickets) AS total_tickets_sold
FROM Event e
JOIN Booking b ON e.event_id = b.event_id
GROUP BY e.event_type;

--11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT.
SELECT DISTINCT c.customer_id, c.customer_name, DATENAME (month, b.booking_date) AS booking_month
FROM Customer c
INNER JOIN Booking b ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.customer_name, DATENAME (month, b.booking_date)

--12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery 
SELECT v.venue_id,v.venue_name,
(   SELECT AVG(e.ticket_price) 
	FROM Event e 
	WHERE e.venue_id = v.venue_id) AS average_ticket_price
FROM Venue v;