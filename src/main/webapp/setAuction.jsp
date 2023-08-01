
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
  



<%
    // Get the user inputs from the registration form
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	
    String name = request.getParameter("name");
	String descr = request.getParameter("description");
	Double init_price = Double.parseDouble(request.getParameter("init_price"));
	String category_name = request.getParameter("category").toString();
	Double min_price = Double.parseDouble(request.getParameter("min_price"));
	Integer increment = Integer.parseInt(request.getParameter("increment"));
	String e_date = request.getParameter("end_date");
	
	LocalDateTime end_date = LocalDateTime.parse(e_date, formatter);
	
	String id_stmt = "SELECT _ID FROM category WHERE cat_name='" + category_name +"'";
   
    // Initialize the database connection
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buy_me","root","password");
	Statement st = con.createStatement();
	ResultSet rs = null;
	rs = st.executeQuery(id_stmt);
	Integer seller_id = Integer.parseInt(session.getAttribute("userid").toString());
	if (rs.next()) {
		Integer cat_id = rs.getInt("_ID");
	
	
	    // Insert the user information into the database
	    PreparedStatement ps = con.prepareStatement("INSERT INTO item (name, seller_id, category_id, description, init_price, min_price, increment, start_date, end_date) VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), '" + end_date + "')");
	    ps.setString(1, name);
	    ps.setInt(2, seller_id);
	    ps.setInt(3, cat_id);
	    ps.setString(4, descr);
	    ps.setDouble(5, init_price);
	    ps.setDouble(6, min_price);
	    ps.setInt(7, increment);
	    ps.executeUpdate();
	} else {
		out.println("Some error occured");
	}
    
	
    // Close the database connection and redirect to the login page
    con.close();
    response.sendRedirect("success.jsp");
%>