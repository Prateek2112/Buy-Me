
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
	Welcome <%=session.getAttribute("user")%>
	<%session.setAttribute("username", session.getAttribute("user"));%>
	<a href='logout.jsp'>Log out</a><br>
	<button type="button" onclick = "location.href='customerQuery.jsp'">Customer Support</button>
	<button type="button" onclick = "location.href='custAccountInfo.jsp'">Customer Info</button>
	<button type="button" onclick = "location.href='custRepBids.jsp'">Bids</button>
	<button type="button" onclick = "location.href='custRepAuction.jsp'">Auctions</button>
<%
}
%>