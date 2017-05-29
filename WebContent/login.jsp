<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Login</title>
</head>
<body>
<h1>Login</h1>					  
	<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
<br>
	<p>Please login to continue...</p>
	<form method="post" action="server/userCheck.jsp">
	<table>
	<tr>    
		<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
		<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Login">
	</form>
</body>
</html>