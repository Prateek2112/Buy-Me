
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%
  // Get parameters from the previous page
  Integer itemId = Integer.parseInt(session.getAttribute("itemId").toString());
  String rowID = request.getParameter("rowID");
  out.println(rowID);

  // Set up database connection parameters
  String driver = "com.mysql.jdbc.Driver";
  String url = "jdbc:mysql://localhost:3306/buy_me";
  String username = "root";
  String password = "password";

  // Update the solution field in the query table for the selected row ID
  try {
    Class.forName(driver);
    Connection conn = DriverManager.getConnection(url, username, password);
    String sql = "DELETE from bid_history WHERE _ID = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, rowID);
    int rowsAffected = stmt.executeUpdate();
    stmt.close();
    conn.close();
    out.println("<p>" + rowsAffected + " rows updated.</p>");
  } catch (ClassNotFoundException e) {
    out.println("<p>Class not found: " + e.getMessage() + "</p>");
  } catch (SQLException e) {
    out.println("<p>SQL error: " + e.getMessage() + "</p>");
  }
  response.sendRedirect("custRepDisplay.jsp?id=" + itemId);
%>