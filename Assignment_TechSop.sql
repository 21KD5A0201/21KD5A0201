create database TechShop
use TechShop
--Task-1
create table Customers(
Customer_Id int primary key,
First_Name varchar(20),
Last_Name varchar(40),
email varchar(50),
Mobile_number varchar(10),
Customer_Adress varchar(100));
create table Products(
Product_Id int primary key,
Product_Name varchar(20),
Product_Description varchar(50),
Product_Price int);
create table Orders(
Order_Id int primary key, 
Customer_Id int,
Order_Date date,
Total_Amount float
foreign key(Customer_id) references Customers(Customer_Id));
create table OrderDetails(
OrderDetail_Id int primary key,
Order_Id int,
Product_Id int,
Quantity int,
foreign key(Order_Id) references Orders(Order_Id),
foreign key(Product_Id) references Products(Product_Id));
create table Inventory(
Inventory_Id int primary key,
Product_Id int,
Quantity_in_stock int,
Last_stock_update date,
foreign key(Product_Id) references Products(Product_Id));
--exec sp_help Inventory
insert into Customers values('101', 'Ann', 'Joseph', 'annjoseph@example.com', '9442301569', 'Tamilnadu'),
('102', 'Anu', 'Josh', 'anujosh@example.com', '9265982569', 'Tamilnadu'),
('103', 'Anil', 'kumar', 'anilkumar@example.com', '9589753641', 'Andhra Pradesh'),
('104', 'Varun', 'Shah', 'varunshah@example.com', '7894562310', 'Telangana'),
('105', 'Nikhil', 'Naidu', 'nikhilnaidu@example.com', '7845123699', 'Telangana'),
('106', 'Siddardth', 'Shukla', 'siddharthshukla@example.com', '9596874132', 'Andhra Pradesh'),
('107', 'John', 'Mathew', 'johnmathew@example.com', '7758963201', 'Goa'),
('108', 'Meera', 'kumari', 'anilkumar@example.com', '8974563201', 'West Bengal'),
('109', 'Sachin', 'Shah', 'sachinshah@example.com', '7578423020', 'Odisha'),
('110', 'Arvind', 'Singh', 'arvindsingh@example.com', '9896325641', 'Andhra Pradesh')
select * from Customers
insert into Products values('1', 'Mobile','Samsung','10000'),
('2', 'Mobile','Oneplus ','20000'),
('3', 'Air Conditioner','Haier','55000'),
('4', 'Laptop','Dell','70000'),
('5', 'Desktop','Acer','15000'),
('6', 'Earphones','Boat','1000'),
('7', 'Refrridgerator','Panasonic','60000'),
('8', 'Television','Samsung','25000'),
('9', 'Laptop','Lenovo','50000'),
('10', 'Mobile','Infinix','12000')
select * from products
insert into Orders values('1','101','2024-02-10','2000'),
('2','102','2024-02-06','2000'),
('3','103','2024-02-12','1000'),
('4','104','2024-02-24','500'),
('5','105','2024-02-29','2500'),
('6','106','2024-03-01','3000'),
('7','107','2024-02-20','2800'),
('8','108','2024-03-09','1540'),
('9','109','2024-03-18','3200'),
('10','110','2024-03-31','2600')
select * from orders
insert into OrderDetails values('201','1','1','5'),
('202','2','2','13'),
('203','3','3','4'),
('204','4','4','1'),
('205','5','5','3'),
('206','6','6','8'),
('207','7','7','20'),
('208','8','8','20'),
('209','9','9','12'),
('210','10','10','6')
select * from OrderDetails
insert into Inventory values('1','1','200','2024-03-01'),
('2','2','35','2024-03-02'),
('3','3','43','2024-03-20'),
('4','4','26','2024-03-14'),
('5','5','5','2024-03-06'),
('6','6','10','2024-03-04'),
('7','7','250','2024-03-31'),
('8','8','210','2024-03-17'),
('9','9','170','2024-03-16'),
('10','10','50','2024-03-25')
select * from Inventory
--Task-2
--1.Write an SQL query to retrieve the names and emails of all customers.
select First_Name,Last_Name, email from Customers
--2.Write an SQL query to list all orders with their order dates and corresponding customer names
select o.Order_Id,c.First_Name,c.Last_Name,o.Order_Date
from Orders o
join 
Customers c
on o.Customer_Id=c.Customer_Id
--3 . Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
insert into Customers values('111','Deepika','Patil','deepikapatil@example.com','7854129630','Mumbai')
select * from Customers
--4 . Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10% 
update products set Product_Price=1.1*Product_Price
select* from Products
--5 . Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
delete from Orders where Order_Id=4
select * from OrderDetails
select * from Orders
--6 . Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.
insert into Orders values('11','111','2024-03-06','5750')    
select * from Orders
--7 . Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
update Customers set email='janu@example.com', Customer_Adress='Telangana' where Customer_Id=102
select * from Customers
--8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
Update Orders
set Total_Amount=(
Select (od.Quantity*P.Product_Price) from OrderDetails od 
Join Products P ON od.Product_Id=P.Product_Id
where od.Order_Id=Orders.Order_Id)
where Order_Id in(select Order_Id from OrderDetails)
select *from Orders
--9 . Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
delete from Orders where Customer_Id=111
select * from Orders
--10. Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
insert into Products values('12','Refridgerator','LG','15000')
select* from Products
--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
alter table  Orders
add OrderStatus varchar(20)
Select* from Orders
declare @Oid int ,@newstatus varchar(20)
set @Oid=5
set @newstatus='pending';
--user input
update Orders
set OrderStatus=@newstatus
where OrderID=@Oid
--12.Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table
alter table Customers
add No_of_orders int 
select* from Customers
update Customers
set No_of_orders=(
select COUNT(*)
from Orders O 
where Customers.Customer_Id=O.Customer_Id 
Group By O.Customer_Id
)
----------------------Task-3-------------------------
--1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.
select Order_Id, Total_Amount,Concat (First_Name,' ',Last_Name) as CustomerNames
from Orders O,Customers C
where O.Customer_Id=C.Customer_Id
---2. Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue
select Product_Name, SUM(Product_Price*Quantity) as Total_revenue
from Products ,OrderDetails
group by Product_Name
----3. Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
select  concat (First_Name,' ', Last_Name) as CustomerNames,Mobile_number from Customers c
Join Orders O on 
c.Customer_Id=O.Customer_Id
Join OrderDetails od 
on O.Order_Id=od.Order_Id and od.Quantity >= 1
select*from Customers
----4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
select top 1 Product_Name,SUM (Quantity) as Total_quantity 
from Products P,OrderDetails 
where OrderDetails.Product_Id=P.Product_Id
group by Product_Name
Order by Total_quantity desc
select* from Products
--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.--1st giving values to category column in Products
select* from Products
alter table  Products
add Category varchar(20)
update Products set Category = case 
WHEN Product_Name ='Laptop' THEN 'Computer Devices'
WHEN Product_Name = 'Mobile' THEN 'Mobile Devices'
WHEN Product_Name = 'Air Conditioner' THEN 'Luxury Devices'
WHEN Product_Name = 'Refridgerator' THEN 'Luxury Devices'
WHEN Product_Name = 'Television' THEN 'Entertainment'
WHEN Product_Name = 'Earphones' THEN 'Audio Devices'
WHEN Product_Name = 'Desktop' THEN 'Computer Devices'
ELSE NULL
END
--2nd list electronic gadgets along with their corresponding categories
select Product_Name as Electronic_gadgets,Category
from Products

