
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
	Welcome <%=session.getAttribute("user")%> <% //this will display the username that is stored in the session.%>
	<a href='logout.jsp'>Log out</a><br>
	<button type="button" onclick = "location.href='createAuction.jsp'">Create Auction</button>
	<button type="button" onclick = "location.href='searchItems_list.jsp'">Search Items</button>
	<button type="button" onclick = "location.href='wishlist.jsp'">My Wishlist</button>
	<button type="button" onclick = "location.href='myAuctions.jsp'">My Auctions</button>
	<button type="button" onclick = "location.href='postQuery.jsp'">Customer Support</button>
<%
}
%>