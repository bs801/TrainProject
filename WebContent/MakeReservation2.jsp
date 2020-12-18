<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%
	//Float disc = 0f;//Float.parseFloat(request.getParameter("disc"));
	float disc = 0f; 
	int orig = -1;
	int dest = -1;
	String rt = null;
	String date1 = null; //request.getParameter("date1");
	String date2= null;
	if(request.getParameter("disc") == null){
		disc = Float.parseFloat((String) session.getAttribute("disc"));
		orig = Integer.parseInt((String) session.getAttribute("orig"));
		dest = Integer.parseInt((String) session.getAttribute("dest"));
		rt = (String) session.getAttribute("rt");
		date1 = (String) session.getAttribute("date1");
	} else {
		disc =  Float.parseFloat(request.getParameter("disc"));
		orig = Integer.parseInt(request.getParameter("objectA"));
		dest = Integer.parseInt(request.getParameter("objectB"));
		
		
		rt = request.getParameter("rt");
		date1 = request.getParameter("date1");
		if(rt.equals("1")){
			date2 = request.getParameter("date2");
			session.setAttribute("date2",date2);
		}
		
		session.setAttribute("disc", disc+"");
		session.setAttribute("orig", orig+"");
		session.setAttribute("dest", dest+"");
		session.setAttribute("rt", rt);
	}
	session.setAttribute("disc", disc+"");
	/*
	//System.out.println(request.getParameter("objectA")+"REEE");
	//int origin = 23; //Integer.parseInt(request.getParameter("objectA"));  
	int orig = -1;
	if(request.getParameter("orig") == null){
		orig = (Integer) session.getAttribute("orig");
	}
	
	Integer.parseInt(request.getParameter("objectA"));
	int dest = Integer.parseInt(request.getParameter("objectB"));
	
	)*/
	//int destination = 17; //Integer.parseInt(request.getParameter("objectB"));
				
	//ArrayList<Object> options = Answer.getOps();//
	ArrayList<Object> options = (ArrayList<Object>) session.getAttribute("options");
	
	Object objectA = options.get(orig);
	Object objectB = options.get(dest);
	
	//System.out.println(objectA+" "+objectB);
	
	//String date1 = "2020-06-06";//request.getParameter("date1");
	
	LocalDate departureDate = LocalDate.parse(date1);
	
	
	//String date2 = "2020-06-06";//request.getParameter("date2");
	
	
	//String rt = "1";//request.getParameter("rt");
	//String rt = request.getParameter("rt");
	

	
	ArrayList<ReservationBuilder> validReservations = null;
	if(rt.equals("0")){
		session.setAttribute("rt", "0");
		validReservations = ReservationBuilderService.getReservationOptions(departureDate, objectA, objectB);
	} else {
		session.setAttribute("rt", "1");
		date2 = (String) session.getAttribute("date2");
		LocalDate returnDate = LocalDate.parse(date2);
		validReservations = ReservationBuilderService.getReservationOptions(departureDate, objectA, objectB, returnDate);
		out.println("INFO: "+ReservationBuilderService.omitted+" results were omitted for not having valid round trips");
	}
	

	
	String so = request.getParameter("so");
	String check1=""; String check2=""; String check3="";
	if("0".equals(so) || so == null){
		check1 = "checked";
		Collections.sort(validReservations,
	            new Comparator<ReservationBuilder>() {
	                public int compare(ReservationBuilder r1, ReservationBuilder r2)
	                {
	                    return (r1.getOrigin().departureTime.isBefore(r2.getOrigin().departureTime) ? -1 : 1);
	                }
	            }
		);
	} else if("1".equals(so)){
		check2 = "checked";
		Collections.sort(validReservations,
	            new Comparator<ReservationBuilder>() {
	                public int compare(ReservationBuilder r1, ReservationBuilder r2)
	                {
	                    return (r1.getDestination().arrivalTime.isBefore(r2.getDestination().arrivalTime) ? -1 : 1);
	                }
	            }
		);
	} else {
		check3 = "checked";
		Collections.sort(validReservations,
	            new Comparator<ReservationBuilder>() {
	                public int compare(ReservationBuilder r1, ReservationBuilder r2)
	                {
	                    return (r1.fare < r2.fare ? -1 : 1);
	                }
	            }
		);
	}
	if(validReservations.size() == 0){
		response.sendRedirect("MakeReservation.jsp");
		session.setAttribute("none", new Object());
		return;
	}
	session.setAttribute("validReservations", validReservations);

%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3> Showing schedules for <%=objectA%> => <%=objectB%> on <%=date1%> </h3><br></br>

<form action="MakeReservation2.jsp" method="POST">

Sort by departure time<input type="radio" name="so" value="0" <% out.println(check1); %> /> <br></br>
Sort by arrival time<input type="radio" name="so" value="1" <% out.println(check2); %> /><br></br>
Sort by fare <input type="radio" name="so" value="2" <% out.println(check3); %> /> <br></br>

<input type="Submit" name="sort" value="Sort"/>
</form>

<form action="MakeReservation3.jsp" method="POST">



<%
int iterator = 0;




for(ReservationBuilder rb : validReservations){
	System.out.println("RESERVATION FARE IS"+rb.fare);
	ArrayList<ScheduleStop> stopList = rb.reservationStops;
	%>
	<h4><%=rb.getOrigin().toString()+" at "+Formatting.displayTime(rb.getOrigin().departureTime)
	+" --> "+rb.getDestination().toString()+" at "+Formatting.displayTime(rb.getDestination().arrivalTime)%></h4>
	TransitLine: <%=rb.schedule.transitLineName %> <br></br>
	Train: <%=TrainProject.Trains.get(rb.schedule.trainID)%> <br></br> 
	Route: <% for(int i=0; i<stopList.size()-1; i++){ %> <%=stopList.get(i).getStation()+" - " %> <% } %> <%=stopList.get(stopList.size()-1).getStation() %>
	<br></br>Fare: <%=Formatting.getFare(rb.fare * (1f-disc))+(rt.equals("0") ? "": "  + return ticket price") %>
	
	
	<br></br><input name=<%=iterator%> type="submit" value="Select"/> 
	<br></br>

	<%
	out.println("<br></br>");
	iterator++;
}
%>

</form>

<form action="MakeReservation.jsp" method="POST">
<input type="Submit" value="Cancel"/>
</form>
</body>
</html>