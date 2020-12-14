<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top 5 Stations</title>
</head>
<body>
<h1>Top Stations: </h1>
<%

ArrayList<Reservation> reservations = TrainProject.Reservations.getAsList();
HashMap<String, Integer> topFive = new HashMap<String, Integer>();
int i = 0;

for(Reservation r : reservations){
	if(r.cancelled == 0){
		if(topFive.get(r.forward_transitLineName) != null){
			System.out.println(r.forward_transitLineName);
			i = topFive.get(r.forward_transitLineName);
		}
		topFive.put(r.forward_transitLineName, i+1);
		System.out.println(i+1);
		i = 0;
	}
}

System.out.println("-------------------");

i = 0;

for(Reservation r : reservations){
	if(r.return_transitLineName != null){
		
		if(topFive.get(r.return_transitLineName) != null){
			System.out.println(r.return_transitLineName);
			i = topFive.get(r.return_transitLineName);
		}
		topFive.put(r.return_transitLineName, i+1);	
		System.out.println(i+1);
	}
	i = 0;
}

List<Map.Entry<String, Integer> > list = 
new LinkedList<Map.Entry<String, Integer> >(topFive.entrySet()); 

Collections.sort(list, new Comparator<Map.Entry<String, Integer> >() { // sorts the list associated with the hashmap
	public int compare(Map.Entry<String, Integer> one, 
					Map.Entry<String, Integer> two) 
	{ 
		return (two.getValue()).compareTo(one.getValue()); 
	} 
}); 

HashMap<String, Integer> sortedList = new LinkedHashMap<String, Integer>(); // puts sorted list into hashmap
for (Map.Entry<String, Integer> l : list) { 
	sortedList.put(l.getKey(), l.getValue()); 
} 


for (Map.Entry<String, Integer> sl : sortedList.entrySet()) { // displays the top used transitlines.
	
	out.println("Transit Line: " + sl.getKey() + 
				", Number of Reservations = " + sl.getValue());
	out.println("<br></br>");
} 


%>
</body>
</html>