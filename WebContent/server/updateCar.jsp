<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change default car</title>
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
			
			String carId = request.getParameter("carId");
			
			//Check counts once again (the same as the above)
			String str = "SELECT * FROM cars WHERE owner = '"+session.getAttribute("user.username").toString()+"'";
			ResultSet result = stmt.executeQuery(str);
			
			while(result.next()){
				if(result.getInt("carId")==Integer.parseInt(carId)){
					//make default
					String str2 = "UPDATE cars SET isDefault=1 WHERE carId = '"+result.getInt("carId")+"'";
					PreparedStatement ps = con.prepareStatement(str2);
					ps.executeUpdate();
				}
				else{
					//make not default
					String str2 = "UPDATE cars SET isDefault=0 WHERE carId = '"+result.getInt("carId")+"'";
					PreparedStatement ps = con.prepareStatement(str2);
					ps.executeUpdate();
				}
			}
			
			//redirect
			con.close();
			
			response.sendRedirect("../setCarForm.jsp");
			
		} catch (Exception ex) {
			out.print("Car default failed <br> " + ex);
		}
		%>
</body>
</html>