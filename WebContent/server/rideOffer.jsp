<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Offer a ride</title>
	</head>
	<body>
		<h1>Offer a ride</h1>
			<div style="position:absolute;top:0;right:0;">[<a href="../index.jsp">GO HOME</a>]</div>
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
			if (recurring == null){
				recurring = "0";
			}
			
			//Check counts once again (the same as the above)
			String str = "SELECT * FROM rideRequests WHERE rideRequests.departure = '" + departure + "' AND rideRequests.destination = '" + destination + "' AND rideRequests.recurring = '" + recurring +"' AND rideRequests.rideId NOT IN (SELECT rides.rideId FROM rides)";
			result = stmt.executeQuery(str);
			
			//redirect to matches page
			//response.sendRedirect("matches.jsp");
			
			int numResults = 0;
			out.print("<table><tr><td>Rider</td><td>Departure</td><td>Destination</td><td>Time Window</td><td>Recurring</td><td>Give ride?</td></tr>");
			while(result.next()){
				String isRecurringStr = "";
				if (result.getString("recurring").equals("1")){
					isRecurringStr = "X";
				}
				String html = "<tr><td>"+result.getString("rider")+"</td><td>"+getActualLocation(result.getString("departure"))+"</td><td>"+getActualLocation(result.getString("destination"))+"</td><td>"+result.getString("timeWindow")+"</td><td>"+isRecurringStr+"</td><td><button onclick='window.location.href=\"../ratePassengerForm.jsp?rideId=" + result.getString("rideId") + "\"'>Give dude a ride</button></td></tr>";
				
				//time logic bullshit
				String[] offerTime = result.getString("timeWindow").split("-");
				String[] offerTimeStartStr = offerTime[0].split(":");
				String[] offerTimeEndStr = offerTime[1].split(":");
				int offerTimeStart = Integer.parseInt(offerTimeStartStr[0] + offerTimeStartStr[1]);
				int offerTimeEnd = Integer.parseInt(offerTimeEndStr[0] + offerTimeEndStr[1]);
				String[] requestTime = time.split("-");
				String[] requestTimeStartStr = requestTime[0].split(":");
				String[] requestTimeEndStr = requestTime[1].split(":");
				int requestTimeStart = Integer.parseInt(requestTimeStartStr[0] + requestTimeStartStr[1]);
				int requestTimeEnd = Integer.parseInt(requestTimeEndStr[0] + requestTimeEndStr[1]);
				boolean timeMatches = !(offerTimeEnd < requestTimeStart || offerTimeStart > requestTimeEnd);
				
				boolean recurringMatches = result.getString("recurring").equals(recurring);
				
				boolean diffPerson = !result.getString("rider").equals(session.getAttribute("user.username").toString());
				
				if (diffPerson && timeMatches && recurringMatches){
					numResults++;
					out.print(html);
				}	
			}
			out.print("</table>");
			if (numResults == 0){
				out.print("No matching requests :(");
			}
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			
		} catch (Exception ex) {
			out.print("connection failed <br> " + ex);
		}
		

		%>
	</body>
</html>