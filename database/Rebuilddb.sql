drop table OrderDetails;
drop table Orders;
drop table Customers;
drop table Tickets;

CREATE TABLE Customers
	(CustomerID  INTEGER,
	CustLastName VARCHAR(10) NOT NULL,
	CustFirstName VARCHAR(10) NOT NULL,
	CustAddress VARCHAR(20)NOT NULL,
	CustCity VARCHAR(12)NOT NULL,
	CustState VARCHAR(2)NOT NULL,
	CustZip VARCHAR(5)NOT NULL,
	CustEmail VARCHAR(30)NOT NULL,
	PRIMARY KEY(CustomerID)
	);

CREATE TABLE Tickets
	(TicketNumber INTEGER,
     TicketSection INTEGER,
	 TicketCost INTEGER,
	 MaxAvailable INTEGER,
	PRIMARY KEY(TicketNumber)
	);
	
CREATE TABLE Orders
	(OrderID INTEGER,
	CustomerID INTEGER references Customers(CustomerID),
	OrderDate DATE default sysdate,
	ShipCost NUMBER(8,2) DEFAULT '0.00',
	AquisitionFee NUMBER(8,2) DEFAULT '0.00',
	OrderTotal as shipCost + aquisitionfee + ticket cost, 
	PRIMARY KEY(OrderID));
  
CREATE TABLE OrderDetails
	 (OrderID INTEGER references Orders,
	 TicketNumber INTEGER references TICKETS,
	 TicketQty INTEGER,
	 PRIMARY KEY (OrderID, TicketNumber));
