<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List of Recurring Rides</title>
</head>
<body>
<h1>List of your Recurring Rides</h1>
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
			//Create a connection string
			//String url = "jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample";
			String url = "jdbc:mysql://cs336g32.cyi4cdd85yp2.us-east-1.rds.amazonaws.com:3306/cs336g32";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
	
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "admin", "password");
			
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM ridesRecurring, rides, rideRequests, cars WHERE ridesRecurring.rideId=rides.rideId AND ridesRecurring.rideId=rideRequests.rideId AND rides.carId=cars.carId AND (rideRequests.rider='"+session.getAttribute("user.username").toString()+"' OR rides.driver='"+session.getAttribute("user.username").toString()+"')";
			ResultSet result = stmt.executeQuery(str);
			
			int numResults = 0;
			out.print("<table><tr><td>Driver</td><td>Passenger</td><td>Departure</td><td>Destination</td><td>Car</td><td>Time</td></tr>");
			while(result.next()){ 
				String html = "<tr><td>"+result.getString("driver")+"</td><td>"+result.getString("rider")+"</td><td>"+getActualLocation(result.getString("departure"))+"</td><td>"+getActualLocation(result.getString("destination"))+"</td><td>"+result.getString("carDesc")+"</td><td>"+result.getString("timeWindow")+"</td><td><button onclick=\"window.location.href='server/cancelRecurring.jsp?rideId="+result.getString("rideId")+"'\">Cancel</button></td></tr>";
				numResults++;
				out.print(html);
			}
			out.print("</table>");
			if (numResults == 0){
				out.print("You have no recurring rides");
			}
			
			//redirect
			con.close();
			
		} catch (Exception ex) {
			out.print("List of recurring ride failed <br> " + ex);
		}
		%>
</body>
</html>