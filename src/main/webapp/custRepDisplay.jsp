<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<!DOCTYPE html>
<html>
<head>
	<title>Buy Me Item</title>
</head>
<body>
<form action="alterBid.jsp" method="POST">
	<h1>Buy Me Item</h1>
	<%
		// Retrieve the item ID from the query parameter
		Integer itemId = Integer.parseInt(request.getParameter("id").toString());
		session.setAttribute("itemId", itemId);

		try {
			// Establish a connection to the database
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/buy_me", "root", "password");
			
			// Execute a SQL query to retrieve the details of the specified item
			PreparedStatement stmt = conn.prepareStatement("SELECT i._ID as item_id, i.name as item_name, i.description, i.seller_id, i.buyer_id, i.init_price, i.min_price, i.increment, i.start_date, i.end_date, c.cat_name FROM item i JOIN category c ON i.category_id = c._ID WHERE i._ID = ?");
			stmt.setInt(1, itemId);
			ResultSet rs = stmt.executeQuery();
			
			// Output the item details in a table
			if (rs.next()) {
				String name = rs.getString("item_name");
				String description = rs.getString("description");
				String sellerId = rs.getString("seller_id");
				String categoryId = rs.getString("cat_name");
				String initPrice = rs.getString("init_price");
				String increment = rs.getString("increment");
				String startDate = rs.getString("start_date");
				String endDate = rs.getString("end_date");
				
				out.println("<table border='1'>");
				out.println("<tr><td>ID:</td><td>" + itemId + "</td></tr>");
				out.println("<tr><td>Name:</td><td>" + name + "</td></tr>");
				out.println("<tr><td>Description:</td><td>" + description + "</td></tr>");
				out.println("<tr><td>Seller ID:</td><td>" + sellerId + "</td></tr>");
				out.println("<tr><td>Category:</td><td>" + categoryId + "</td></tr>");
				out.println("<tr><td>Initial Price:</td><td>" + initPrice + "</td></tr>");
				out.println("<tr><td>Increment:</td><td>" + increment + "</td></tr>");
				out.println("<tr><td>Start Date:</td><td>" + startDate + "</td></tr>");
				out.println("<tr><td>End Date:</td><td>" + endDate + "</td></tr>");
				out.println("</table>");
				
				// Output the bid history table for the item
				out.println("<h2>Bid History</h2>");
				
				stmt = conn.prepareStatement("SELECT _ID, bidder_id, amount, bid_date FROM bid_history WHERE item_id = ?");
				stmt.setInt(1, itemId);
				rs = stmt.executeQuery();
				if (rs.next()){
					out.println("<table border='1'>");
					out.println("<tr><th></th><th>Bidder ID</th><th>Amount</th><th>Bid Date</th></tr>");
					
					 do {
						Integer bid_id = rs.getInt("_ID");
						String bidderId = rs.getString("bidder_id");
						String amount = rs.getString("amount");
						String bidDate = rs.getString("bid_date");
						out.println("<tr>");
						out.println("<td><input type='radio' name='rowID' value='" + bid_id + "'></td>");
						out.println("<td>" + bidderId + "</td><td>" + amount + "</td><td>" + bidDate + "</td>");
						out.println("</tr>");
					}while (rs.next());
					out.println("</table>");
				} else {
					out.println("No bid history!!!");
				}
				out.println("<br>");
				out.println("<br>");
				
		} else {
			out.println("Item not found.");
		}
		// Close the database connection
		conn.close();
	} catch (Exception e) {
		out.println("Error: " + e.getMessage());
	}
%>
	<input type='submit' value='Delete'>
</form>
<button onclick = "location.href='custRepAuction.jsp'">Go Back</button>
		