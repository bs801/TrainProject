<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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

String origin = request.getParameter("origin");   
String destination = request.getParameter("destination");

String temp;
			
int originStopId = 0;
int destinationStopId = 0;
int reverseCheck = 0;
			
ArrayList<Integer> stopIds = new ArrayList<Integer>();
ArrayList<TransitStop> stops = TrainProject.TransitLines.get("ASDF", 0).getTransitStops();
int i = 0;

for(TransitStop s : stops){ // check to see how many stops the line has, used to loop to find the stops selected
	stopIds.add(i);
	i++;
}

for(int j = 0; j<stopIds.size(); j++){ // loop through stops selected and get their ids
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

// test, nb, nw, penn
// 3,     2,  1,   0




%>

</body>
</html>