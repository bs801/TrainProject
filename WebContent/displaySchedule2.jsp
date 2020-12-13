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
<form action="" method="POST">
<%
/*
	The origin and the destination will be sent here.
	We need to find the stop id of both the origin and the destinaton. 
	Do this by looping through TrainProject.TransitStops.get("ASDF", 0, i).toString(); and check if
	the strings are equal. If they are, i is the stop id.
	Then check if the stop id for the origin is greather than the stop id for the destination. 
	This determines if its a reverse line or not. 
	Once this is done, you can loop through all the stops from the origin to destination with the range
	of stop ids found and the check for if the line is reversed or not.
*/

int origin = Integer.parseInt(request.getParameter("origin"));  
int destination = Integer.parseInt(request.getParameter("destination"));
			
ArrayList<String> cities = (ArrayList<String>) session.getAttribute("cities");

String cityA = cities.get(origin);
String cityB = cities.get(destination);

String date = request.getParameter("date");
LocalDate departureDate = LocalDate.parse(date);


Timestamp t = Timestamp.valueOf(departureDate.atStartOfDay());
t.toLocalDateTime().toLocalTime();

//SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");


ArrayList<ReservationBuilder> validReservations = ReservationBuilderService.getReservationOptions(departureDate, cityA, cityB);

//validReservations.get(0).reservationStops.get(0);
//validReservations.get(0).reservationStops.get( validReservations.get(0).reservationStops.size()-1 );


// Say you have a schedule that does F -> D -> A -> H -> J -> B -> K -> L 
// This method will return arraylist { A H J B } or NULL
		
//  A -> H -> J -> B   Fare:  [Select this]
		
for(ReservationBuilder rb : validReservations){
	ScheduleStop orig = rb.reservationStops.get(0); // { A H J B }
	ScheduleStop dest = rb.reservationStops.get(	rb.reservationStops.size() - 1 );
	out.println(orig + " -> "+ dest);
	out.println("<br></br>");
	
	out.println("Stops: ");
	for(ScheduleStop st : rb.reservationStops){ 
		out.println(st); // A then H then J then B
		out.println(", ");
	}
	//out.println(orig.departureTime);
	//out.println(dest.arrivalTime);
	out.println("Fare: ");
	out.println(rb.fare);
	
}


String scheduleDate = "";
//out.println(date);


ArrayList<Station> stations = TrainProject.Stations.getAsList();
ArrayList<Station> originStations = new ArrayList<Station>();
ArrayList<Station> destinationStations = new ArrayList<Station>();
ArrayList<Station> coverage = new ArrayList<Station>();
ArrayList<Schedule> schedule;

/*
for(Station s : stations){
	if(origin.equals(s.city.replaceAll("\\s", ""))){
		originStations.add(s);
	}
	if(destination.equals(s.city.replaceAll("\\s", ""))){
		destinationStations.add(s);
	}
} */



/*for(Station oStation: originStations){
	for(Station dStation: destinationStations){
		System.out.println("Checking schedules for " + oStation + dStation);
		schedule = Schedule.getCoveringSchedules(oStation, dStation);
				
		for(Schedule s : schedule){
			scheduleDate = sdfDate.format(s.scheduleDepartureTime);
			out.println(scheduleDate);
			out.println("<br></br>");
			out.println("Line: " + s.getCoverage(oStation, dStation));
			out.println("<br></br>");
			if(date.equals(scheduleDate)){
				out.println("Schedules: " + s.getCoveringSchedules(oStation, dStation));
			}
		}
	}
}*/





/*String temp;
			
int originStopId = 0; 
int destinationStopId = 0;
int reverseCheck = 0;
			
ArrayList<Integer> stopIds = new ArrayList<Integer>();
ArrayList<TransitStop> stops = TrainProject.TransitLines.get("ASDF", 0).getTransitStops();
//ArrayList<Schedule> schedule = TrainProject.Schedules.getAsList();
int i = 0;
Float transitLineFare = 0f;
int numberOfStops = TrainProject.TransitLines.get("ASDF", reverseCheck).numberOfStops;


//for(Schedule x : schedule){
//	out.println(x.toString());
//}

//for(TransitStop s : stops){ // check to see how many stops the line has, used to loop to find the stops selected
//	stopIds.add(i);
//	i++;
//}

for(int j = 0; j<numberOfStops; j++){ // loop through stops selected and get their ids
	temp = TrainProject.TransitStops.get("ASDF", 0, j).toString();
	if(origin.equals(temp.replaceAll("\\s", ""))){
		originStopId = j;
	}
	if(destination.equals(temp.replaceAll("\\s", ""))){
		destinationStopId = j;
	}
}

System.out.println(originStopId);
System.out.println(destinationStopId);

if(originStopId > destinationStopId){ // check if the stops selected are a reverse line.
	reverseCheck = 1;
}

stops = TrainProject.TransitLines.get("ASDF", reverseCheck).getTransitStops();

if(reverseCheck == 0){
	for(int j = originStopId + 1; j < destinationStopId; j++){
		temp = TrainProject.TransitStops.get("ASDF", reverseCheck, j).toString();
		out.println("List of Stops: ");
		out.println(temp);
	}
}
else if(reverseCheck == 1){
	for(int j = originStopId -1; j > destinationStopId; j--){
		temp = TrainProject.TransitStops.get("ASDF", reverseCheck, j).toString();
		out.println("List of Stops: ");
		out.println(temp);
	}
}

transitLineFare = TrainProject.TransitLines.get("ASDF", reverseCheck).fare;
*/




/*

Thinking of using the inputed date to traverse through an array list of dates to see which ones match
and then display the times that coorespond with the date inputed.


*/



// test, nb, nw, penn
// 3,     2,  1,   0




%>
<input type="submit" value="Reserve"/> 
</form>
</body>
</html>