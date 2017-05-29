<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rate Driver</title>
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
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get parameters from the HTML form
			String userRated = request.getParameter("driver");
			String userRater = session.getAttribute("user.username").toString();
			String rating = request.getParameter("rating");
			String comment = request.getParameter("comment");
			String rideId = request.getParameter("rideId");
			String isPublic = request.getParameter("public");
			if(isPublic==null)
				isPublic = "0";
			
			//Check counts once again (the same as the above)
			String str = "INSERT INTO ratings(isPublic, userRated, userRater, rideId, value, comment) VALUES (?, ?, ?, ?, ?, ?)";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(str);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, isPublic);
			ps.setString(2, userRated);
			ps.setString(3, userRater);
			ps.setString(4, rideId);
			ps.setString(5, rating);
			ps.setString(6, comment);
			
			//Run the query against the DB
			ps.executeUpdate();
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			response.sendRedirect("../index.jsp");
		} catch (Exception ex) {
			out.print("Rating insert failed <br> " + ex);
		}
		

		%>
</body>
</html>