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
	<h1>Buy Me Item</h1>
	<%
		// Retrieve the item ID from the query parameter
		Integer itemId = Integer.parseInt(request.getParameter("id").toString());

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
				
				stmt = conn.prepareStatement("SELECT bidder_id, amount, bid_date FROM bid_history WHERE item_id = ?");
				stmt.setInt(1, itemId);
				rs = stmt.executeQuery();
				if (rs.next()){
					out.println("<table border='1'>");
					out.println("<tr><th>Bidder ID</th><th>Amount</th><th>Bid Date</th></tr>");
					
					 do {
						String bidderId = rs.getString("bidder_id");
						String amount = rs.getString("amount");
						String bidDate = rs.getString("bid_date");
						out.println("<tr><td>" + bidderId + "</td><td>" + amount + "</td><td>" + bidDate + "</td></tr>");
					}while (rs.next());
					out.println("</table>");
				} else {
					out.println("No bid history!!!");
				}
				out.println("<br>");
				out.println("<br>");
				
			// Output a form to place a bid on the item
			session.setAttribute("item_id", itemId);
			out.println("<form method='post' action='place_bid.jsp'>");
			out.println("<input type='hidden' name='itemId' value='" + itemId + "'>");
			out.println("<label for='bidAmount'>Enter your bid:</label>");
			out.println("<input type='number' step='0.01' name='bidAmount' id='bidAmount' required>");
			out.println("<input type='submit' value='Place Bid'>");
			out.println("</form>");
		} else {
			out.println("Item not found.");
		}
		// Close the database connection
		conn.close();
	} catch (Exception e) {
		out.println("Error: " + e.getMessage());
	}
%>
<button onclick = "location.href='searchItems_list.jsp'">Go Back</button>
		