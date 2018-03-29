<%-- 
    Document   : dashboard.jsp
    Created on : Feb 12, 2018, 8:28:51 AM
    Author     : Team Jazzy
    Purpose    : Query reports and display information for user. 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.util.*" errorPage="" %> 
<%@page import="java.sql.*"%> 

<html lang="en-US">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Jazz Concert</title>
        <link href="css/jazz_style.css" rel="stylesheet" type="text/css">
        <!-- <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600" rel="stylesheet"> -->
        <link href="css/googlefonts.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <% //establish connection and get the HTTP method
            getConnection();
            String method = "";
            method = request.getMethod();
        %>
        <header>
            <a href="index.html"><h4 class="logo">JAZZ CONCERT</h4></a>
            <nav>
                <ul>
                    <li><a href="index.html">HOME</a></li>
                    <li><a href="purchase.jsp">TICKETS</a></li>
                    <li><a class="selected"href="dashboard.jsp">EMPLOYEE DASHBOARD</a></li>
                </ul>
            </nav>
        </header>


        <div class="tables-dashboard">
            <div class="table01 float-l">
                <h2>Tickets Sold</h2>
                <%!
                    private int queryTicketsSold(int section) {
                        int totalTicketsSold = 0;
                        String query = "Select SUM(Quantity) from ORDERITEMS where ticketsection = " + section + "";
                        try {
                            preparedStatement = con.prepareStatement(query);
                            ResultSet rs = preparedStatement.executeQuery();
                            totalTicketsSold = Integer.parseInt(getFirstField(rs));
                        } catch (Exception e) {
                        } finally {
                        }
                        return totalTicketsSold;
                    }
                %>
                <table width="400" cellspacing="2" cellpadding="2">
                    <tbody>
                        <tr>
                            <th scope="col">Seating Category</th>
                            <th scope="col">Number of Tickets Sold</th>
                        </tr>
                        <tr>
                            <th scope="row">Category 1</th>
                            <td><%= queryTicketsSold(1)%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 2</th>
                            <td><%= queryTicketsSold(2)%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 3</th>
                            <td><%= queryTicketsSold(3)%></td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="table01 float-r">
                <h2>Tickets Remaining</h2>
                <%!
                    private int queryTicketsRemaining(int category) {
                        int ticketsRemaining = 0, ticketsSold = queryTicketsSold(category);
                        String query = "Select MaxAvailable From Tickets where ticketSection = " + category + "";
                        try {
                            preparedStatement = con.prepareStatement(query);
                            ResultSet rs = preparedStatement.executeQuery();
                            int maxTicketsAvailable = Integer.parseInt(getFirstField(rs));
                            ticketsRemaining = maxTicketsAvailable - ticketsSold;
                        } catch (Exception e) {
                        } finally {
                        }
                        return ticketsRemaining;
                    }
                %>
                <table cellspacing="2" cellpadding="2">
                    <tbody>
                        <tr>
                            <th scope="col">Seating Category</th>
                            <th scope="col">Number of Tickets Remaining</th>
                        </tr>
                        <tr>
                            <th scope="row">Category 1</th>
                            <td><%= queryTicketsRemaining(1)%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 2</th>
                            <td><%= queryTicketsRemaining(2)%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 3</th>
                            <td><%= queryTicketsRemaining(3)%></td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="table01 float-l">
                <h2>Sales by Category</h2>
                <%!
                    private double queryRevenuePartial(int category) {
                        double revenueByCategory = 0;
                        String query = "Select SUM((Select Cost From Tickets where ticketSection = " + category + ")*Quantity)"
                                + " from ORDERITEMS where ticketsection = " + category + "";
                        try {
                            preparedStatement = con.prepareStatement(query);
                            ResultSet rs = preparedStatement.executeQuery();
                            revenueByCategory = Double.parseDouble(getFirstField(rs));
                        } catch (Exception e) {
                        } finally {
                        }
                        return revenueByCategory;
                    }
                %>
                <table cellspacing="2" cellpadding="2">    
                    <tbody>
                        <tr>
                            <th scope="col">Seating Category</th>
                            <th scope="col"> Sales </th>
                        </tr>
                        <tr>
                            <th scope="row">Category 1</th>
                            <td>$<%= queryRevenuePartial(1)%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 2</th>
                            <td>$<%= queryRevenuePartial(2)%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 3</th>
                            <td>$<%= queryRevenuePartial(3)%></td>
                        </tr>
                    </tbody>
                </table>

            </div>

            <div class="table01 float-r">
                <h2>Total Sales</h2>
                <%!
                    private double queryRevenueTotal() {
                        double totalRevenue = 0;
                        String query = "Select SUM(TotalBill) From ORDERS";
                        try {
                            preparedStatement = con.prepareStatement(query);
                            ResultSet rs = preparedStatement.executeQuery();
                            totalRevenue = Double.parseDouble(getFirstField(rs));
                        } catch (Exception e) {
                        } finally {
                        }
                        return totalRevenue;
                    }
                %>
                <table cellspacing="2" cellpadding="2">
                    <tbody>
                        <tr>
                            <th scope="row">Total Sales (USD)</th>
                            <td width="220">$<%= queryRevenueTotal()%></td>
                        </tr>
                    </tbody>
                </table>        
            </div>
            <%
                if (method.equalsIgnoreCase("POST")) {
                    //drop all tables
                    dropTableOrdersItems();
                    dropTableOrders();
                    dropTableCustomers();
                    dropTableTickets();
                    dropTablePurchaseOptionData();
                    //re-create all tables
                    createTableTickets();
                    createTableCustomers();
                    createTableOrders();
                    createTableOrderItems();
                    createTablePurchaseOptionsData();
                    //insert System Requirements Specification Data
                    InsertSRSTicketData();
                    InsertSRSPurchaseOptionData();
            %>
            <p class="warning">Database has been reset. Hit refresh to see up-to-date report.</p>
            <form method="GET" action="dashboard.jsp">
                <input class='btn-link' value='Refresh' type='submit'>  
            </form>
            <%
                }
            %>
            <%
                if(method.equalsIgnoreCase("GET")){
            %>
            <form method="POST" action="dashboard.jsp">
                <input class='btn-link' value='Reset Database' type='submit'>  
            </form>
            <%
                }
            %>
        </div>        
        <div class="copyright">
             <a href="dbtesting.jsp" class="hiddenlink">&copy;2018 JazzY</a>
        </div>
    </body>

