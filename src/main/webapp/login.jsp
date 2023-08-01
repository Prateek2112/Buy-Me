
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html>
<html>
	<head>
		<title>Login Form</title>
	</head>
	<body>
		<form action="checkLoginDetails.jsp" method="POST">
		<table>
			<tr>
				<td> Email:
				<td> <input type="email" name="username"/> <br/>
			</tr>
			<tr>
				<td> Password:
				<td> <input type="password" name="password"/> <br/>
			</tr>
		</table>
			<input type="submit" value="Submit"/>
			<button type="button" onclick = "location.href='register_new.jsp'">Register</button>
		</form>
	</body>
</html>