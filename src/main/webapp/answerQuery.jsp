
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%
  // Get parameters from the previous page
  String rowID = request.getParameter("rowID");
  String solution = request.getParameter("solution");
  Integer userid = Integer.parseInt(session.getAttribute("userid").toString());

  // Set up database connection parameters
  String driver = "com.mysql.jdbc.Driver";
  String url = "jdbc:mysql://localhost:3306/buy_me";
  String username = "root";
  String password = "password";

  // Update the solution field in the query table for the selected row ID
  try {
    Class.forName(driver);
    Connection conn = DriverManager.getConnection(url, username, password);
    String sql = "UPDATE query SET solution = ?, cust_rep_id = ? WHERE _ID = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, solution);
    stmt.setInt(2, userid);
    stmt.setString(3, rowID);
    int rowsAffected = stmt.executeUpdate();
    stmt.close();
    conn.close();
    out.println("<p>" + rowsAffected + " rows updated.</p>");
  } catch (ClassNotFoundException e) {
    out.println("<p>Class not found: " + e.getMessage() + "</p>");
  } catch (SQLException e) {
    out.println("<p>SQL error: " + e.getMessage() + "</p>");
  }
%>

<a href="customerQuery.jsp">Go back to table</a>
