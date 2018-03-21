<%-- 
    Document   : index
    Created on : Feb 9, 2018, 6:18:40 PM
    Author     : Owner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.util.*" errorPage="" %> 
<%@ page import="java.sql.*"%> 
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>dbtesting</title>
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
        <header>
            <a href="index.html"><h4 class="logo">JAZZ CONCERT</h4></a>
            <nav>
                <ul>
                    <li><a href="index.html">HOME</a></li>
                    <li><a class="selected" href="dbtesting.jsp">DbTesting</a></li>
                    <li><a href="purchase.jsp">TICKETS</a></li>
                    <li> <a href="dashboard.jsp">EMPLOYEE DASHBOARD</a></li>
                </ul>
            </nav>
        </header> 
        <h1>JazzY Testing</h1>
        <h2>Select * FROM Customers;</h2>
        <ol>
            <%
                //Get connection create statement
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                boolean isCustomerTableEmpty = true;

                String driver = "org.apache.derby.jdbc.ClientDataSource";
                String url = "jdbc:derby://localhost:1527/db;user=username;password=password";

                Class.forName(driver).newInstance();
                con = DriverManager.getConnection(url);
                stmt = con.createStatement();

                //ExectueSQL: get all state from customers
                String query = "SELECT * FROM CUSTOMERS"; //Send query to the database and store result in ResultSet         
                rs = stmt.executeQuery(query);
                while (rs.next()) {             //If we enter into the while, the ResultSet wasn't empty             
                    isCustomerTableEmpty = false;
            %> 
            <li>Customer ID: 
                <%=rs.getString("CustomerID")%>                         
                first Name :                  
                <%=rs.getString("CustFirstName")%>                  
                Last Name :                 
                <%=rs.getString("CustLastName")%>  
                Address :                
                <%=rs.getString("CustAddress")%>  
                City :                 
                <%=rs.getString("CustCity")%>  
                State :                 
                <%=rs.getString("CustState")%>  
                Zip :                 
                <%=rs.getString("CustZip")%>  
                Email :                 
                <%=rs.getString("CustEmail")%>  <br> 
            </li>                     
            <% }
                if (isCustomerTableEmpty) {
            %>         
            <li>The Customers Table is Empty</li>
                <%
                    }
                %> 
        </ol>

        <h2>Select * FROM Orders;</h2>
        <ol>
            <%
                boolean isOrdersTableEmpty = true;

                String query2 = "SELECT * FROM Orders"; //Send query to the database and store result in ResultSet         
                rs = stmt.executeQuery(query2);
                while (rs.next()) {             //If we enter into the while, the ResultSet wasn't empty             
                    isOrdersTableEmpty = false;
            %> 
            <li>Order ID: 
                <%=rs.getString("OrderID")%>                     
                Customer ID :                  
                <%=rs.getString("CustomerID")%>                   
                OrderDate :                 
                <%=rs.getString("OrderDate")%>
                ShipCost :                 
                <%=rs.getString("ShipCost")%>
                AquisitionFee :                 
                <%=rs.getString("AquisitionFee")%>
                TotalBill :                 
                <%=rs.getString("TotalBill")%>
                <br>            
            </li>                      
            <% }
                if (isOrdersTableEmpty) {
            %>         
            <li>The Orders Table is Empty</li>
                <%
                    }
                %> 
        </ol>

        <h2>Select * FROM OrderItems;</h2>
        <ol>
            <%
                boolean isOrdersItemsTableEmpty = true;

                String query3 = "SELECT * FROM OrderItems"; //Send query to the database and store result in ResultSet         
                rs = stmt.executeQuery(query3);
                while (rs.next()) {             //If we enter into the while, the ResultSet wasn't empty             
                    isOrdersItemsTableEmpty = false;
            %> 
            <li>Order ID: 
                <%=rs.getString("OrderID")%>                     
                Item Number:                  
                <%=rs.getString("ItemNumber")%>                   
                Ticket Section :                 
                <%=rs.getString("TicketSection")%>
                Quantity :                 
                <%=rs.getString("Quantity")%>           
            </li>                      
            <% }
                if (isOrdersItemsTableEmpty) {
            %>         
            <li>The Orders Table is Empty</li>
                <%
                    }
                %> 
        </ol>

    </body>
</html>
