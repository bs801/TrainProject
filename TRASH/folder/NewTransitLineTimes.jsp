<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	ArrayList<Station> interStations = new ArrayList<Station>();
	ArrayList<Station> stations = (ArrayList<Station>) session.getAttribute("NTL1");
	Station orig_station = (Station) session.getAttribute("NLB_ORIG");
	Station dest_station = (Station) session.getAttribute("NLB_DEST");
	ArrayList<String> errors = new ArrayList<String>();
	int iL=0;
	for(iL=1; iL < Integer.parseInt((String) session.getAttribute("interStops"))+1; iL++){
		String v = request.getParameter(""+iL+"");
		int s = Integer.parseInt(v);
		Station newStation = stations.get(s);
		if(interStations.contains(newStation) || newStation.equals(orig_station) || newStation.equals(dest_station)){
			errors.add("Station "+newStation+" was added twice");
			session.setAttribute("NLT_ERRORS", errors);
			response.sendRedirect("NewTransitLineBetween.jsp");
		}
		interStations.add(newStation);
	}
	session.setAttribute("interStations",interStations);
%>

<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	Enter in times in X:YZ format. System will automatically detect AM/PM changes assuming stops are at most 11:59 hours apart. 
	<br></br>
		<br></br>
			<br></br>
	STATION NAME: _ [ARRIVAL TIME] _ [DEPARTURE TIME] <br></br> 	<br></br>
	<%=""+orig_station+""%>: ORIGIN <%=session.getAttribute("CS2_STDSTR") %> <br></br>
	<form action="NewTransitLine4.jsp" method="POST">
		<%	for(int j=0; j<interStations.size(); j++) { %>
			<%=interStations.get(j)%>:
			<input type="text" name=<%="A"+j%> placeholder="5:04" />
			<input type="text" name=<%="D"+j%> placeholder="5:07" />
			<br></br>
		<% } %>
	<%=""+dest_station+""%>: <input type="text" name=<%="DD"%> placeholder="5:04" /> DESTINATION
	<input type="submit" value="Next" />
	</form>
	
</body>
</html>