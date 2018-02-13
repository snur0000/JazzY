<%-- 
    Document   : purchase
    Created on : Feb 9, 2018, 6:40:39 PM
    Author     : Owner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.util.*" errorPage="" %> 
<%@page import="java.sql.*"%> 

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--        <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Jazz Concert</title>
        <link href="css/jazz_style.css" rel="stylesheet" type="text/css">
        <!-- <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600" rel="stylesheet"> -->
        <link href="css/googlefonts.css" rel="stylesheet" type="text/css">    
    </head>
    <body>
        <%
            String method = "";
            method = request.getMethod();

            if (method.equalsIgnoreCase("POST")) {
                //get customer information
                String firstName = request.getParameter("First_Name");
                String lastName = request.getParameter("Last_Name");
                String address = request.getParameter("Address");
                String city = request.getParameter("City");
                String state = request.getParameter("State");
                String zip = request.getParameter("Zip");
                String email = request.getParameter("Email");

                //get order information
                int currentCustomerID = 100; //to be determined with query
                String orderDate = "2018-01-25"; //TODO SE core api new dateNow()
                final double SHIPPING_COST = 5.95;
                final double ACQUISTION_FEE = 0.7;
                double shipCost = 0; //to be determined with boolean
                double aquisitionFee = 0; //to be determined with boolean

                //get ticket information
                int currentOrderID = 100; //to be determined with query
                int itemNumberCounter = 1;
                final int TICKET_SECTION_I = 1;
                final int TICKET_SECTION_II = 2;
                final int TICKET_SECTION_III = 3;
                int ticketQuantityI = Integer.parseInt(request.getParameter("Category_One"));
                int ticketQuantityII = Integer.parseInt(request.getParameter("Category_Two"));
                int ticketQuantityIII = Integer.parseInt(request.getParameter("Category_Three"));

                //create connection
                Connection con = null;
                Statement stmt = null;
                String driver = "org.apache.derby.jdbc.ClientDataSource";
                String url = "jdbc:derby://localhost:1527/jazzydb;user=app;password=password";
                Class.forName(driver).newInstance();
                con = DriverManager.getConnection(url);
                stmt = con.createStatement();

                //InsertSQL: insert customer information, Must Do First
                String newCustomerInsert = "INSERT INTO CUSTOMERS VALUES( default, '" + lastName + "', '" + firstName + "', '" + address + "', "
                        + "'" + city + "', '" + state + "', '" + zip + "', '" + email + "')";
                stmt.executeUpdate(newCustomerInsert);
                //ExecuteSQL: get current customerID, to use as foreign key
                ResultSet rs = stmt.executeQuery("SELECT MAX(CustomerID) FROM Customers");
                while (rs.next()) {
                    currentCustomerID = Integer.parseInt(rs.getString(1));
                }
                //InsertSQL: insert order information using the foreign key CustomerID
                try {
                    if (request.getParameter("Radio").equals("Shipping")) {
                        shipCost = SHIPPING_COST; //if it is shipping
                    }
                } catch (Exception ex) {
                    System.out.println("ERROR: " + ex.getMessage());
                };
                try {
                    if (!request.getParameter("Radio").equals("Reserve")) {
                        aquisitionFee = ACQUISTION_FEE; //if it is NOT reserve
                    }
                } catch (Exception ex) {
                    System.out.println("ERROR: " + ex.getMessage());
                };
                String newOrderInsert = "INSERT INTO Orders VALUES(default, " + currentCustomerID + ",'" + orderDate + "', " + shipCost + "," + aquisitionFee + ")";
                stmt.executeUpdate(newOrderInsert);

                //obtain current customerID, to use as foreign key
                ResultSet rs2 = stmt.executeQuery("SELECT MAX(OrderID) FROM Orders");
                while (rs2.next()) {
                    currentOrderID = Integer.parseInt(rs2.getString(1));
                }

                //InsertSQL: insert OrderItems(OrderID foreign key, ItemNumber 1-3, TicketSection, Quantity)         
                String insertI = "INSERT INTO OrderItems" + "(OrderID, ItemNumber, TicketSection, Quantity)"
                        + "VALUES(" + currentOrderID + "," + itemNumberCounter + ", " + TICKET_SECTION_I + "," + ticketQuantityI + ")";
                if (ticketQuantityI > 0) {
                    stmt.executeUpdate(insertI);
                    itemNumberCounter++;
                }
                String insertII = "INSERT INTO OrderItems" + "(OrderID, ItemNumber, TicketSection, Quantity)"
                        + "VALUES(" + currentOrderID + "," + itemNumberCounter + ", " + TICKET_SECTION_II + "," + ticketQuantityII + ")";
                if (ticketQuantityII > 0) {
                    stmt.executeUpdate(insertII);
                    itemNumberCounter++;
                }
                String insertIII = "INSERT INTO OrderItems" + "(OrderID, ItemNumber, TicketSection, Quantity)"
                        + "VALUES(" + currentOrderID + "," + itemNumberCounter + ", " + TICKET_SECTION_III + "," + ticketQuantityIII + ")";
                if (ticketQuantityIII > 0) {
                    stmt.executeUpdate(insertIII);
                }


        %>   

        <%        }
        %> 
        <header>
            <a href="index.html"><h4 class="logo">JAZZ CONCERT</h4></a>
            <nav>
                <ul>
                    <li><a href="index.html">HOME</a></li>
                    <li><a href="dbtesting.jsp">DbTesting</a></li>
                    <li><a class="selected" href="purchase.jsp">TICKETS</a></li>
                    <li> <a href="dashboard.jsp">EMPLOYEE DASHBOARD</a></li>
                </ul>
            </nav>
        </header>
        <div class="table-tickets">
            <h1>Purchase Tickets</h1>
            <form method="POST" action="purchase.jsp">
                <hr>
                <table class="ticket-form" border="0" cellspacing="5" cellpadding="1">
                    <tbody>
                        <!--Ticket Selection -->
                        <tr>
                            <th scope="col">Number of Tickets</th>
                            <th scope="col">Seating Category</th>
                            <th scope="col">Price</th>
                        </tr>
                        <tr>
                            <td><input name="Category_One" type="number" placeholder="Number of Tickets" value="1" min="0" max="75"></td>
                            <td>Category 1 Rows A-C</td>
                            <td>$50</td>
                        </tr>
                        <tr>
                            <td><input name="Category_Two" type="number" placeholder="Number of Tickets" value="0" min="0" max="75"></td>
                            <td>Category 2 Rows D-F</td>
                            <td>$40</td>
                        </tr>
                        <tr>
                            <td><input name="Category_Three" type="number" placeholder="Number of Tickets" value="0" min="0" max="75"></td>
                            <td>Category 3 Rows G-I</td>
                            <td>$30</td>
                        </tr>
                        <!-- Purchase Options -->
                        <tr>
                            <td colspan="3">
                                <hr>
                                <span class="table-heading">Purchase Options</span>
                                <br>
                                <em class="small-print">All online purchases include a 7% conviennence fee.</em>
                                <br>
                            </td>
                        </tr>
                        <tr>  
                            <td colspan="3">
                                <label>
                                    <input type="radio" name="Radio" value="Shipping" id="RadioGroup1_0" checked>
                                    Mail +$5.95 Shipping Fee
                                </label>
                                <br>
                                <label>
                                    <input type="radio" name="Radio" value="Printing" id="RadioGroup1_1">
                                    Print
                                </label>
                                <br>
                                <label>
                                    <input type="radio" name="Radio" value="Pickup" id="RadioGroup1_2">
                                    Pickup at Box Office
                                </label>
                                <br>
                                <label>
                                    <input type="radio" name="Radio" value="Reserve" id="RadioGroup1_3">
                                    Reserve Tickets &nbsp;(pickup and pay at box office - no fees)
                                </label>
                                <br>
                            </td>
                        </tr>
                        <!-- Customer Info -->
                        <tr>      
                            <td colspan="3">
                                <hr>
                                <span class="table-heading">Customer Information</span><br>
                                <em class="small-print">All fields required.</em>
                            </td>
                        </tr>
                    <div class="customer-info-table">
                        <tr>
                            <td colspan="3">
                                <label class="customer-heading">NAME</label><br>
                                <input class="form-names" name="First_Name" type="text" placeholder="First" required>&nbsp;
                                <input class="form-names" name="Last_Name" type="text" placeholder="Last" required>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <label class="customer-heading">ADDRESS</label><br>
                                <input class="form-address" name="Address" type="text" placeholder="Street" required></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <input class="form-city" name="City" type="text" placeholder="City" required>&nbsp;
                                <select class="form-state" name="State">
                                    <option value="AL">Alabama</option>
                                    <option value="AK">Alaska</option>
                                    <option value="AZ">Arizona</option>
                                    <option value="AR">Arkansas</option>
                                    <option value="CA">California</option>
                                    <option value="CO">Colorado</option>
                                    <option value="CT">Connecticut</option>
                                    <option value="DE">Delaware</option>
                                    <option value="DC">District Of Columbia</option>
                                    <option value="FL">Florida</option>
                                    <option value="GA">Georgia</option>
                                    <option value="HI">Hawaii</option>
                                    <option value="ID">Idaho</option>
                                    <option value="IL">Illinois</option>
                                    <option value="IN">Indiana</option>
                                    <option value="IA">Iowa</option>
                                    <option value="KS">Kansas</option>
                                    <option value="KY">Kentucky</option>
                                    <option value="LA">Louisiana</option>
                                    <option value="ME">Maine</option>
                                    <option value="MD">Maryland</option>
                                    <option value="MA">Massachusetts</option>
                                    <option value="MI">Michigan</option>
                                    <option value="MN">Minnesota</option>
                                    <option value="MS">Mississippi</option>
                                    <option value="MO">Missouri</option>
                                    <option value="MT">Montana</option>
                                    <option value="NE">Nebraska</option>
                                    <option value="NV">Nevada</option>
                                    <option value="NH">New Hampshire</option>
                                    <option value="NJ">New Jersey</option>
                                    <option value="NM">New Mexico</option>
                                    <option value="NY">New York</option>
                                    <option value="NC">North Carolina</option>
                                    <option value="ND">North Dakota</option>
                                    <option value="OH">Ohio</option>
                                    <option value="OK">Oklahoma</option>
                                    <option value="OR">Oregon</option>
                                    <option value="PA">Pennsylvania</option>
                                    <option value="RI">Rhode Island</option>
                                    <option value="SC">South Carolina</option>
                                    <option value="SD">South Dakota</option>
                                    <option value="TN">Tennessee</option>
                                    <option value="TX">Texas</option>
                                    <option value="UT">Utah</option>
                                    <option value="VT">Vermont</option>
                                    <option value="VA">Virginia</option>
                                    <option value="WA">Washington</option>
                                    <option value="WV">West Virginia</option>
                                    <option value="WI">Wisconsin</option>
                                    <option value="WY">Wyoming</option>
                                </select>&nbsp;		
                                <input class="form-zip" name="Zip" type="text" placeholder="Zip" pattern="(\d{5}([\-]\d{4})?)" title="Please use xxxxx or xxxxx-xxxx zip code" required>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="customer-heading">EMAIL</label><br>
                                <input class="form-email" name="Email" type="email" placeholder="Email" required>
                            </td>
                        </tr>
                    </div>
                    </tbody>
                </table>
                <!-- Form Submit -->
                <input class="btn-link" value="Purchase Tickets" type="submit">
            </form>
            <br><br><br><br><br>
        </div>
        <div class="copyright">
            &copy;2018 some company
        </div>
    </body>
</html>