--6. Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value
select concat(First_Name,' ',Last_Name) as CustomerNames,
sum (O.Total_Amount)/Count(od.Quantity) as Average_order_value
from Customers C
join Orders O on C.Customer_Id=O.Customer_Id
join OrderDetails od on  O.Order_Id=od.Order_Id
group by concat (First_Name,' ',Last_Name)
--7. Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
select Top 1 Order_Id ,CONCAT(First_Name,' ',Last_Name) as CustomerNames,Email,Phone,Address,No_of_orders,Total_Amount as TotalRevenue
from Orders O,Customers C
where O.Customer_Id=C.Customer_Id
Order By TotalRevenue desc
--8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
select Product_Name as Electronic_gadgets,SUM(Quantity) as No_of_times
from Products P,OrderDetails od
where P.Product_Id=od.Product_Id
group by Product_Name
--9. Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
select*from Products
select *from Customers
select*from Orders
declare @Product_Name varchar(20)
set @Product_Name='Mobile'
select P. Product_Name,concat(First_Name,' ',Last_Name) as CustomerNames
from Products ,Customers c
join Orders o on c.Customer_Id=o.Customer_Id
join OrderDetails od on O.Order_Id=od.Order_Id
join Products P on od.Product_Id=P.Product_Id
group by concat(First_Name,' ',Last_Name),P.Product_Name
having P.Product_Name=@Product_Name
--10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
declare @start date,@end  date
set @start='2024-02-25'
set @end=getdate()
select Sum(Product_Price*Quantity) as Total_Revenue,o.Order_Date
from Products P,Orders
join OrderDetails od on Product_Id=od.Product_Id
join Orders o on od.Order_Id=o.Order_Id
where O.Order_Date between @start and @end
group by O.Order_Date
-------------- Task-4----------------------
--1. Write an SQL query to find out which customers have not placed any orders.
select concat(First_Name,' ',Last_Name)  as CustomersNames
from Customers
where Customer_Id not in (select Customer_Id from Orders O where O.Customer_Id=Customers.Customer_Id)
--2. Write an SQL query to find the total number of products available for sale.
select sum( Quantity_in_stock) as Total_No_products from Inventory
select * from Inventory
--3. Write an SQL query to calculate the total revenue generated by TechShop.*/
select sum(Total_Amount) as Total_Revenue from Orders
select * from Orders
--4. Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.
declare @category varchar(50)= 'Computer Devices'
select AVG(Orderdetails.Quantity) AS Average_Quantity_Ordered, Products.Category FROM OrderDetails 
join Products  ON Orderdetails.Product_Id = Products.Product_Id WHERE Products.Category = @category
GROUP BY Products.Category
--5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
select*from Orders
declare @CustomerID int=2
select SUM(Product_Price* Quantity) as Total_revenue from (select Customer_Id,Quantity, Product_Price 
from Orders O 
Join OrderDetails od on O.Order_Id=od.Order_Id
join Products P on od.Product_Id=P.Product_Id
where O.Customer_Id=@CustomerID) as SubQuery
--6. Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.
select  First_Name,Sum(Quantity) as No_of_order from Customers c
join Orders O on c.Customer_Id=O.Customer_Id
join OrderDetails od on O.Order_Id=od.Order_Id
group by First_Name
having sum(Quantity)=(select Max(Total_Quantity) from (select sum(Quantity) as Total_Quantity from OrderDetails group by Order_Id )as Subquery)
--7. Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
select top 1  Category , SUM(Quantity) as total_quantity from Products P
join OrderDetails od on  P.Product_Id=od.Product_Id
group by Category
order by total_quantity desc
--8. Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
select top 1 concat(First_Name,' ',Last_Name) as CustomerNames, Total_Amount as Highest_Total_Revenue
from Customers c 
join Orders O on c.Customer_Id=O.Customer_Id
group by concat(First_Name,' ',Last_Name),Total_Amount
order by Highest_Total_Revenue desc 
--9. Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers
select c.Customer_ID, First_Name, sum(Product_Price*Quantity)/No_of_orders as Average_order_value
from Customers c 
Join Orders O on c.Customer_Id=O.Customer_Id
join OrderDetails od on O.Order_Id=od.Order_Id
join Products P on od.Product_Id=P.Product_Id
group by c.Customer_Id,First_Name,No_of_orders

select*from Customers
select* from Orders
--10. Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count.
select First_Name ,(select count(*) as Orders_count from Orders O where O.Customer_Id=c.Customer_Id)
from Customers c
