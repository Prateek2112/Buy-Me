
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
	<head>
		<title>Create Auction</title>
	</head>
	<body>
		<form action="setAuction.jsp" method="POST">
		<table>
				<tr>
					<td> Name: 
					<td> <input type="text" name="name"/> <br/>
				</tr>
				<tr>
					<td> Description:
					<td> <input type="text" name="description"/> <br/>
				</tr>
				<tr>
					<td> Initial Price:
					<td> <input type="number" name="init_price"/> <br/>
				</tr>
				<tr>
					<td> Category:
					<td> <select name="category">
					    <option value="">-- Select a category --</option>
					    <%!
					      String driver = "com.mysql.jdbc.Driver";
					      String url = "jdbc:mysql://localhost:3306/buy_me";
					      String username = "root";
					      String password = "password";
					    %>
					    <%
					      try {
					        Class.forName(driver);
					        Connection conn = DriverManager.getConnection(url, username, password);
					        String sql = "SELECT _ID, cat_name FROM category ORDER BY cat_name";
					        Statement stmt = conn.createStatement();
					        ResultSet rs = stmt.executeQuery(sql);	    
					        while (rs.next()) {
					          String categoryName = rs.getString("cat_name");
					          Integer catid = rs.getInt("_ID");
// 					          session.setAttribute("category_id", catid);
					          out.println("<option value='" + categoryName + "'>" + categoryName + "</option>");
					        }
					        rs.close();
					        stmt.close();
					        conn.close();
					      } catch (ClassNotFoundException e) {
					        out.println("<p>Class not found: " + e.getMessage() + "</p>");
					      } catch (SQLException e) {
					        out.println("<p>SQL error: " + e.getMessage() + "</p>");
					      }
					    %>
					 </select>
			 <br/>
				</tr>
				<tr>
					<td> Minimum Price:
					<td> <input type="number" name="min_price"/> <br/>
				</tr>
				<tr>
					<td> Increment:
					<td> <input type="number" name="increment"/> <br/>
				</tr>
				<tr>
					<td> End Date:
					<td> <input type="datetime-local" name="end_date"/> <br/>
				</tr>
			</table>
			
			
			<input type="submit" value="Create Auction"/>
			<button type="button" onclick = "location.href='success.jsp'">Back</button>
		</form>
	</body>
</html>