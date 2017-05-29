<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Register Staff</title>
</head>
<body>
<h1>Register Support Staff</h1>
	<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
	<form method="post" action="server/registerStaff.jsp">
		<table>
			<tr>    
				<td>Username</td><td><input type="text" name="username" required></td>
			</tr>
			<tr>
				<td>Password</td><td><input type="password" name="password" required></td>
			</tr>
			<tr>
				<td>E-mail</td><td><input type="email" name="email" required></td>
			</tr>
			<tr>
				<td>Name</td><td><input type="text" name="name" ></td>
			</tr>
			<tr>
				<td>Address</td><td><input type="text" name="address" ></td>
			</tr>
			<tr>
				<td>Phone</td><td><input type="text" name="phone" ></td>
			</tr>
		</table>
		<input type="submit" value="Register Staff">
	</form>
</body>
</html>
