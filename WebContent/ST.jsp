<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%

	LocalDate my = LocalDate.of(2024, 2, 29);

	LocalDateTime x1 =  LocalDateTime.of(2024, 1, 31, 0, 0);
	LocalDateTime x2 =  LocalDateTime.of(2024, 2, 1, 0, 0);
	LocalDateTime x3 =  LocalDateTime.of(2024, 2, 29, 0, 0);
	LocalDateTime x4 =  LocalDateTime.of(2024, 3, 1, 0, 0);

	out.println(Formatting.sameMonth(my, x1));
	out.println(Formatting.sameMonth(my, x2));
	out.println(Formatting.sameMonth(my, x3));
	out.println(Formatting.sameMonth(my, x4));
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