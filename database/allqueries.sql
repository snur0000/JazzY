/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Owner
 * Created: Feb 9, 2018
 */

/*Queries Total Sales All Categories*/
Select SUM(Quantity*Cost) from OrderItems JOIN Tickets USING(TicketSection);
/*Total Quantity of Tickets Sold in Category 1*/
Select SUM(Quantity) from ORDERITEMS where ticketsection = 1;
/*Remaining Available Seats in Category 1*/
Select (Select MaxAvailable From Tickets where ticketSection = 1)-SUM(Quantity) from ORDERITEMS where ticketsection = 1;
/*Total base Cost of all tickets sold from category I*/
Select SUM(Quantity*Cost) from OrderItems JOIN Tickets USING(TicketSection) WHERE TicketSection = 1;
/*Total Sales I = (TbcI*(1- + TshippingcostI + 

/*Remaining Available Seats in Category 2*/
Select (Select MaxAvailable From Tickets where ticketSection = 2)-SUM(Quantity) from ORDERITEMS where ticketsection = 2;
Select SUM(Quantity*Cost) from OrderItems JOIN Tickets USING(TicketSection) WHERE TicketSection = 2;
/*Total Quantity of Tickets Sold in Category 3*/
Select SUM(Quantity) from ORDERITEMS where ticketsection = 3;
/*Remaining Available Seats in Category 3*/
Select (Select MaxAvailable From Tickets where ticketSection = 3)-SUM(Quantity) from ORDERITEMS where ticketsection = 3;
Select SUM(Quantity*Cost) from OrderItems JOIN Tickets USING(TicketSection) WHERE TicketSection = 3;

/*Queries the Max Available Seats per Ticket Section*/
Select MaxAvailable From Tickets where ticketSection = 1;
