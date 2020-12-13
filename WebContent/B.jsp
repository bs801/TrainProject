<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.util.*"%>
    
<%
    	/*  /// I am editing some stuff qwerty
    /*  /// I am editing some stuff asdf

    	out.println(session.getAttribute("key1"));

    	if(session.getAttribute("asdf") != null){
    		out.println("true");
    	}
    	if(session.getAttribute("asdf") == null){
    		out.println("false");
    	}
    	*/
    	// comment jsp
    	/*
    	CSNTLPipeline ntlp = new CSNTLPipeline();
    	ntlp.val = 20;
    	
    	session.setAttribute("key",ntlp);
    	ntlp.val = 30;
    	CSNTLPipeline ntlp2 = (CSNTLPipeline) session.getAttribute("key");
    	out.println(ntlp2.val);
    	*/
    	//out.println(request.getParameter("command"));
    	
    	//String varname = (String) request.getParameter("command");
    	//int v = Integer.parseInt("command");
    	//TrainProject.Questions.get(v);
    	
    	Train t = new Train(3, "asdf");
    	ArrayList<Train> tl = new ArrayList<Train>();
    	tl.add(t);
    	Train a = new Train(4, "bsdf");
    	if(tl.contains(a)){
    		out.println("REEEE");
    	} else {
    		out.println("NO REEEE");
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>We are now on page B</title>
</head>
<body>

</body>
</html>

