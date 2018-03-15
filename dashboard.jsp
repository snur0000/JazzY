<%-- 
    Document   : dashboard
    Created on : Feb 12, 2018, 8:28:51 AM
    Author     : Owner Batman
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

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
              <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
            <![endif]-->
    </head>
    <body>

        <%
            //create connection
            Connection con = null;
            Statement stmt = null;
            String driver = "org.apache.derby.jdbc.ClientDataSource";
            String url = "jdbc:derby://localhost:1527/db;user=username;password=password";
            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(url);
            stmt = con.createStatement();

            //variables
            int totalNumberTicketsSoldI = 0;
            int totalNumberTicketsSoldII = 0;
            int totalNumberTicketsSoldIII = 0;

            ResultSet rs = stmt.executeQuery("Select SUM(Quantity) from ORDERITEMS where ticketsection = 1");
            while (rs.next()) {
                try {
                    totalNumberTicketsSoldI = Integer.parseInt(rs.getString(1));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
            }

            ResultSet rs2 = stmt.executeQuery("Select SUM(Quantity) from ORDERITEMS where ticketsection = 2");
            while (rs2.next()) {
                try {
                    totalNumberTicketsSoldII = Integer.parseInt(rs2.getString(1));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
            }

            ResultSet rs3 = stmt.executeQuery("Select SUM(Quantity) from ORDERITEMS where ticketsection = 3");
            while (rs3.next()) {
                try {
                    totalNumberTicketsSoldIII = Integer.parseInt(rs3.getString(1));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
            }

            //variables
            int seatsRemainingI = 0;
            int seatsRemainingII = 0;
            int seatsRemainingIII = 0;
            
            ResultSet rs4 = stmt.executeQuery("Select (Select MaxAvailable From Tickets where ticketSection = 1)-SUM(Quantity) from ORDERITEMS where ticketsection = 1");
            while (rs4.next()) {
                try {
                    seatsRemainingI = Integer.parseInt(rs4.getString(1));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
            }
            
            ResultSet rs5 = stmt.executeQuery("Select (Select MaxAvailable From Tickets where ticketSection = 2)-SUM(Quantity) from ORDERITEMS where ticketsection = 2");
            while (rs5.next()) {
                try {
                    seatsRemainingII = Integer.parseInt(rs5.getString(1));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
            }
            
            ResultSet rs6 = stmt.executeQuery("Select (Select MaxAvailable From Tickets where ticketSection = 3)-SUM(Quantity) from ORDERITEMS where ticketsection = 3");
            while (rs6.next()) {
                try {
                    seatsRemainingIII = Integer.parseInt(rs6.getString(1));
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }
            }

        %>

        <header>
            <a href="index.html"><h4 class="logo">JAZZ CONCERT</h4></a>
            <nav>
                <ul>
                    <li><a href="index.html">HOME</a></li>
                    <li><a href="dbtesting.jsp">DbTesting</a></li>
                    <li><a href="purchase.jsp">TICKETS</a></li>
                    <li><a class="selected"href="dashboard.jsp">EMPLOYEE DASHBOARD</a></li>
                </ul>
            </nav>
        </header>
        <div class="tables-dashboard">
            <div class="table01 float-l">
                <h2>Tickets Sold</h2>
                <table width="400" cellspacing="2" cellpadding="2">
                    <tbody>
                        <tr>
                            <th scope="col">Seating Category</th>
                            <th scope="col">Number of Tickets Sold</th>
                        </tr>
                        <tr>
                            <th scope="row">Category 1</th>
                            <td><%= totalNumberTicketsSoldI%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 2</th>
                            <td><%= totalNumberTicketsSoldII%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 3</th>
                            <td><%= totalNumberTicketsSoldIII%></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="table01 float-r">
                <h2>Tickets Remaining</h2>
                <table cellspacing="2" cellpadding="2">
                    <tbody>
                        <tr>
                            <th scope="col">Seating Category</th>
                            <th scope="col">Number of Tickets Remaining</th>
                        </tr>
                        <tr>
                            <th scope="row">Category 1</th>
                            <td><%= seatsRemainingI%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 2</th>
                            <td><%= seatsRemainingII%></td>
                        </tr>
                        <tr>
                            <th scope="row">Category 3</th>
                            <td><%= seatsRemainingIII%></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="table01 float-l">
                <h2>Sales by Category</h2>
                <table cellspacing="2" cellpadding="2">
                    <tbody>
                        <tr>
                            <th scope="col">Seating Category</th>
                            <th scope="col"> Sales (USD)</th>
                        </tr>
                        <tr>
                            <th scope="row">Category 1</th>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <th scope="row">Category 2</th>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <th scope="row">Category 3</th>
                            <td>&nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="table01 float-r">
                <h2>Total Sales</h2>
                <table cellspacing="2" cellpadding="2">
                    <tbody>
                        <tr>
                            <th scope="row">Total Sales (USD)</th>
                            <td width="220">&nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>



        <div class="copyright">
            &copy;2018 some company
        </div>
    </body>

</html>

