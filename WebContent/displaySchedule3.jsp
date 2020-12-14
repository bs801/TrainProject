<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%


//ReservationBuilder i = request.getParameter(rb);  
// unsure of how to get the parameter

ArrayList<ReservationBuilder> rbList = (ArrayList<ReservationBuilder>)session.getAttribute("ds2");
int i = 0;
for(i = 0; i < rbList.size(); i++){
	if(request.getParameter(i+"") != null){
		break;
	}
}

ReservationBuilder selectedReservation = rbList.get(i);



%>

</body>
</html>