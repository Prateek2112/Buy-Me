
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<title>Buy Me Items</title>
</head>
<body>
	<h1>Buy Me Items</h1>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Description</th>
			<th>Seller ID</th>
			<th>Category ID</th>
			<th>Initial Price</th>
			<th>Increment</th>
			<th>Start Date</th>
			<th>End Date</th>
		</tr>
		<%
			try {
				// Establish a connection to the database
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/buy_me", "root", "password");
				
				// Execute a SQL query to retrieve all the items from the "item" table
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM item");
				
				// Loop through the result set and display each item in a table row
				while (rs.next()) {
					String id = rs.getString("_ID");
					String name = rs.getString("name");
					String description = rs.getString("description");
					String sellerId = rs.getString("seller_id");
					String categoryId = rs.getString("category_id");
					String initPrice = rs.getString("init_price");
					String increment = rs.getString("increment");
					String startDate = rs.getString("start_date");
					String endDate = rs.getString("end_date");
					
					session.setAttribute("item_id", id);
					// Output the HTML code for a table row with the item details
					out.println("<tr>");
					out.println("<td><a href='display.jsp?id=" + id + "'>" + id + "</a></td>");
					out.println("<td>" + name + "</td>");
					out.println("<td>" + description + "</td>");
					out.println("<td>" + sellerId + "</td>");
					out.println("<td>" + categoryId + "</td>");
					out.println("<td>" + initPrice + "</td>");
					out.println("<td>" + increment + "</td>");
					out.println("<td>" + startDate + "</td>");
					out.println("<td>" + endDate + "</td>");
					out.println("</tr>");
				}
				
				// Close the database connection
				conn.close();
			} catch (Exception e) {
				out.println("Error: " + e.getMessage());
			}
		%>
	</table>
	<button onclick = "location.href='success.jsp'">Go Back</button>
</body>
</html>

