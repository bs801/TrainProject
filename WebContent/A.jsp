<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
    
<%
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

if(1 == 1){
	return;
}
%> 


    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>


</head>
<body>




<h1> Drop down box or select element</h1>
    <form action="B.jsp" method="POST">
    <%  
   // ApplicationDB db = new ApplicationDB();	
	//Connection con = db.getConnection();
    //Class.forName("com.mysql.jdbc.Driver");
    
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from users");

    //Hello
    
    int i = 0;
    while(rs.next()){ %>
  	    <input type="radio" name="command" value=<%=i++%> /> <%=rs.getString(1)%>
  	    <br></br> 
    <% } %>
     <input type="submit" value="Submit"/>
    </form>


<form action="B.jsp" method="POST">

ASDF <input type="text" name="FieldA"/> <br/>

<input type="submit" value="Submit"/>
</form>

</body>
</html>