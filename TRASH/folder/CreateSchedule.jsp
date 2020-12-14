<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="CreateSchedule2.jsp" method="GET">
	Date
	<select name="month">
	    <option selected value="0">--Month--</option>
	    <option value="1">January</option>
	    <option value="2">February</option>
	    <option value="3">March</option>
	    <option value="4">April</option>
	    <option value="5">May</option>
	    <option value="6">June</option>
	    <option value="7">July</option>
	    <option value="8">August</option>
	    <option value="9">September</option>
	    <option value="10">October</option>
	    <option value="11">November</option>
	    <option value="12">December</option>
	</select> 
	<input type="text" name="day" placeholder="dd">
	<input type="text" name="year" placeholder="yyyy">
	
	<br></br>
	Departure Time
	<select name="hour">
		<% for(int i=1; i <= 12; i++){ %>
		
		<option value=<%=i%>><%=i%></option>
		
		<% } %>
	</select>:
	<select name="minute">
		<% for(int i=0; i <= 59; i++){ %>
		<option value=<%=i%>><%=(i < 10 ? "0" : "")+""+i%></option>
		<% } %>
	</select>
	<select name="xm">
		<option value="am">AM</option>
		<option value="pm">PM</option>
	</select>
	<br></br>

	Train
	<select name="trainID">
	<option selected value="-1">--Select Train--</option>
	<% 
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Class.forName("com.mysql.jdbc.Driver");
	
	Statement stTr = con.createStatement();
    ResultSet rsTr = stTr.executeQuery("select * from Train");
	
    
	while(rsTr.next()){ %>
		<option value=<%=rsTr.getInt(1)%>><%="Train "+rsTr.getInt(1)%></option>
	<% } %>
	</select>
	<br></br>
	
	<%

    Class.forName("com.mysql.jdbc.Driver");
    
    Statement stTL = con.createStatement();
    ResultSet rsTL = stTL.executeQuery("select * from TransitLine");
    Statement stTS = con.createStatement();
    ResultSet rsTS = stTS.executeQuery("select * from TransitStop");
    Statement stStation = con.createStatement();
    ResultSet rsStation = stStation.executeQuery("select * from Station");
    
   	HashMap<Integer, String> StationQuery = new HashMap<Integer, String>();
   	while(rsStation.next()){
   		StationQuery.put(rsStation.getInt("stationID"), rsStation.getString("name"));
   	}
    
    HashMap<String, HashMap<Integer, String>> TransitStopQuery = new HashMap<String, HashMap<Integer, String>>();
    while(rsTS.next()){
    	String tln = rsTS.getString("transitLineName");
    	if(TransitStopQuery.get(tln) == null){
    		TransitStopQuery.put(tln, new HashMap<Integer, String>());
    	}
    	//out.println(rsTS.getString(4));
    	System.out.println("ADDIGN "+StationQuery.get(rsTS.getInt("stationID")));
    	TransitStopQuery.get(tln).put(rsTS.getInt("stopID"), StationQuery.get(rsTS.getInt("stationID")));
    }
    
    ArrayList<String> TransitLineNames = new ArrayList<String>(TransitStopQuery.keySet());
    Collections.sort(TransitLineNames);
    
    HashMap<String, Integer> TransitLineSizes = new HashMap<String, Integer>();
    while(rsTL.next()){
    	TransitLineSizes.put(rsTL.getString("transitLineName"), rsTL.getInt("numberOfStops"));
    }
   	
    ArrayList<String> Values = new ArrayList<String>();
    ArrayList<String> Options = new ArrayList<String>();
    System.out.println(TransitLineNames);
    for(int i=0; i<TransitLineNames.size() * 2; i++){
    	int j = i/2;
    	String tln = TransitLineNames.get(j);
    	int size = TransitLineSizes.get(tln);
    	String dest = TransitStopQuery.get(tln).get(size-1);
    	if(i % 2 == 0){
    		Options.add("F"+TransitLineNames.get(j));
    		Values.add(TransitLineNames.get(j) + ": "+TransitStopQuery.get(tln).get(0) +  " -> " + dest);
    	} else {
    		Options.add("R"+TransitLineNames.get(j));
    		Values.add(TransitLineNames.get(j) + ": "+ dest +  " -> " + TransitStopQuery.get(tln).get(0));
    	}
    }
    
    //ArrayList<TransitLine> TransitLines = new ArrayList<TransitLine>();
    //ArrayList<String> TransitStops = new ArrayList<String>();
    

    
    //while(rs.next()){
    //	TransitLine tl = new TransitLine(rs.getString(1));
    //	Statement st = con.createStatement();
    //    ResultSet rs = st.executeQuery("select * from TransitLine");
    //}
    
	%>
	
	Transit Line
	<select name="TLOption">
		<option value="NO_SELECTION">-------------------------</option>
		<option value="CREATE">CREATE NEW TRANSIT LINE</option>
		<option value="NO_SELECTION">-------------------------</option>
		<% for(int i=0; i<TransitLineNames.size() * 2; i++){ %>
		<option value=<%=Options.get(i)%>><%=Values.get(i)%></option>
		<% } %>
	</select>
	<br></br>
	<input type="submit" value="Continue"/> 
</form>
</body>
</html>