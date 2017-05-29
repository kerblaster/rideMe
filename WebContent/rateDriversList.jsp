<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Rate Past Drivers</title>
	</head>
	<body>
	<h1>Rate Past Drivers</h1>
	<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
		<%!
		String getActualLocation(String sqlLocation){
			if (sqlLocation.equals("dest_ca") || sqlLocation.equals("depart_ca")){
				return "College Ave";
			} else if (sqlLocation.equals("dest_cd") || sqlLocation.equals("depart_cd")){
				return "Cook/Douglas";
			} else if (sqlLocation.equals("dest_livi") || sqlLocation.equals("depart_livi")){
				return "Livingston";
			} else if (sqlLocation.equals("dest_busch") || sqlLocation.equals("depart_busch")){
				return "Busch";
			} 
			return "undefined";
		}
		%>
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
			
			//Get parameters from the HTML form
			String departure = request.getParameter("departure");
			String destination = request.getParameter("destination");
			String time = request.getParameter("timeStart") + "-" + request.getParameter("timeEnd");
			String recurring = request.getParameter("recurring");
			
			//Check counts once again (the same as the above)
			String str = "SELECT * FROM rides, rideRequests WHERE rides.rideId=rideRequests.rideId AND rideRequests.rider='"+session.getAttribute("user.username").toString()+"' AND rides.rideId NOT IN (SELECT ratings.rideId FROM ratings WHERE ratings.userRater='"+session.getAttribute("user.username").toString()+"')";
			result = stmt.executeQuery(str);
			
			int numResults = 0;
			while(result.next()){
				String html = "<p>Driven by "+result.getString("driver")+" from "+getActualLocation(result.getString("departure"))+" to "+getActualLocation(result.getString("destination"))+" at "+result.getString("date");
				html += "&nbsp;<button onclick=\"window.location.href='rateDriverForm.jsp?rideId="+result.getString("rideId")+"&driver=" + result.getString("driver") + "'\">Rate Driver</button></p>";
				numResults++;
				out.print(html);
			}
			if (numResults == 0){
				out.print("You have rated all your drivers");
			}
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
		} catch (Exception ex) {
			if (session.getAttribute("user.username") == null){
				response.sendRedirect("/login.jsp");
			}
			out.print("Getting driver list failed <br> " + ex);
		}
		

		%>
	</body>
</html>