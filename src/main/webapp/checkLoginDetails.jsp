
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>



<%@ page import ="java.sql.*" %>

<%
	String userid = request.getParameter("username");
	String pwd = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buy_me","root","password");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from user where email='" + userid + "' and password='" + pwd+ "'");
	if (rs.next()) {
		session.setAttribute("user", userid); // the username will be stored in the session
		session.setAttribute("userid", rs.getInt("_ID"));
		if (userid.equals("admin@buyme.com")) {
			response.sendRedirect("admin.jsp"); // redirect to admin page
		} else if (userid.matches("^custrep\\d+@buyme\\.com$")) {
			response.sendRedirect("custRepHome.jsp"); // redirect to custRep page
		} else {
			out.println("Welcome " + userid);
			out.println("<a href='logout.jsp'>Log out</a>");
			response.sendRedirect("success.jsp");
		}
	} else {
		out.println("Invalid password <a href='login.jsp'>try again</a>");
	}
%>