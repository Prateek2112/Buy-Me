
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%
    // Get the user inputs from the registration form
    String name = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
    
    // Initialize the database connection
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buy_me","root","password");
	Statement st = con.createStatement();
    
    // Insert the user information into the database
    PreparedStatement ps = con.prepareStatement("INSERT INTO user (name, email, password) VALUES (?, ?, ?)");
    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, password);
    ps.executeUpdate();
    
	
    // Close the database connection and redirect to the login page
    con.close();
    //response.sendRedirect("login.jsp");
%>
<script>
  // Display alert message
  alert("Account has been created.");
  
  // Redirect to login page after clicking "OK"
  window.location.href = "admin.jsp";
</script>