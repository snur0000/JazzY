<%-- 
    Document   : purchase.jsp
    Created on : Feb 9, 2018, 6:40:39 PM
    Author     : Team Jazzy
    Purpose    : Form to be submitted during purchase of tickets.
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
                    <li><a class="selected" href="purchase.jsp">TICKETS</a></li>
                    <li> <a href="dashboard.jsp">EMPLOYEE DASHBOARD</a></li>
                </ul>
            </nav>
        </header>
        <div class="table-tickets">
            <%!
                
            %>

            <%//Form Submission Code   
                
                //This submission validity check runs after the form submits.
                boolean isValid = true;
                String errorName = "";
                if (method.equalsIgnoreCase("POST")) {
                    int ticketQuantityI = Integer.parseInt(request.getParameter("Category_One"));
                    int ticketQuantityII = Integer.parseInt(request.getParameter("Category_Two"));
                    int ticketQuantityIII = Integer.parseInt(request.getParameter("Category_Three"));
                    errorName = request.getParameter("First_Name");
                    if (ticketQuantityI == 0 && ticketQuantityII == 0 && ticketQuantityIII == 0){
                        isValid = false;
                    }
                }
                
                //This code runs when form submits, and tickets are not soldout, and validity is true.
                if (method.equalsIgnoreCase("POST") && !isSoldOut() && isValid) {

                    //get customer information
                    String firstName = request.getParameter("First_Name");
                    String lastName = request.getParameter("Last_Name");
                    String address = request.getParameter("Address");
                    String city = request.getParameter("City");
                    String state = request.getParameter("State");
                    String zip = request.getParameter("Zip");
                    String email = request.getParameter("Email");
                    String Aqusition_Decision = request.getParameter("Radio");
                    int ticketQuantityI = Integer.parseInt(request.getParameter("Category_One"));
                    int ticketQuantityII = Integer.parseInt(request.getParameter("Category_Two"));
                    int ticketQuantityIII = Integer.parseInt(request.getParameter("Category_Three"));
                    String orderDate = "2018-01-25"; //TODO SE core api new dateNow()
                    
                    //Computate shipping cost, processing fee and total bill
                    double shipCost = getShippingCost(Aqusition_Decision);
                    double processingRate = getProcessingRate(Aqusition_Decision);
                    double totalBill = calculateTotalBill(ticketQuantityI, ticketQuantityII, ticketQuantityIII, shipCost, processingRate);
                    //int totalBill = 100;

                    //InsertSQL: Insert the data into the database
                    InsertNewCustomer(lastName, firstName, address, city, state, zip, email);
                    InsertNewOrder(orderDate, shipCost, processingRate, totalBill);
                    InsertNewOrderItems(ticketQuantityI, ticketQuantityII, ticketQuantityIII);

                    %>   
                    <h1>Confirmation page</h1>
                    <h2>Enjoy the show, <%= firstName%>.</h2>
                    <% 
                }
                    %> 

            <%//Original page
                if (method.equalsIgnoreCase("GET") || method.equalsIgnoreCase("POST") && !isValid) {
            %>
            <form method="POST" action="purchase.jsp">
                <%
                    //This error h1 tag only shows when the isValid check is false
                    if(!isValid){
                        %>
                        <p class="warning"><%=errorName%>, you must purchase at least one ticket.</p>
                        <hr>
                        <%
                    }
                %>
                <br><br>
                <table class="ticket-form" border="0" cellspacing="5" cellpadding="1">
                    <tbody>
                        <!--Ticket Selection -->
                        <tr>
                            <th scope="col">Number of Tickets</th>
                            <th scope="col">Seating Category</th>
                            <th scope="col">Price</th>
                            <th scope="col">Tickets Remaining</th>
                        </tr>
                        <tr>
                            <td><input name="Category_One" type="number" placeholder="Number of Tickets" value="0" min="0" max="<%=queryTicketsRemaining(1)%>" required></td>
                            <td>Category 1 Rows A-C</td>
                            <td>$<%=queryTicketPrice(1)%></td>
                            <td><%= queryRemainingString(1)%></td>
                        </tr>
                        <tr>
                            <td><input name="Category_Two" type="number" placeholder="Number of Tickets" value="0" min="0" max="<%=queryTicketsRemaining(2)%>" required></td>
                            <td>Category 2 Rows D-F</td>
                            <td>$<%=queryTicketPrice(2)%></td>
                            <td><%= queryRemainingString(2)%></td>
                        </tr>
                        <tr>
                            <td><input name="Category_Three" type="number" placeholder="Number of Tickets" value="0" min="0" max="<%=queryTicketsRemaining(3)%>" required></td>
                            <td>Category 3 Rows G-I</td>
                            <td>$<%=queryTicketPrice(3)%></td>
                            <td><%= queryRemainingString(3)%></td>
                        </tr>
                        <!-- Purchase Options -->
                        <tr>
                            <td colspan="3">
                                <hr>
                                <span class="table-heading">Purchase Options</span>
                                <br>
                                <em class="small-print">All online purchases include a 7% fee.</em>
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
                <!-- The submit button will be removed when all sections are sold out-->
               <%= whichSubmitButton() %>
            </form>
            <%
                } 
            %>
            <br><br><br><br><br>
        </div>           
        <div class="copyright">
            &copy;2018 Jazzy
        </div>
    </body>
