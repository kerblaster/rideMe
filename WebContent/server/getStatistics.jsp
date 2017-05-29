<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div style="position:absolute;top:0;right:0;">[<a href="../index.jsp">GO HOME</a>]</div>
	<%
		try {
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
			String mode = request.getParameter("mode");
			
			if(mode.equals("time")){
				String time = request.getParameter("query").toLowerCase();
				
				String str = "SELECT * FROM rides";
				ResultSet result = stmt.executeQuery(str);
				int count = 0;
				while(result.next()){
					//2017-04-23 00:45:09
					String date = result.getString("date");
					String year = date.substring(0, date.indexOf("-"));
					date = date.substring(date.indexOf("-")+1);
					String month = date.substring(0, date.indexOf("-"));
					date = date.substring(date.indexOf("-")+1);
					String day = date.substring(0, date.indexOf(" "));
					date = date.substring(date.indexOf(" ")+1);
					String hour = date.substring(0, date.indexOf(":"));
					date = date.substring(date.indexOf(":")+1);
					String min = date.substring(0, date.indexOf(":"));
					date = date.substring(date.indexOf(":")+1);
					String sec = date;
					
					java.util.Date d = new java.util.Date(Integer.parseInt(year)-1900, Integer.parseInt(month)-1, Integer.parseInt(day));
					
						if(time.equals("monday") || time.equals("mon")){
							if(d.getDay()==1)
								count++;
						}
						else if(time.equals("tuesday") || time.equals("tues")){
							if(d.getDay()==2)
								count++;
						}
						else if(time.equals("wednesday") || time.equals("wed")){
							if(d.getDay()==3)
								count++;
						}
						else if(time.equals("thursday") || time.equals("thurs")){
							if(d.getDay()==4)
								count++;
						}
						else if(time.equals("friday") || time.equals("fri")){
							if(d.getDay()==5)
								count++;
						}
						else if(time.equals("saturday") || time.equals("sat")){
							if(d.getDay()==6)
								count++;
						}
						else if(time.equals("sunday") || time.equals("sun")){
							if(d.getDay()==0)
								count++;
						}
						else if(time.equals("january") || time.equals("jan")){
							if(d.getMonth()==0)
								count++;
						}
						else if(time.equals("february") || time.equals("feb")){
							if(d.getMonth()==1)
								count++;
						}
						else if(time.equals("march") || time.equals("mar")){
							if(d.getMonth()==2)
								count++;
						}
						else if(time.equals("april") || time.equals("apr")){
							if(d.getMonth()==3)
								count++;
						}
						else if(time.equals("may")){
							if(d.getMonth()==4)
								count++;
						}
						else if(time.equals("june") || time.equals("jun")){
							if(d.getMonth()==5)
								count++;
						}
						else if(time.equals("july") || time.equals("jul")){
							if(d.getMonth()==6)
								count++;
						}
						else if(time.equals("august") || time.equals("aug")){
							if(d.getMonth()==7)
								count++;
						}
						else if(time.equals("september") || time.equals("sept")){
							if(d.getMonth()==8)
								count++;
						}
						else if(time.equals("october") || time.equals("oct")){
							if(d.getMonth()==9)
								count++;
						}
						else if(time.equals("november") || time.equals("nov")){
							if(d.getMonth()==10)
								count++;
						}
						else if(time.equals("december") || time.equals("dec")){
							if(d.getMonth()==11)
								count++;
						}
						else{
							try{
								//year
								int y1 = Integer.parseInt(time);
								int y2 = Integer.parseInt(year);
								if(y1==y2)
									count++;
							} catch(Exception e){
								//week
								if(time.contains("week")){
									
								}
								//semester
								else if(time.matches(".* [0-9]*")){
									String season = time.substring(0, time.indexOf(" "));
									int y = Integer.parseInt(time.substring(time.indexOf(" ")+1));
									if(y==Integer.parseInt(year)){
										if(season.equals("spring")){
											if(d.getMonth()<5)
												count++;
										}
										else if(season.equals("fall") || season.equals("autumn")){
											if(d.getMonth()>7)
												count++;
										}else{
											throw new Exception("Invalid query format");
										}
									}
								}
								//time of day
								else if(time.matches("..:..:..")){
									String dateString = d.toString();
									dateString = dateString.substring(dateString.indexOf(" ")+1);
									dateString = dateString.substring(dateString.indexOf(" ")+1);
									dateString = dateString.substring(dateString.indexOf(" ")+1);
									dateString = dateString.substring(0, dateString.indexOf(" "));
									if((hour+":"+min+":"+sec).equals(dateString))
										count++;
								}else{
									throw new Exception("Invalid query format");
								}
							}
						}
				}
				out.print("<p>Total rides matching indicated time: "+count+"</p>");
			}
			else if(mode.equals("user")){
				String username = request.getParameter("query");
				
				Statement stmt2 = con.createStatement();
				
				String str = "SELECT COUNT(*) AS d FROM rides WHERE rides.driver = '"+username+"'";
				ResultSet driverResult = stmt2.executeQuery(str);
				
				Statement stmt3 = con.createStatement();
				
				String str2 = "SELECT COUNT(*) AS r FROM rideRequests WHERE rideRequests.rider = '"+username+"' AND rideRequests.rideId IN (SELECT rideId FROM rides)";
				ResultSet riderResult = stmt3.executeQuery(str2);
				
				driverResult.next();
				riderResult.next();
				
				int dTotal = driverResult.getInt("d");
				int rTotal = riderResult.getInt("r");
				
				out.print("<p>Total rides as driver: "+dTotal+"</p>");
				out.print("<p>Total rides as rider: "+rTotal+"</p>");
			}
			else if(mode.equals("origin")){
				String origin = request.getParameter("query");
				String newOrigin = origin;
				if(origin.toLowerCase().equals("college ave"))
					newOrigin = "ca";
				else if(origin.toLowerCase().equals("cook douglass"))
					newOrigin = "cd";
				else if(origin.toLowerCase().equals("livingston"))
					newOrigin = "livi";
				newOrigin = "depart_" + newOrigin.toLowerCase();
				
				Statement stmt2 = con.createStatement();
				
				String str = "SELECT COUNT(*) AS t FROM rideRequests WHERE rideRequests.departure = '"+newOrigin+"' AND rideRequests.rideId IN (SELECT rideId FROM rides)";
				ResultSet riderResult = stmt2.executeQuery(str);
				
				riderResult.next();
				
				int total = riderResult.getInt("t");
				
				out.print("<p>Total rides from "+origin+": "+total+"</p>");
			}
			else if(mode.equals("destination")){
				String destination = request.getParameter("query");
				String newDestination = destination;
				if(destination.toLowerCase().equals("college ave"))
					newDestination = "ca";
				else if(destination.toLowerCase().equals("cook douglass"))
					newDestination = "cd";
				else if(destination.toLowerCase().equals("livingston"))
					newDestination = "livi";
				newDestination = "dest_" + newDestination.toLowerCase();
				
				Statement stmt2 = con.createStatement();
				
				String str = "SELECT COUNT(*) AS t FROM rideRequests WHERE rideRequests.destination = '"+newDestination+"' AND rideRequests.rideId IN (SELECT rideId FROM rides)";
				ResultSet riderResult = stmt2.executeQuery(str);
				
				riderResult.next();
				
				int total = riderResult.getInt("t");
				
				out.print("<p>Total rides to "+destination+": "+total+"</p>");
			}else{
				throw new Exception("Invalid query format");
			}
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			
		} catch (Exception ex) {
			out.print("connection failed <br> " + ex);
		}
		

		%>
</body>
</html>