<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Leaderboard</title>
</head>
<body>
	<h1>Leaderboard</h1>
	<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
	<p>See who has driven the most! If you are logged in as a driver, you can see your number of rides and your corresponding earned income.</p>
	<%
		try {
			ResultSet result = null;
			//Create a connection string
			//String url = "jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample";
			String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
	
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "admin", "password");
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String str = "SELECT driver, COUNT(*) as c FROM rides GROUP BY driver ORDER BY c DESC";
			result = stmt.executeQuery(str);
			
			if(session.getAttribute("user.username")!=null){ //if logged in
				//display total rides given
				ResultSet result2 = null;
				String str2 = "SELECT COUNT(*) as c FROM rides WHERE driver = '"+session.getAttribute("user.username").toString()+"'";
				Statement stmt2 = con.createStatement();
				result2 = stmt2.executeQuery(str2);
				result2.next();
				int totalRidesGiven = result2.getInt("c");
				
				
				//display proportional income
				ResultSet result3 = null;
				String str3 = "SELECT COUNT(*) as c FROM rides";
				Statement stmt3 = con.createStatement();
				result3 = stmt3.executeQuery(str3);
				result3.next();
				int totalRides = result3.getInt("c");
				
				float income = ((float)totalRidesGiven/(float)totalRides)*100;
				if (totalRides == 0){ //0 rides exist ever
					income = (float)0;
				}
				out.print("<p>Your total rides given: "+totalRidesGiven+"/"+totalRides+"</p>");
				out.print("<p>You earned: "+income+"% of advertising income</p>");
			}
			
			out.print("<table border=\"1\"><tr><td>#Driven</td><td>Driver</td></tr>");
			while(result.next()){
				out.print("<tr><td>"+result.getInt("c")+"</td><td>"+result.getString("driver")+"</td></tr>");
			}
			out.print("</table>");
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			
		} catch (Exception ex) {
			out.print("Getting rides failed <br> " + ex);
		}
		

		%>
</body>
</html>