</html>

<%!//functional methods    
    
    //global fields
    int itemCounter = 1;
    //global constants
    final double SHIPPING_FEE = queryShippingPrice();
    final double PROCESSING_FEE = queryProcessingFee();
    final int ticketPriceI = queryTicketPrice(1);
    final int ticketPriceII = queryTicketPrice(2);
    final int ticketPriceIII = queryTicketPrice(3);

    private int getCurrentCustomerID() {
        final int FIRST_CUSTOMER_ID = 1000;
        int currentCustomerID = FIRST_CUSTOMER_ID;
        String query = "SELECT MAX(CustomerID) FROM Customers";
        try {
            ResultSet rs = stmt.executeQuery(query);
            currentCustomerID = Integer.parseInt(getFirstField(rs));
        } catch (Exception e) {
        } finally {
        }
        return currentCustomerID;
    }

    private int getCurrentOrderID() {
        final int FIRST_ORDER_ID = 100;
        int currentOrderID = FIRST_ORDER_ID;
        String query = "SELECT MAX(OrderID) FROM Orders";
        try {
            ResultSet rs = stmt.executeQuery(query);
            currentOrderID = Integer.parseInt(getFirstField(rs));
        } catch (Exception e) {
        } finally {
        }
        return currentOrderID;
    }

    private double getShippingCost(String Aqusition_Decision) {
        double shippingCost;
        if (Aqusition_Decision.equals("Shipping")) {
            shippingCost = SHIPPING_FEE;
        } else {
            shippingCost = 0;
        }
        return shippingCost;
    }

    private double getProcessingRate(String Aqusition_Decision) {
        double proccessingCost;
        if (!Aqusition_Decision.equals("Reserve")) {
            proccessingCost = PROCESSING_FEE;
        } else {
            proccessingCost = 0;
        }
        return proccessingCost;
    }
    
    public double calculateTotalBill(int ticketQuantityI, int ticketQuantityII, int ticketQuantityIII, double shipCost, double processingRate){
        double totalBill = 0;
        totalBill = ((ticketQuantityI*ticketPriceI + ticketQuantityII*ticketPriceII + ticketQuantityIII*ticketPriceIII)*(1+processingRate)+(shipCost));
        return totalBill;
    }
    
%>

