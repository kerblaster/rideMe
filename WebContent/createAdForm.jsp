<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0035)http://192.168.1.9:8080/cs336Final/ -->
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>Create Ad</title>
</head>
<body>
<h1>Create Text Ad</h1>
	<div style="position:absolute;top:0;right:0;">[<a href="index.jsp">GO HOME</a>]</div>
	<form method="post" action="server/createAd.jsp">
		<table>
			<tr>
				<td>Advertiser</td><td><input type="text" name="advertiser" ></td>
			</tr>	
			<tr>
				<td>Ad content</td><td><textarea name="content" rows="8" cols="60" required></textarea></td>
			</tr>		
		</table>
		<input type="submit" value="Create Ad">
	</form>
</body>
</html>
