/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.*;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author GC
 */
public class ProcessForm extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException, IllegalAccessException, InstantiationException {
                String method = "";
                method = request.getMethod();
                response.setContentType("text/html;charset=UTF-8");
                
                String firstName = request.getParameter("First_Name");
                String lastName = request.getParameter("Last_Name");
                String address = request.getParameter("Address");
                String city = request.getParameter("City");
                String state = request.getParameter("State");
                String zip = request.getParameter("Zip");
                String email = request.getParameter("Email");
                String error1 = ("<h2 style='color:red;'>Please choose at least one ticket</h2>");
               

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

        try (PrintWriter out = response.getWriter()) {
           
            if (ticketQuantityI == 0 && ticketQuantityII == 0 && ticketQuantityIII == 0) {
                request.setAttribute("error1", error1);
                request.setAttribute("fname", firstName);
                request.setAttribute("lname", lastName);
                request.setAttribute("address", address);
                request.setAttribute("state", state);
                request.setAttribute("city", city);
                request.setAttribute("zip", zip);
                request.setAttribute("email", email);
                request.getRequestDispatcher("purchase.jsp").forward(request, response); 
                response.sendRedirect(request.getContextPath() + "/purchase.jsp");
            }
            else {
                if (method.equalsIgnoreCase("POST")) {
                Connection con = null;
                Statement stmt = null;
                String driver = "org.apache.derby.jdbc.ClientDataSource";
                String url = "jdbc:derby://localhost:1527/db;user=username;password=password";
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
                String newOrderInsert = "INSERT INTO Orders (OrderID, CustomerID, OrderDate, ShipCost, AquisitionFee) VALUES(default, " + currentCustomerID + ",'" + orderDate + "', " + shipCost + "," + aquisitionFee + ")";
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


           
                response.sendRedirect(request.getContextPath() + "/success.jsp");
            }
            }
           
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProcessForm.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProcessForm.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(ProcessForm.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(ProcessForm.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProcessForm.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProcessForm.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(ProcessForm.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(ProcessForm.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