<%!//Insert to db methods

    public void InsertNewCustomer(String lastName, String firstName, String address, String city, String state, String zip, String email) {
        String query = "INSERT INTO CUSTOMERS VALUES( default, '" + lastName + "', '" + firstName + "', '" + address + "', "
                + "'" + city + "', '" + state + "', '" + zip + "', '" + email + "')";
        try {
            stmt.executeUpdate(query);
        } catch (Exception e) {
        } finally {
        }
    }

    public void InsertNewOrder(String orderDate, double shipCost, double processingRate, double totalBill) {
        String query = "INSERT INTO Orders VALUES(default, " + getCurrentCustomerID() + ",'" + orderDate + "', "
                + "" + shipCost + "," + processingRate + "," + totalBill + ")";
        try {
            stmt.executeUpdate(query);
        } catch (Exception e) {
        } finally {
        }
    }

    public void InsertNewOrderItems(int ticketQuantityI, int ticketQuantityII, int ticketQuantityIII) {
        itemCounter = 1; //reset item counter to one
        if (ticketQuantityI > 0) {
            insertItem(1, ticketQuantityI);
        }
        if (ticketQuantityII > 0) {
            insertItem(2, ticketQuantityII);
        }
        if (ticketQuantityIII > 0) {
            insertItem(3, ticketQuantityIII);
        }
    }

    public void insertItem(int section, int ticketQuantity) {
        String query = "INSERT INTO OrderItems VALUES (" + getCurrentOrderID() + ", " + itemCounter + ", " + section + ", " + ticketQuantity + ")";
        try {
            stmt.executeUpdate(query);
            itemCounter++;//increse item counter for each item
        } catch (Exception e) {
        } finally {
        }
    }

%>

<%! //misc methods  
    //Global Interface Fields
    private Connection con;
    private Statement stmt;
    private PreparedStatement preparedStatement;

    private void getConnection() {
        try {

            String driver = "org.apache.derby.jdbc.ClientDataSource";
            String url = "jdbc:derby://localhost:1527/jazzydb;user=app;password=password";
            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(url);
            stmt = con.createStatement();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
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

<%! //query methods
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

<%! //query global constant's methods
    
    public int queryTicketPrice(int category){
        getConnection();
        int ticketPrice = 0;
        String query = "SELECT Cost FROM Tickets WHERE TicketSection = " + category + "";
        try {
            preparedStatement = con.prepareStatement(query);
            ResultSet rs = preparedStatement.executeQuery();
            ticketPrice = Integer.parseInt(getFirstField(rs));
        } catch (Exception e) {
        } finally {
        }
        return ticketPrice;
    }

    public double queryShippingPrice(){
        getConnection();
        double shippingPrice = 0;
        String query = "Select ShippingFee from PurchaseOptionData";
        try {
            preparedStatement = con.prepareStatement(query);
            ResultSet rs = preparedStatement.executeQuery();
            shippingPrice = Double.parseDouble(getFirstField(rs));
        } catch (Exception e) {
        } finally {
        }
        return shippingPrice;
    }

    public double queryProcessingFee(){
        getConnection();
        double processingFee = 0;
        String query = "Select ProccessingFee from PurchaseOptionData";
        try {
            preparedStatement = con.prepareStatement(query);
            ResultSet rs = preparedStatement.executeQuery();
            processingFee = Double.parseDouble(getFirstField(rs));
        } catch (Exception e) {
        } finally {
        }
        return processingFee;
    }
    
%>

<%! //Validity Checks
    
    //return true if sold out. return false if not sold out.
    public boolean isSoldOut() {
        boolean isSoldOut = false;
        if (queryTicketsRemaining(1) == 0 && queryTicketsRemaining(2) == 0 && queryTicketsRemaining(3) == 0) {
            isSoldOut = true;
        }
        return isSoldOut;
    }
    
    public String queryRemainingString(int category){
        String response;
        if(queryTicketsRemaining(category) == 0) {
            response = "SOLD OUT";
        } else {
            response = Integer.toString(queryTicketsRemaining(category));
        }
        return response;
    }

    public String whichSubmitButton(){
        String buttonLabel = "";
        if (!isSoldOut()) buttonLabel = "<input class='btn-link' value='Purchase Ticket' type='submit'>";
        if (isSoldOut()) buttonLabel = "";
        return buttonLabel;
    }
%>

