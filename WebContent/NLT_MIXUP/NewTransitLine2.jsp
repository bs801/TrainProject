<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<% 


	if(request.getParameter("NewTransitLineX") != null){
		int orig = Integer.parseInt(request.getParameter("ORIG"));
		int dest = Integer.parseInt(request.getParameter("DEST"));
		ArrayList<String> errors = new ArrayList<String>();
		if(orig == dest){
			errors.add("Origin must be a different station than the destination");
		}
		try{
			float f = Float.parseFloat(request.getParameter("FARE"));
			if(f < 0 || f > 200){
				
				errors.add("Fare must be an between 0 and 200");
			}
		}catch(Exception e){
			errors.add("Fare must be a decimal number");
		}
		if(errors.size() > 0){
			session.setAttribute("NTL2", errors);
			response.sendRedirect("NewTransitLineX.jsp");
			return;
		}
	}	
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Class.forName("com.mysql.jdbc.Driver");
	
	ArrayList<Station> stations = (ArrayList<Station>) session.getAttribute("NTL1");
	
	if(request.getParameter("NewTransitLineX") != null){
		/*
		Statement stO = con.createStatement();
		ResultSet rsO = stO.executeQuery("select * from station where stationID = "+Integer.parseInt(request.getParameter("ORIG")));
		Statement stD = con.createStatement();
		ResultSet rsD = stD.executeQuery("select * from station where stationID = "+Integer.parseInt(request.getParameter("DEST")));
		
		rsO.next(); rsD.next();
		Station sO = new Station((int) rsO.getFloat(1), rsO.getString(2), null, null);
		Station sD = new Station((int) rsD.getFloat(1), rsD.getString(2), null, null);
		*/
		int o = Integer.parseInt(request.getParameter("ORIG"));
		int d = Integer.parseInt(request.getParameter("DEST"));
		TransitLineX t = new TransitLineXX(stations.get(o), stations.get(d),  Float.parseFloat(request.getParameter("FARE")));
		
		session.setAttribute("NLT2",t);
	}
	
	TransitLineX t = (TransitLineX) session.getAttribute("NLT2");
	
	if(request.getParameter("AddStation") != null){
		if(request.getParameter("STOP") == null){
			out.println("Error: To add an additional stop, you must select a placement for it <br></br>");
		} else {
			int pk = Integer.parseInt(request.getParameter("STOP"));
			//Statement stS = con.createStatement();
			//ResultSet rsS = stS.executeQuery("select * from station where stationID = "+Integer.parseInt(request.getParameter("STOP")));
			//rsS.next();
			int i;
			for(i=0; i<stations.size(); i++){
				if(stations.get(i).stationID == pk){
					break;
				}
			}
			int b = Integer.parseInt(request.getParameter("BETWEEN"));
			t.Stations.add(b, stations.get(i)); //new Station(pk, rsS.getString(2), null, null) );
		}
	}
	
	//out.println("The current route is: "+t.Stations.get(0));
	//for(int i=1; i<t.Stations.size(); i++){	
	//	out.println("=> "+t.Stations.get(i));
   // }
	//out.println("<br></br>");
	

%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h1> Add Route Stops </h1>
<form action="NewTransitLine2.jsp" method="GET">
	Select new station <select name="STOP">
		<% 
		ArrayList<Station> subset = new ArrayList<Station>();
		for(Station s : stations){
			if(t.Stations.contains(s)){
				continue;
			}
			subset.add(s);
		} 
		for(Station s : subset){ %>
	  	    <option value=<%=s.stationID%>> <%=s.name%></option>
	    <% } %>
	</select>
	
	<br></br>
	Select relative placement:
	<%
		out.println(" ORIGIN ["+t.Stations.get(0)+"] =");
		for(int i=1; i<t.Stations.size(); i++){	
			%><input type="radio" name="BETWEEN" value=<%=i%> /> <% 
			out.println("=> ["+t.Stations.get(i)+"]" + (i + 1 == t.Stations.size() ? "" : " ="));
	    }
		out.println(" DESTINATION");
		%>
	    

	
	
	<br></br>
	<input type="submit" name="AddStation" value="Add Stop" />
	
</form>
<br></br>
<br></br>
	<input type="submit" name="action" value="Finished Adding Stops">
	<br></br>
	<input type="submit" name="action" value="Cancel new transit line">
<form>


</form>
</body>
</html>