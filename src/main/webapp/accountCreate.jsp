
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<title>Register Form</title>
	</head>
	<body>
		<form action="custRepAcc.jsp" method="POST">
			<table>
				<tr>
					<td> Full Name:
					<td> <input type="text" name="name"/> <br/>
				</tr>
				<tr>
					<td> Email:
					<td> <input type="email" name="email"/> <br/>
				</tr>
				<tr>
					<td> Password:
					<td> <input type="password" name="password"/> <br/>
				</tr>
			</table>
			<input type="submit" value="Register"/>
			<button type="button" onclick = "location.href='admin.jsp'">Back</button>
		</form>
	</body>
</html>