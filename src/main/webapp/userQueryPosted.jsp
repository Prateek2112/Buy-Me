
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
  // Get the question text from the previous page
	String description = request.getParameter("description");
	Integer user_id = Integer.parseInt(session.getAttribute("userid").toString());

  // Set up database connection parameters
  String driver = "com.mysql.jdbc.Driver";
  String url = "jdbc:mysql://localhost:3306/buy_me";
  String username = "root";
  String password = "password";

  // Insert the question into the query table
  try {
    Class.forName(driver);
    Connection conn = DriverManager.getConnection(url, username, password);
    String sql = "INSERT INTO query (user_id, description) VALUES (?, ?)";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, user_id); // Replace with actual user ID
    stmt.setString(2, description);
    int rowsAffected = stmt.executeUpdate();
    stmt.close();
    conn.close();
    out.println("<p>" + rowsAffected + " rows inserted.</p>");
  } catch (ClassNotFoundException e) {
    out.println("<p>Class not found: " + e.getMessage() + "</p>");
  } catch (SQLException e) {
    out.println("<p>SQL error: " + e.getMessage() + "</p>");
  }
%>

<a href="success.jsp">Go back to home.</a>
