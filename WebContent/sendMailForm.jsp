<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Send Mail</title>
</head>
<body>
	<h1>Send Mail</h1>
	<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>	
	<form method="post" action="server/sendMail.jsp">
		<p>To</p>
		<input type="text" name="to">
		<br>
		<p>Message</p>
		<textarea rows="8" cols="60" name="message">
		</textarea>
		<br>
		<input type="submit" name="submit" value="Submit">
	</form>
</body>
</html>
