<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
    
<%
/*
LocalTime j = LocalTime.now();
LocalTime k = LocalTime.of(j.getHour(), j.getMinute());

Time asdf = TrainProject.TransitLines.get("ASDF").duration;

HashMap<Timestamp, Schedule[]> stuff = TrainProject.Schedules.getAll().get("ASDF");

ArrayList<Schedule[]> stuffAL = new ArrayList<Schedule[]>();
for (Map.Entry<Timestamp, Schedule[]> entry : stuff.entrySet()) {
	stuffAL.add(entry.getValue());
}
Schedule ptr = stuffAL.get(0)[1];
Timestamp dep = ptr.scheduleDepartureTime;
LocalDateTime depLDT = dep.toLocalDateTime();
depLDT = depLDT.plusHours(asdf.getHours()).plusMinutes(asdf.getMinutes());


LocalTime J = LocalTime.of(3, 4);
LocalTime K = J.minusHours(10);

out.println(K+"   aaa     ");
//LocalTime ii = LocalTime.of(j.getHour(), j.getMinute());
//out.println(ii);

if(1 == 1){
	return;
}

ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Class.forName("com.mysql.jdbc.Driver");
Statement stmt = con.createStatement();
String sql = "UPDATE TransitLine SET duration = (?) WHERE transitLineName = 'ASDF'";


PreparedStatement ps = con.prepareStatement(sql);
LocalTime t = LocalTime.of(2, 25);
ps.setTime(1, Time.valueOf(t));
ps.executeUpdate();

Timestamp t1 = Timestamp.valueOf(LocalDateTime.now());
Timestamp t2 = Timestamp.valueOf(t1.toLocalDateTime().plusHours(t.getHour()).plusMinutes(t.getMinute()));

System.out.println(t2);

*/

%> 


    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>


</head>
<body>




<h1> Drop down box or select element</h1>
    <form action="editCustomerRepresentative2.jsp" method="POST">
    <%  
    /*ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Class.forName("com.mysql.jdbc.Driver");
    
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from users");*/
    
    ArrayList<Representative> representatives = TrainProject.Representatives.getAsList();

    //Hello
    
    int i = 0;
    for(Representative r : representatives){ %>
  	    <input type="radio" name="command" value=<%=i++%> /> <%=r.username%>
  	    <br></br> 
    <% } %>
     <input type="submit" name="D" value="Delete"/>
     <input type="submit" name="E" value="Edit"/>
    </form>
</body>
</html>