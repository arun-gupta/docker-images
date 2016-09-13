<html>
<body style="background-color:green;">
<h1>Simple Web Application - v1</h1>
<table>
<tr><td><b>Timestamp<b></td><td> <% out.print(new java.util.Date()); %> </td></tr>
<tr><td><b>Local address<b></td><td> <%= request.getLocalAddr() %> </td></tr>
<tr><td><b>Host name<b></td><td> <% out.print(System.getenv("HOSTNAME")); %> </td></tr>
</table>
</body>
</html>
