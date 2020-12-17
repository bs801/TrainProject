<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%

	float f = 3.25f;
	int r = (int) f;
	String floatversion = f+"";
	//System.out.println(floatversion);
	String intversion = r+"";
//	System.out.println("FLOAT STUFF"+floatversion.substring(intversion.length(), intversion.length()+3));
	intversion += floatversion.substring(intversion.length(), intversion.length()+2);
	//System.out.println("intv at this stage "+intversion);
	
	try{
		String ap = floatversion.substring(intversion.length(), intversion.length()+1);
		intversion += ap;
	} catch(Exception e){
		intversion += "0";
	}

	System.out.println("$"+intversion);


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