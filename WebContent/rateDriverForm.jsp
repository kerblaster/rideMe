<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Rate Experience</title>
</head>
<body>
<!-- *** Note: this is accessed through index link *** -->
<h1>Rate your experience as Passenger</h1>
<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
<h2>Driver: 
	<%
		String queryStr = request.getQueryString().toString();
		String[] cookies = queryStr.split("&");
		String rideId = cookies[0].split("=")[1];
		String driver = cookies[1].split("=")[1];
		out.println(driver);
	%>
</h2>					  
<p>(keep name for future messaging)</p>
	<form method="post" action="server/rateDriver.jsp">
		<table>
			<tr>    
				<td>Rating: </td>
				<td>
				  	<input type="radio" name="rating" value="1"> 1
  					<input type="radio" name="rating" value="2"> 2
  					<input type="radio" name="rating" value="3" checked> 3
  					<input type="radio" name="rating" value="4"> 4
  					<input type="radio" name="rating" value="5"> 5
  				</td>
			</tr>
			<tr>
				<td>Comment: </td>
				<td><textarea name="comment" rows="4" cols="50" placeholder="Add additional comments here"></textarea></td>
			</tr>
		</table>
		<br>
		<input type="hidden" id="rideId" name="rideId" value="">
		<input type="hidden" id="driver" name="driver" value="">
		<input type="checkbox" name="public" value="1"> Public?<br>
		<input type="submit" value="Rate">
	</form>
	<script>
		document.getElementById("rideId").value = '<%= rideId %>';	
		document.getElementById("driver").value = '<%= driver %>';	
	</script>
</body>
</html>