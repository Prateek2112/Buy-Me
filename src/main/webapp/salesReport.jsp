<%@ page import="java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Sales Report</title>
  </head>
  <body>
    <h1>Sales Report</h1>
    <%
      // get form data
      String reportType = request.getParameter("report-type");
      String earningsPerType = request.getParameter("earnings-per-type");
      
      // connect to database
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buy_me","root","password");
      
      // execute SQL query based on report type
      PreparedStatement stmt = null;
      ResultSet rs = null;
      if (reportType.equals("total-earnings")) {
        stmt = con.prepareStatement("SELECT SUM(init_price) FROM item WHERE buyer_id IS NOT NULL");
        rs = stmt.executeQuery();
        rs.next();
        double totalEarnings = rs.getDouble(1);
        out.println("<p>Total earnings: $" + totalEarnings + "</p>");
      } else if (reportType.equals("earnings-per")) {
        String earningsPerColumn = "";
        switch (earningsPerType) {
          case "item":
            earningsPerColumn = "name";
            break;
          case "item-type":
            earningsPerColumn = "category_id";
            break;
          case "end-user":
            earningsPerColumn = "buyer_id";
            break;
        }
        stmt = con.prepareStatement("SELECT " + earningsPerColumn + ", SUM(init_price) FROM item WHERE buyer_id IS NOT NULL GROUP BY " + earningsPerColumn + " ORDER BY SUM(init_price) DESC");
        rs = stmt.executeQuery();
        out.println("<table>");
        out.println("<tr><th>" + earningsPerType.toUpperCase() + "</th><th>Total Earnings</th></tr>");
        while (rs.next()) {
          String earningsPerValue = rs.getString(1);
          double earnings = rs.getDouble(2);
          out.println("<tr><td>" + earningsPerValue + "</td><td>$" + earnings + "</td></tr>");
        }
        out.println("</table>");
      } else if (reportType.equals("best-selling-items")) {
        stmt = con.prepareStatement("SELECT name, COUNT(*) AS sales FROM item WHERE buyer_id IS NOT NULL GROUP BY name ORDER BY sales DESC LIMIT 10");
        rs = stmt.executeQuery();
        out.println("<ol>");
        while (rs.next()) {
          String itemName = rs.getString("name");
          int sales = rs.getInt("sales");
          out.println("<li>" + itemName + ": " + sales + " sales</li>");
        }
        out.println("</ol>");
      } else if (reportType.equals("best-buyers")) {
        stmt = con.prepareStatement("SELECT buyer_id, COUNT(*) AS purchases FROM item WHERE buyer_id IS NOT NULL GROUP BY buyer_id ORDER BY purchases DESC LIMIT 10");
        rs = stmt.executeQuery();
        out.println("<ol>");
        while (rs.next()) {
          String buyerId = rs.getString("buyer_id");
          int purchases = rs.getInt("purchases");
          out.println("<li>" + buyerId + ": " + purchases + " purchases</li>");
        }
        out.println("</ol>");
      }
      
      
      // close database connection and resources
      if (rs != null) {
        rs.close();
      }
      if (stmt != null) {
        stmt.close();
      }
      con.close();
    %>
    <button onclick = "location.href='generateReport.jsp'">Go Back</button>
  </body>
</html>
