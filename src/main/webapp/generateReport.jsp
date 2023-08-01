
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
  <head>
    <title>Sales Report Generator</title>
  </head>
  <body>
    <h1>Sales Report Generator</h1>
    <form action="salesReport.jsp" method="post">
      <label for="report-type">Report Type:</label>
      <select name="report-type" id="report-type">
        <option value="total-earnings">Total Earnings</option>
        <option value="earnings-per">Earnings Per...</option>
        <option value="best-selling-items">Best Selling Items</option>
        <option value="best-buyers">Best Buyers</option>
      </select>
      <br>
      <div id="earnings-per-options" style="display:none">
        <label for="earnings-per-type">Earnings Per:</label>
        <select name="earnings-per-type" id="earnings-per-type">
          <option value="item">Item</option>
          <option value="item-type">Item Type</option>
          <option value="end-user">End User</option>
        </select>
      </div>
      <br>
      <input type="submit" value="Generate Report">
    </form>
    <button onclick = "location.href='admin.jsp'">Go Back</button>
    
    <script>
      // show/hide earnings-per-options div based on report-type selection
      const earningsPerOptionsDiv = document.getElementById('earnings-per-options');
      const reportTypeSelect = document.getElementById('report-type');
      reportTypeSelect.addEventListener('change', () => {
        if (reportTypeSelect.value === 'earnings-per') {
          earningsPerOptionsDiv.style.display = 'block';
        } else {
          earningsPerOptionsDiv.style.display = 'none';
        }
      });
    </script>
  </body>
</html>
