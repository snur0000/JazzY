package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.sql.*;

public final class dashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			"", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write(" \n");
      out.write(" \n");
      out.write("<html lang=\"en-US\">\n");
      out.write("\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("        <title>Jazz Concert</title>\n");
      out.write("        <link href=\"css/jazz_style.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("        <!-- <link href=\"https://fonts.googleapis.com/css?family=Open+Sans:300,400,600\" rel=\"stylesheet\"> -->\n");
      out.write("        <link href=\"css/googlefonts.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("\n");
      out.write("        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->\n");
      out.write("        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->\n");
      out.write("        <!--[if lt IE 9]>\n");
      out.write("              <script src=\"https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js\"></script>\n");
      out.write("              <script src=\"https://oss.maxcdn.com/respond/1.4.2/respond.min.js\"></script>\n");
      out.write("            <![endif]-->\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        ");

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

        
      out.write("\n");
      out.write("\n");
      out.write("        <header>\n");
      out.write("            <a href=\"index.html\"><h4 class=\"logo\">JAZZ CONCERT</h4></a>\n");
      out.write("            <nav>\n");
      out.write("                <ul>\n");
      out.write("                    <li><a href=\"index.html\">HOME</a></li>\n");
      out.write("                    <li><a href=\"dbtesting.jsp\">DbTesting</a></li>\n");
      out.write("                    <li><a href=\"purchase.jsp\">TICKETS</a></li>\n");
      out.write("                    <li><a class=\"selected\"href=\"dashboard.jsp\">EMPLOYEE DASHBOARD</a></li>\n");
      out.write("                </ul>\n");
      out.write("            </nav>\n");
      out.write("        </header>\n");
      out.write("        <div class=\"tables-dashboard\">\n");
      out.write("            <div class=\"table01 float-l\">\n");
      out.write("                <h2>Tickets Sold</h2>\n");
      out.write("                <table width=\"400\" cellspacing=\"2\" cellpadding=\"2\">\n");
      out.write("                    <tbody>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"col\">Seating Category</th>\n");
      out.write("                            <th scope=\"col\">Number of Tickets Sold</th>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 1</th>\n");
      out.write("                            <td>");
      out.print( totalNumberTicketsSoldI);
      out.write("</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 2</th>\n");
      out.write("                            <td>");
      out.print( totalNumberTicketsSoldII);
      out.write("</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 3</th>\n");
      out.write("                            <td>");
      out.print( totalNumberTicketsSoldIII);
      out.write("</td>\n");
      out.write("                        </tr>\n");
      out.write("                    </tbody>\n");
      out.write("                </table>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"table01 float-r\">\n");
      out.write("                <h2>Tickets Remaining</h2>\n");
      out.write("                <table cellspacing=\"2\" cellpadding=\"2\">\n");
      out.write("                    <tbody>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"col\">Seating Category</th>\n");
      out.write("                            <th scope=\"col\">Number of Tickets Remaining</th>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 1</th>\n");
      out.write("                            <td>");
      out.print( seatsRemainingI);
      out.write("</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 2</th>\n");
      out.write("                            <td>");
      out.print( seatsRemainingII);
      out.write("</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 3</th>\n");
      out.write("                            <td>");
      out.print( seatsRemainingIII);
      out.write("</td>\n");
      out.write("                        </tr>\n");
      out.write("                    </tbody>\n");
      out.write("                </table>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"table01 float-l\">\n");
      out.write("                <h2>Sales by Category</h2>\n");
      out.write("                <table cellspacing=\"2\" cellpadding=\"2\">\n");
      out.write("                    <tbody>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"col\">Seating Category</th>\n");
      out.write("                            <th scope=\"col\"> Sales (USD)</th>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 1</th>\n");
      out.write("                            <td>&nbsp;</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 2</th>\n");
      out.write("                            <td>&nbsp;</td>\n");
      out.write("                        </tr>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Category 3</th>\n");
      out.write("                            <td>&nbsp;</td>\n");
      out.write("                        </tr>\n");
      out.write("                    </tbody>\n");
      out.write("                </table>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"table01 float-r\">\n");
      out.write("                <h2>Total Sales</h2>\n");
      out.write("                <table cellspacing=\"2\" cellpadding=\"2\">\n");
      out.write("                    <tbody>\n");
      out.write("                        <tr>\n");
      out.write("                            <th scope=\"row\">Total Sales (USD)</th>\n");
      out.write("                            <td width=\"220\">&nbsp;</td>\n");
      out.write("                        </tr>\n");
      out.write("                    </tbody>\n");
      out.write("                </table>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("        <div class=\"copyright\">\n");
      out.write("            &copy;2018 some company\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("\n");
      out.write("</html>\n");
      out.write("\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
