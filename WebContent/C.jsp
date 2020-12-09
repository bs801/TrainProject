<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<%
	//out.println(TrainProject.Stations.get(3));
	//ApplicationDB db = new ApplicationDB();	
	//Connection con = db.getConnection();
	/*)
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from TransitLine");
	
	
	while(rs.next()){ 
		out.println(rs.getInt("stationID"));
	}*/

	/*
	TrainProject.TransitLines.getAll();
	TransitLine TL_Key = TransitLine.getKey("ASDF",0);
	ArrayList<TransitLine> jj = TrainProject.TransitLines.getAsList();
	HashMap<TransitLine, String> xx = new HashMap<TransitLine, String>();
	for(TransitLine j : jj){
		xx.put(j, "asdf");
	}
	System.out.println(TL_Key.hashCode() +"   "+ jj.get(0).hashCode() +"   " + jj.get(1).hashCode());
	if(TL_Key.hashCode() == jj.get(0).hashCode()){
		System.out.println("EQUALS -----------------HASH CODE-----------------------");
	} else {
		System.out.println("NE ---------------------HASH CODE----------------");
	}
	if(TL_Key.hashCode() == jj.get(0).hashCode() && TL_Key.equals(jj.get(0))){
		System.out.println("EQUALS -----------------------------------------");
	} else {
		System.out.println("NE ----------------------------------------------");
	}
	String v = xx.get(TL_Key);
	out.println(v);
	*/
	for(Schedule sc : TrainProject.Schedules.getAsList()){
		out.println(sc.trainID);
	}
	out.println(TrainProject.Schedules.getAsList());
	
	//HashMap<String, Integer> asdf = new HashMap<String, Integer>();
	//asdf.put("asdf",3);
	//ArrayList<Integer> alist = new ArrayList<Integer>(asdf.values());
	//asdf.put("qwer",4);
	//out.println(alist);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>