<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	Schedule s = TrainProject.Schedules.getAsList().get(0);

	Station A = TrainProject.Stations.get(16);
	Station B = TrainProject.Stations.get(14);
	System.out.println("GOIGN FROM "+A+" TO "+B);
	out.println(s.getCoverage(A, B));
	out.println("done");
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