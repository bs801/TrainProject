<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Train Schedule</title>
</head>
<body>

<h1>Train Schedule</h1>

<%
/*
	boolean pta = false;
	boolean inputOriginPresent = ((Boolean) session.getAttribute("inputOriginPresent")).booleanValue();
	boolean inputDestinationPresent = ((Boolean) session.getAttribute("inputDestinationPresent")).booleanValue();
	if(inputOriginPresent){
		out.println("This is the inputed Origin: "+session.getAttribute("inputOrigin"));
		out.println("<br><br/>");
	}
	if(inputDestinationPresent){
		out.println("This is the inputed Destination: "+session.getAttribute("inputDestination"));
	}

	session.setAttribute("inputOriginPresent",false);
	session.setAttribute("inputDestinationPresent",false);
	
	*/
	
%>



<form action="trainScheduleSearchChecking.jsp" method="POST">
Origin <input type="text" name="inputOrigin" placeholder="Origin"/><br/>
Destination  <input type="text" name="inputDestination" placeholder="Destination"/><br/>
Date <input type="date" name="inputDate"/><br/>

<input type="text" class= "date" name = "date" value = "<fmt:formatDate value="${dateVar}" pattern="MM-dd-yyyy" />"/>
<input type="submit" value="Submit"/>
</form>

</body>
</html>