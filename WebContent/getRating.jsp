<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get your Rating</title>
</head>
<body>
<h1>Your Feedback and Rating</h1>
	<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
	<%
		try {
			ResultSet avg = null;
			ResultSet result = null;
			//Get parameters from the HTML form
			String username = session.getAttribute("user.username").toString();
			
			//Create a connection string
			//String url = "jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample";
			String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
	
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "admin", "password");
	
			//Create a SQL statement
			Statement stmt1 = con.createStatement();
		
			//Average
			String str1 = "SELECT AVG(value) AS average FROM ratings WHERE userRated = '" + username + "'";
			avg = stmt1.executeQuery(str1);
			avg.next();
			out.print("<h3>Average rating: "+ avg.getString("average") + "/5</h3>");
			
			//Individual
			Statement stmt2 = con.createStatement();
			String str2 = "SELECT * FROM ratings WHERE userRated = '" + username + "'";
			result = stmt2.executeQuery(str2);
			
			while(result.next()){
				out.print("<span><b>"+ result.getInt("value") + "/5</b> by "+ result.getString("userRater"));
				if (result.getString("comment") != null){
					 out.print(": \"" + result.getString("comment") + "\"");
				}
				out.print("</span><br>");
			}
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			
		} catch (Exception ex) {
			if (session.getAttribute("user.username") == null){
				response.sendRedirect("/login.jsp");
			}			
			out.print("get rating failed <br> " + ex);
		}
		

		%>
</body>
</html>