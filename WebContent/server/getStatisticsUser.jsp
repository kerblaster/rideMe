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
			String time = request.getParameter("time");
			
			String str = "SELECT * FROM rides WHERE rides.driver = '"+session.getAttribute("user.username").toString()+"'";
			ResultSet ridesGiven = stmt.executeQuery(str);
			
			Statement stmt2 = con.createStatement();
			
			String str2 = "SELECT * FROM rideRequests WHERE rideRequests.rider = '"+session.getAttribute("user.username").toString()+"' AND rideRequests.rideId IN (SELECT rideId FROM rides)";
			ResultSet ridesTaken = stmt2.executeQuery(str2);
			
			int givenCount = 0;
			
			while(ridesGiven.next()){
				String date = ridesGiven.getString("date");
				
				String month = date.substring(date.indexOf("-")+1);
				month = month.substring(0, month.indexOf("-"));
				int m = Integer.parseInt(month);
				
				if(time.equals("month")){
					String month2 = request.getParameter("monthList");
					
					if(month2.equals("january")){
						if(m==1)
							givenCount++;
					}
					else if(month2.equals("february")){
						if(m==2)
							givenCount++;
					}
					else if(month2.equals("march")){
						if(m==3)
							givenCount++;
					}
					else if(month2.equals("april")){
						if(m==4)
							givenCount++;
					}
					else if(month2.equals("may")){
						if(m==5)
							givenCount++;
					}
					else if(month2.equals("june")){
						if(m==6)
							givenCount++;
					}
					else if(month2.equals("july")){
						if(m==7)
							givenCount++;
					}
					else if(month2.equals("august")){
						if(m==8)
							givenCount++;
					}
					else if(month2.equals("september")){
						if(m==9)
							givenCount++;
					}
					else if(month2.equals("october")){
						if(m==10)
							givenCount++;
					}
					else if(month2.equals("november")){
						if(m==11)
							givenCount++;
					}
					else if(month2.equals("december")){
						if(m==12)
							givenCount++;
					}
				}
				else{
					String semester = request.getParameter("semesterList");
						if(semester.equals("fall")){
							if(m>8)
								givenCount++;
						}
						else if(semester.equals("spring")){
							if(m<6)
								givenCount++;
						}
				}
			}
			
			int takenCount = 0;
			
			while(ridesTaken.next()){
				int rId = ridesTaken.getInt("rideId");
				Statement temp = con.createStatement();
				
				ResultSet temp2 = temp.executeQuery("SELECT * FROM rides WHERE rideId = '"+rId+"'");
				temp2.next();
				
				String date = temp2.getString("date");
				
				String month = date.substring(date.indexOf("-")+1);
				month = month.substring(0, month.indexOf("-"));
				int m = Integer.parseInt(month);
				
				if(time.equals("month")){
					String month2 = request.getParameter("monthList");
					
					if(month2.equals("january")){
						if(m==1)
							takenCount++;
					}
					if(month2.equals("february")){
						if(m==2)
							takenCount++;
					}
					if(month2.equals("march")){
						if(m==3)
							takenCount++;
					}
					if(month2.equals("april")){
						if(m==4)
							takenCount++;
					}
					if(month2.equals("may")){
						if(m==5)
							takenCount++;
					}
					if(month2.equals("june")){
						if(m==6)
							takenCount++;
					}
					if(month2.equals("july")){
						if(m==7)
							takenCount++;
					}
					if(month2.equals("august")){
						if(m==8)
							takenCount++;
					}
					if(month2.equals("september")){
						if(m==9)
							takenCount++;
					}
					if(month2.equals("october")){
						if(m==10)
							takenCount++;
					}
					if(month2.equals("november")){
						if(m==11)
							takenCount++;
					}
					if(month2.equals("december")){
						if(m==12)
							takenCount++;
					}
				}
				else{
					String semester = request.getParameter("semesterList");
						if(semester.equals("fall")){
							if(m>8)
								takenCount++;
						}
						else if(semester.equals("spring")){
							if(m<6)
								takenCount++;
						}
				}
			}
			
			out.print("<p>Rides given in specified time: "+givenCount+"</p>");
			out.print("<p>Rides taken in specified time: "+takenCount+"</p>");
			
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
			
		} catch (Exception ex) {
			out.print("connection failed <br> " + ex);
		}
		

		%>
</body>
</html>