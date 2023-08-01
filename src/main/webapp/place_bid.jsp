<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%
    // Get the input amount from the HTML page
    Double amount = Double.parseDouble(request.getParameter("bidAmount"));

    // Connect to the MySQL database
    String url = "jdbc:mysql://localhost:3306/buy_me";
    String user = "root";
    String password = "password";
    Connection conn = DriverManager.getConnection(url, user, password);

    // Get the item ID and increment from the 'item' table
    int item_id = Integer.parseInt(session.getAttribute("item_id").toString());
    PreparedStatement stmt = conn.prepareStatement("SELECT init_price, increment FROM item WHERE _ID = ?");
    stmt.setInt(1, item_id);
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        Double init_price = rs.getDouble("init_price");
        Double increment = rs.getDouble("increment");

        // Check if the item ID is in the 'bid_history' table
        stmt = conn.prepareStatement("SELECT amount FROM bid_history WHERE item_id = ?");
        stmt.setInt(1, item_id);
        rs = stmt.executeQuery();
        Double old_amount;
        if (rs.next()) {
            old_amount = rs.getDouble("amount");
        } else {
        	old_amount = init_price;
        }
        if (old_amount + increment <= amount) {
            // Insert the new bid into the 'bid_history' table
            stmt = conn.prepareStatement("INSERT INTO bid_history (item_id, bidder_id, amount, bid_date) VALUES (?, ?, ?, NOW())");
            stmt.setInt(1, item_id);
            stmt.setInt(2, 1); // Replace with the actual bidder ID
            stmt.setDouble(3, amount);
            stmt.executeUpdate();
        } else {
            // Alert the user to check the minimum increment and bid again
            out.println("<script>alert('Check the minimum increment and bid again');</script>");
        }
    }
    out.println("<script>window.location.href = 'display.jsp'</script>");
    conn.close();
%>
