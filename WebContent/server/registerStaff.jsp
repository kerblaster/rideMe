<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adding staff script</title>
</head>
<body>
	<div style="position:absolute;top:0;right:0;">[<a href="../index.jsp">GO HOME</a>]</div>
	<%
	try {
		//Create a connection string
		String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");

		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "admin", "password");

		//Get parameters from the HTML form at the HelloWorld.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		String type = "staff";
		
		//Make an insert statement for the Sells table:
		String insert =
		"INSERT INTO users(username, password, email, name, address, phone, type)"
		+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, username);
		ps.setString(2, password);
		ps.setString(3, email);
		ps.setString(4, name);
		ps.setString(5, address);
		ps.setString(6, phone);
		ps.setString(7, type);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		response.sendRedirect("../index.jsp");
		
	} catch (Exception ex) {
		out.print("Staff register failed <br> " + ex);
	}
%>
</body>
</html>