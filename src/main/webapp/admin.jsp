
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.buy_me.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>




<%
if ((session.getAttribute("user") == null)) {
%>
	You are not logged in<br/>
	<a href="login.jsp">Please Login</a>
	<%} 
else
	{%>
	Welcome Admin <% //this will display the username that is stored in the session.%>
	<a href='logout.jsp'>Log out</a><br>
	<button type="button" onclick = "location.href='generateReport.jsp'">Generate Reports</button>
	<button type="button" onclick = "location.href='accountCreate.jsp'">Create CustRep Account</button>
<%
}
%>