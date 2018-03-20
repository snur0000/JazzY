/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Owner
 * Created: Feb 9, 2018
 */

drop table OrderItems;
drop table Orders;
drop table Customers;
drop table Tickets;

CREATE TABLE Tickets
	(TicketSection INTEGER,
	Cost INTEGER,
	MaxAvailable INTEGER,
	PRIMARY KEY(TicketSection)
	);
	
CREATE TABLE Customers
	(CustomerID  INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1000, INCREMENT BY 1),
	CustLastName VARCHAR(10) NOT NULL,
	CustFirstName VARCHAR(10) NOT NULL,
	CustAddress VARCHAR(20),
	CustCity VARCHAR(12),
	CustState VARCHAR(2),
	CustZip VARCHAR(5),
	CustEmail VARCHAR(30),
	PRIMARY KEY(CustomerID)
	);

CREATE TABLE Orders
	(OrderID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 100, INCREMENT BY 1),
	CustomerID INTEGER references Customers(CustomerID),
	OrderDate DATE NOT NULL,
	ShipCost FLOAT,
	AquisitionFee FLOAT,
        TotalBill FLOAT,	
        PRIMARY KEY(OrderID)
	);

CREATE TABLE ORDERITEMS
	(OrderID INTEGER references Orders(OrderID),
	 ItemNumber INTEGER,
	 TicketSection INTEGER references Tickets(TicketSection),
	 Quantity INTEGER,
	 PRIMARY KEY (OrderID, ItemNumber)
	);

--REFERENCE TABLE VALUES--
    INSERT INTO Tickets VALUES (1,50,75);
    INSERT INTO Tickets VALUES (2,40,75);
    INSERT INTO Tickets VALUES (3,30,75);       
