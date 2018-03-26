# JazzY
A <strong>ongoing</strong> group collaborative project, with the intention of designing a JSP web application that processes user input, stores and tracks data with embedded database, and then displays the information.

Although many of the styles of JSP are quickly being supplemented with frameworks (such as Spring) and JavaScript (such as AJAX), the fundamental Java HTTP servlet class remains consistent among web service designs methods. The goal of this project was to limit ourselves to strictly JSP, HTML and CSS. To build a web application that makes use of the fundamental building blocks of Java web applications.

HTTP Servlet JSP, Glassfish Server 4.1, Apache Derby embedded database, JDBC connectivity, RDBMS 3NF standardized, HTML5, CSS3.

TODO List 03-19-18: 
1. add bill total row to table
2. validation of at least 1 ticket (aka do not accept 0,0,0 for all categories) (DONE) 
3. the last few queries for dashboard page (NEEDS TABLE EXPANDED FOR TOTAL BILL)
4. prepared statements only (aka fix sql queries of jame's draft code)
5. information on success page (aka confirmation with total cost, ect. ect.) 
6. Retain radio button preference after a failed validation
7. Retain the state preference after a failed validation
8. Add correct try-catch {conn.close()} for resources

![alt text](https://github.com/jpwilliams000/JazzY/blob/master/pictures/orderpage.PNG)
![alt text](https://github.com/jpwilliams000/JazzY/blob/master/pictures/dashboard.PNG)
![alt text](https://github.com/jpwilliams000/JazzY/blob/master/pictures/ERD.PNG)
![alt text](https://github.com/jpwilliams000/JazzY/blob/master/pictures/datadictionary.PNG)