</html>

<%!
    //Global Variables
    private Connection con;
    private PreparedStatement preparedStatement;
    private Statement stmt;

    private void getConnection() {
        try {
            String driver = "org.apache.derby.jdbc.ClientDataSource";
            String url = "jdbc:derby://localhost:1527/jazzydb;user=app;password=password";
            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(url);
            stmt = con.createStatement();
        } catch (Exception e) {
        } finally {
        }
    }

    private String getFirstField(ResultSet rs) {
        String temp = "0";
        try {
            while (rs.next()) {
                temp = rs.getString(1);
            }
        } catch (Exception e) {
        } finally {
        }
        return temp;
    }
%>

<%! // Data Management Drop Table Only Methods

    private void dropTableOrdersItems() {
        String query = "drop table OrderItems";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }

    private void dropTableOrders() {
        String query = "drop table Orders";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }

    private void dropTableCustomers() {
        String query = "drop table Customers";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }

    private void dropTableTickets() {
        String query = "drop table Tickets";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }

    private void dropTablePurchaseOptionData() {
        String query = "drop table PurchaseOptionData";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }
%> 

<%! // Data Management Create Table Only Methods

    private void createTableTickets() {
        String query = "CREATE TABLE Tickets"
                + "(TicketSection INTEGER,"
                + "Cost INTEGER,"
                + "MaxAvailable INTEGER,"
                + "PRIMARY KEY(TicketSection)"
                + ")";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }

    private void createTableCustomers() {
        String query = "CREATE TABLE Customers "
                + "(CustomerID  INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1000, INCREMENT BY 1),"
                + "CustLastName VARCHAR(10) NOT NULL,"
                + "CustFirstName VARCHAR(10) NOT NULL,"
                + "CustAddress VARCHAR(20),"
                + "CustCity VARCHAR(12),"
                + "CustState VARCHAR(2),"
                + "CustZip VARCHAR(5),"
                + "CustEmail VARCHAR(30),"
                + "PRIMARY KEY(CustomerID)"
                + ")";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }

    private void createTableOrders() {
        String query = "CREATE TABLE Orders"
                + "(OrderID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 100, INCREMENT BY 1),"
                + "CustomerID INTEGER references Customers(CustomerID),"
                + "OrderDate DATE NOT NULL,"
                + "ShipCost Decimal(10,2),"
                + "AquisitionFee Decimal(10,2),"
                + "TotalBill Decimal(10,2),"
                + "PRIMARY KEY(OrderID)"
                + ")";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }

    private void createTableOrderItems() {
        String query = "CREATE TABLE OrderItems"
                + "(OrderID INTEGER references Orders(OrderID),"
                + "ItemNumber INTEGER,"
                + "TicketSection INTEGER references Tickets(TicketSection),"
                + "Quantity INTEGER,"
                + "PRIMARY KEY (OrderID, ItemNumber)"
                + ")";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }

    private void createTablePurchaseOptionsData() {
        String query = "CREATE TABLE PurchaseOptionData"
                + "(ShippingFee Decimal(10,2),"
                + "ProccessingFee Decimal (10,2)"
                + ")";
        try {
            stmt.execute(query);
        } catch (Exception e) {
        } finally {
        }
    }
%> 

<%! // Data Management Create Table Only Methods

    private void InsertSRSTicketData() {
        String query1 = "INSERT INTO Tickets VALUES (1,50,75)";
        try {
            stmt.executeUpdate(query1);
        } catch (Exception e) {
        } finally {
        }
        String query2 = "INSERT INTO Tickets VALUES (2,40,75)";
        try {
            stmt.executeUpdate(query2);
        } catch (Exception e) {
        } finally {
        }
        String query3 = "INSERT INTO Tickets VALUES (3,30,75)";
        try {
            stmt.executeUpdate(query3);
        } catch (Exception e) {
        } finally {
        }
    }

    private void InsertSRSPurchaseOptionData() {
        String query = "INSERT INTO PurchaseOptionData VALUES (5.95, 0.07)";
        try {
            stmt.executeUpdate(query);
        } catch (Exception e) {
        } finally {
        }
    }
%> 
