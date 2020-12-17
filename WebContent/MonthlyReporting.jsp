<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<%
	
	MonthReport.update(request);
	

%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Select Month to View Metrics For:
<form action="MonthlyReporting.jsp" method="GET">

	
	<select name="month">
	    <option <%=(MonthReport.MONTHSELECT == 0 ? "selected" : "")%> value="0">--Month--</option>
	    <option <%=(MonthReport.MONTHSELECT == 1 ? "selected" : "")%> value="1">January</option>
	    <option <%=(MonthReport.MONTHSELECT == 2 ? "selected" : "")%> value="2">February</option>
	    <option <%=(MonthReport.MONTHSELECT == 3 ? "selected" : "")%> value="3">March</option>
	    <option <%=(MonthReport.MONTHSELECT == 4 ? "selected" : "")%> value="4">April</option>
	    <option <%=(MonthReport.MONTHSELECT == 5 ? "selected" : "")%> value="5">May</option>
	    <option <%=(MonthReport.MONTHSELECT == 6 ? "selected" : "")%> value="6">June</option>
	    <option <%=(MonthReport.MONTHSELECT == 7 ? "selected" : "")%> value="7">July</option>
	    <option <%=(MonthReport.MONTHSELECT == 8 ? "selected" : "")%> value="8">August</option>
	    <option <%=(MonthReport.MONTHSELECT == 9 ? "selected" : "")%> value="9">September</option>
	    <option <%=(MonthReport.MONTHSELECT == 10 ? "selected" : "")%> value="10">October</option>
	    <option <%=(MonthReport.MONTHSELECT == 11 ? "selected" : "")%> value="11">November</option>
	    <option <%=(MonthReport.MONTHSELECT == 12 ? "selected" : "")%> value="12">December</option>
	</select> 
	<% 
		if(MonthReport.validdate == false){
			%><input type="text" name="year" placeholder="yyyy"><%
		} else {
			%><input type="text" name="year" placeholder="yyyy" value=<%=MonthReport.YEARSELECT%>><%
		}
	%>

	
	<%
		ArrayList<TrainActivityPacket> taps = null;
		if(MonthReport.validdate){
			
			out.println("<h2> Information for the month of "+Formatting.getMonth(MonthReport.MONTHSELECT)+" "+MonthReport.YEARSELECT+"</h3>");
			
			float sum = 0;
			int tally = 0;
			ArrayList<Reservation> docReservations = TrainProject.Reservations.getPurchaseForMonth(MonthReport.my);
			for(Reservation r : docReservations){
				sum += r.totalFare;
				tally++;
			}
			out.println("Total Revenue: "+Formatting.getFare(sum)+" over "+tally+" reservations <br></br>");
			//out.println("(Total Revenue is calculated based on reservation date of creation, one-way or round-trip total fare <br></br>");
			
			
			HashMap<String, CustomerRevenuePacket> customerMap = new HashMap<String, CustomerRevenuePacket>();
			for(Reservation r : docReservations){
				
				if(customerMap.get(r.username) == null){
					
					customerMap.put(r.username, new CustomerRevenuePacket(r.username, r.totalFare) );
				} else {
					customerMap.get(r.username).add(r.totalFare);
				}
			}
			ArrayList<CustomerRevenuePacket> customerRevenues = new ArrayList<CustomerRevenuePacket>(customerMap.values());
			Collections.sort(customerRevenues,
		            new Comparator<CustomerRevenuePacket>() {
		                public int compare(CustomerRevenuePacket c1, CustomerRevenuePacket c2)
		                {
		                    return (c1.getRevenue() > c2.getRevenue() ? -1 : 1);
		                }
		            }
			);
			for(int i=0; i<1; i++){
				if(customerRevenues.get(i) == null){
					break;
				}
				Customer c = TrainProject.Customers.get(customerRevenues.get(i).username);
				CustomerRevenuePacket crp = customerRevenues.get(i);
				System.out.println("HANDLING CUSTOEMR "+c.username);
				out.println(c.firstName+" "+c.lastName+" with username "+c.username +" has spent "+Formatting.getFare(crp.Revenue)+" through "+crp.tally+" reservations made in this month <br></br>");
			}
			
			
			taps = TrainProject.Reservations.getTrainActivityPackets(MonthReport.my);
			for(int i=0; i<5; i++){
				if(taps.get(i) == null){
					break;
				}
				TrainActivityPacket tap = taps.get(i);
				out.println("Trainsit Line "+tap.transitLineName+" had "+tap.resTally+" reservations with a departure (forward or return, one-way or round-trip). This is "+tap.tally+" trips when double counting round trip reservations with where both forward/retun trips are made for this route. <br></br>");
			}
			
		}
	
	
	
	%>

	<input type = "submit" name="datesubmit" value = "Select Month/Year"/>

	
	
	<h3> View revenue and reservation report </h3>
	
	The revenue and reservation report shows both revenue and reservations over a month for either for a selected customer or transit line.
	
	<input type="radio" name="torc" value="0" <% out.println(MonthReport.c1); %> /> Do not use
	<br></br>
	
	<input type="radio" name="torc" value="1" <% out.println(MonthReport.c2); %> /> For Customer 
	<select name="customerindex">
		<% for(int i=0; i<MonthReport.COptions.size(); i++){ %>
				<option <%=(MonthReport.CUSTOMERSELECT == i ? "selected" : "") %> value=<%=""+i+""%>><%=MonthReport.COptions.get(i)%></option>
		<% } %>
	</select>
	
	<input type="radio" name="torc" value="2" <% out.println(MonthReport.c3); %> /> For Transit Line 
	<select name="tlnindex">
		<% for(int i=0; i<MonthReport.TLOptions.size(); i++){ %>
				<option <%=(MonthReport.TLNSELECT == i ? "selected" : "") %> value=<%=""+i+""%>><%=MonthReport.TLOptions.get(i)%></option>
		<% } %>
	</select>
	<br></br>
	<br></br>
	
	
	<%
	
		if(MonthReport.validdate){
			if(MonthReport.TLNSELECT != 0){
				TrainActivityPacket tap = null;
				for(TrainActivityPacket itap : taps){
					if(itap.transitLineName.equals(MonthReport.TLOptions.get(MonthReport.TLNSELECT))){
						tap = itap;
						break;
					}
				}
				out.println("Trainsit Line "+tap.transitLineName+" had "+tap.resTally+" reservations with a departure (forward or return, one-way or round-trip). This is "+tap.tally+" trips when double counting round trip reservations with where both forward/retun trips are made for this route. <br></br>");
				ArrayList<Reservation> res = TrainProject.Reservations.getReservations(MonthReport.my, MonthReport.TLOptions.get(MonthReport.TLNSELECT));
				for(Reservation r : res){
					out.println(r.toString() + "<br></br>");
				}
			}
			if(MonthReport.CUSTOMERSELECT != 0){
				
			}
		}
	
		
	%>
	
	<input type="Submit" name="reportsubmit" value="View Report" />
</form>

<br></br>
<br></br>
<form action="AdminLanding.jsp">
<input type="submit" value="Cancel"/>
</form>



</body>
</html>