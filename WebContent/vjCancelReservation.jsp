<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
    
    
<%
ArrayList<Reservation> res = TrainProject.Reservations.getAsList();
boolean go = false;
int i = 0;
for(i = 0; i< res.size(); i++) {
	if(request.getParameter(res.get(i).reservationID+"") != null){
		go = true;
		break;
	}
}
if(go){
	TrainProject.Reservations.cancel(res.get(i));
} else {
	out.println("ERROR");
}
out.println("CANCELLED RESERVATION: ");
out.println(res.get(i));


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>