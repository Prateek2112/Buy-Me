
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
  <title>Query Table</title>
  <script>
    function expandTextArea(rowID) {
      // Collapse any previously expanded text areas
      var textareas = document.querySelectorAll(".text-area");
      for (var i = 0; i < textareas.length; i++) {
        textareas[i].style.display = "none";
      }

      // Expand the text area for the selected row
      var textarea = document.getElementById("text-area-" + rowID);
      textarea.style.display = "block";
    }
  </script>
</head>
<body>
  <h1>Query Table</h1>
  
  <form method="post" action="answerQuery.jsp">
        <% 
          // Get the session user ID (assuming it's stored in a variable called "sessionUserID")
          String userid = session.getAttribute("username").toString();
          
          // Connect to the "buy_me" database
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/buy_me", "root", "password");

          // Execute SQL query to retrieve rows
          Statement stmt = conn.createStatement();
          ResultSet rs = stmt.executeQuery("SELECT q._ID as query_id, u.name, q.user_id, q.description FROM query q JOIN user u ON q.user_id = u._ID WHERE q.solution is null");

          // Display rows in the table, with radio buttons and expandable text areas
          if (rs.next()) {
          %>
          <table border="1">
      		<thead>
        		<tr>
          			<th></th>
          			<th>User Name</th>
         			<th>Description</th>
       			</tr>
      		</thead>
      		<tbody>
      	<%
          do {
            int rowID = rs.getInt("query_id");
            out.println("<tr>");
            out.println("<td><input type='radio' name='rowID' value='" + rowID + "' onclick='expandTextArea(" + rowID + ")'></td>");
            out.println("<td>" + rs.getString("name") + "</td>");
            out.println("<td>" + rs.getString("description") + "</td>");
            out.println("</tr>");
            out.println("<tr><td colspan='4'><textarea id='text-area-" + rowID + "' class='text-area' name='solution' rows='3' style='display: none;'></textarea></td></tr>");
          } while (rs.next());
      	%>
      	      </tbody>
    	</table>

    	<br>
    	<input type="submit" value="Submit">
      	<%
          } else {
        	  out.println("No Queries!!!!!");
          }

          // Close database connections
          rs.close();
          stmt.close();
          conn.close();
        %>

</form>
<button onclick = "location.href='custRepHome.jsp'">Go Back</button>
</body>
</html>
