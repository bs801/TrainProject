<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
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
    	CSNTLPipeline ntlp = new CSNTLPipeline();
    	ntlp.val = 20;
    	
    	session.setAttribute("key",ntlp);
    	ntlp.val = 30;
    	CSNTLPipeline ntlp2 = (CSNTLPipeline) session.getAttribute("key");
    	out.println(ntlp2.val);
    //	out.println(request.getParameter("command"));
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

