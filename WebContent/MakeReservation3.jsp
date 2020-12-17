<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%

	ReservationBuilder selectedBuilder;
	if(session.getAttribute("selectedBuilder") != null /* && session.getAttribute("so") != null*/){
		System.out.println("RETURNING");
		selectedBuilder = (ReservationBuilder) session.getAttribute("selectedBuilder");
	} else {
		System.out.println("NOT RETURNING");
		ArrayList<ReservationBuilder> rblist = (ArrayList<ReservationBuilder>) session.getAttribute("validReservations");
		int i=0;
		for(i=0; i<rblist.size(); i++){
			if(request.getParameter(i+"") != null){
				break;
			}
		}
		selectedBuilder = rblist.get(i);
		session.setAttribute("selectedBuilder", selectedBuilder);
	}
	
	if(((String) session.getAttribute("rt")).equals("0")){
		response.sendRedirect("MakeReservation4.jsp");
	} 
	
	ArrayList<ReservationBuilder> validReturnBuilders = selectedBuilder.candidateReturnBuilders; //selectedBuilder.getReturnBuilders();
	
	String so = request.getParameter("so");
	String check1=""; String check2=""; String check3="";
	if("0".equals(so) || so == null){
		check1 = "checked";
		Collections.sort(validReturnBuilders,
	            new Comparator<ReservationBuilder>() {
	                public int compare(ReservationBuilder r1, ReservationBuilder r2)
	                {
	                    return (r1.getOrigin().departureTime.isBefore(r2.getOrigin().departureTime) ? 1 : -1);
	                }
	            }
		);
	} else if("1".equals(so)){
		check2 = "checked";
		Collections.sort(validReturnBuilders,
	            new Comparator<ReservationBuilder>() {
	                public int compare(ReservationBuilder r1, ReservationBuilder r2)
	                {
	                    return (r1.getDestination().arrivalTime.isBefore(r2.getDestination().arrivalTime) ? -1 : 1);
	                }
	            }
		);
	} else {
		check3 = "checked";
		Collections.sort(validReturnBuilders,
	            new Comparator<ReservationBuilder>() {
	                public int compare(ReservationBuilder r1, ReservationBuilder r2)
	                {
	                    return (r1.fare < r2.fare ? -1 : 1);
	                }
	            }
		);
	}
	String rt = "1";
	float disc = Float.parseFloat((String) session.getAttribute("disc"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<form action="MakeReservation3.jsp" method="POST">
Sort by departure time<input type="radio" name="so" value="0" <% out.println(check1); %> /> <br></br>
Sort by arrival time<input type="radio" name="so" value="1" <% out.println(check2); %> /><br></br>
Sort by fare <input type="radio" name="so" value="2" <% out.println(check3); %> /> <br></br>
<input type="Submit" name="sort" value="Sort"/>
</form>


<form action="MakeReservation4.jsp" method="POST">
<%
int iterator = 0;

for(ReservationBuilder rb : validReturnBuilders){
	
	ArrayList<ScheduleStop> stopList = rb.reservationStops;
	%>
	<h4><%=rb.getOrigin().toString()+" at "+Formatting.displayTime(rb.getOrigin().departureTime)
	+" --> "+rb.getDestination().toString()+" at "+Formatting.displayTime(rb.getDestination().arrivalTime)%></h4>
	TransitLine: <%=rb.schedule.transitLineName%> <br></br>
	Train: <%=TrainProject.Trains.get(rb.schedule.trainID)%> <br></br> 
	Route: <%
 	for(int i=0; i<stopList.size()-1; i++){
 %> <%=stopList.get(i).getStation()+" - "%> <%
 	}
 %> <%=stopList.get(stopList.size()-1).getStation()%>
	<br></br>Fare: <%=Formatting.getFare(rb.fare * (1-disc))+(rt.equals("0") ? "": " +"+Formatting.getFare(selectedBuilder.fare))%>

	<br></br><input name=<%=iterator%> type="submit" value="Select"/> 
	<br></br>

	<%
	out.println("<br></br>");
	iterator++;
}%>
</form>

<form action="MakeReservation.jsp" method="POST">
<input type="Submit" value="Cancel"/>
</form>
</body>
</html>

	