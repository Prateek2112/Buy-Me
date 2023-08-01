
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Post a Question</title>
</head>
<body>

  <h1>Post a Question</h1>

  <form action="userQueryPosted.jsp" method="post">
    <label for="description">Question:</label>
    <input type="text" id="description" name="description" required><br><br>
    <input type="submit" value="Submit">
  </form><br>
  <button type="button" onclick = "location.href='success.jsp'">Back</button>

</body>
</html>
