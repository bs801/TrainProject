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

<form action="AdminLanding.jsp">
<input type="submit" value="BACK TO DASHBOARD"/>
</form>
<br></br>
<br></br>

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

		<br></br><input type = "submit" name="datesubmit" value = "Select Month/Year"/>
	<%
		System.out.println("56");
		ArrayList<TrainActivityPacket> taps = null;
		ArrayList<CustomerRevenuePacket> customerRevenues = null;
		if(MonthReport.validdate){
			
			out.println("<h1> Information for the month of "+Formatting.getMonth(MonthReport.MONTHSELECT)+" "+MonthReport.YEARSELECT+"</h1>");
			
			float sum = 0;
			int tally = 0;
			ArrayList<Reservation> docReservations = TrainProject.Reservations.getPurchaseForMonth(MonthReport.my);
			for(Reservation r : docReservations){
				sum += r.totalFare;
				tally++;
			}
			out.println("<h3> Total Revenue: </h3> "+Formatting.getFare(sum)+" over "+tally+" reservations <br></br>");
			//out.println("(Total Revenue is calculated based on reservation date of creation, one-way or round-trip total fare <br></br>");
			
			
			HashMap<String, CustomerRevenuePacket> customerMap = new HashMap<String, CustomerRevenuePacket>();
			for(Reservation r : docReservations){
				
				if(customerMap.get(r.username) == null){
					
					customerMap.put(r.username, new CustomerRevenuePacket(r.username, r.totalFare) );
				} else {
					customerMap.get(r.username).add(r.totalFare);
				}
			}
			customerRevenues = new ArrayList<CustomerRevenuePacket>(customerMap.values());
			Collections.sort(customerRevenues,
		            new Comparator<CustomerRevenuePacket>() {
		                public int compare(CustomerRevenuePacket c1, CustomerRevenuePacket c2)
		                {
		                    return (c1.getRevenue() > c2.getRevenue() ? -1 : 1);
		                }
		            }
			);
			if(customerRevenues.size() == 0){
				out.println("<h2> Best Customer </h2> No best customer for this month <br></br>");
			} else {
				for(int i=0; i<1; i++){
					if(customerRevenues.get(i) == null){
						break;
					}
					Customer c = TrainProject.Customers.get(customerRevenues.get(i).username);
					CustomerRevenuePacket crp = customerRevenues.get(i);
					System.out.println("HANDLING CUSTOEMR "+c.username);
					out.println("<h2> Best Customer </h2>"+c.firstName+" "+c.lastName+" (with username "+c.username +") has spent "+Formatting.getFare(crp.Revenue)+" through "+crp.tally+" reservations made in this month <br></br>");
				}
			}
			System.out.println("102");
			out.println("<h2> Most active transit lines </h2>");
		
			taps = TrainProject.Reservations.getTrainActivityPackets(MonthReport.my);
			for(int i=0; i<5; i++){
				if(i == taps.size()){
					break;
				}
				if(taps.get(i) == null){
					break;
				}
		//		if(taps.get(i).resTally == 0){
		//			break;
		//		}
				TrainActivityPacket tap = taps.get(i);
				out.println("<h3> Transit Line "+tap.transitLineName+"</h3> Total of "+tap.resTally+" reservations (forward or return, one-way or round-trip). <br></br>This is "+tap.tally+" trips when double counting round trip reservations with where both forward/retun trips are made for this route. <br></br>");
			}
			if(taps.size() == 0){
				out.println("No active transit lines for this month");
			}
		}
	
	
	System.out.println("THIS HALF");
	%>
	


	
		<br></br>
		<% if(MonthReport.validdate){ %>
	<h2> View revenue and reservation report for a specific customer or transit line</h2>
	
	

	<input type="radio" name="torc" value="0" <% out.println(MonthReport.c1); %> />Do not use 
	<br></br>
	
	<input type="radio" name="torc" value="1" <% out.println(MonthReport.c2); %> /> View For Customer
	<select name="customerindex">
		<% for(int i=0; i<MonthReport.COptions.size(); i++){ %>
				<option <%=(MonthReport.CUSTOMERSELECT == i ? "selected" : "") %> value=<%=""+i+""%>><%=MonthReport.COptions.get(i)%></option>
		<% } %>
	</select><br></br>
	
	<input type="radio" name="torc" value="2" <% out.println(MonthReport.c3); %> /> View For Transit Line 
	<select name="tlnindex">
		<% for(int i=0; i<MonthReport.TLOptions.size(); i++){ %>
				<option <%=(MonthReport.TLNSELECT == i ? "selected" : "") %> value=<%=""+i+""%>><%=MonthReport.TLOptions.get(i)%></option>
		<% } %>
	</select>
	
	<br></br>
	The revenue and reservation report shows both revenue and reservations over a month for either for a selected customer or transit line.
		<br></br>
		<input type="Submit" name="reportsubmit" value="View Report" />
	<br></br>
	<br></br>
	
	<% } %>
	<%
		System.out.println(MonthReport.validdate);
		System.out.println(MonthReport.TLNSELECT);
		System.out.println(MonthReport.CUSTOMERSELECT);
		if(MonthReport.validdate){
			if(MonthReport.TLNSELECT != 0){
				TrainActivityPacket tap = null;
				for(TrainActivityPacket itap : taps){
					if(itap.transitLineName.equals(MonthReport.TLOptions.get(MonthReport.TLNSELECT))){
						tap = itap;
						break;
					}
				}
				String fm = "<br></br>";
				out.println("<h2>Monthly report for Transit Line: "+tap.transitLineName+"</h2>"+fm);
				out.println("Revenue generated: "+Formatting.getFare(tap.revenue)+fm);
				out.println("Reservations booked: "+tap.resTally+fm);
				out.println("Double counting return trips on same transit line: "+tap.tally+fm);
			//	out.println("Trips booked: "+tap.tally+fm);
			//	out.println("Trainsit Line "+tap.transitLineName+" had "+tap.resTally+" reservations with a departure (forward or return, one-way or round-trip). This is "+tap.tally+" trips when double counting round trip reservations with where both forward/retun trips are made for this route. <br></br>");
				ArrayList<Reservation> res = TrainProject.Reservations.getReservations(MonthReport.my, MonthReport.TLOptions.get(MonthReport.TLNSELECT));
				int amt =0;
				for(Reservation r : res){
					amt++;
					out.println(r.toString() + "<br></br>");
				}
				if(amt == 0){
					out.println("No reservations for this transit line during this month");
				}
			}
			if(MonthReport.CUSTOMERSELECT != 0){
				
				CustomerRevenuePacket cap = null;
				for(CustomerRevenuePacket icap : customerRevenues){
					if(icap.username.equals(MonthReport.COptions.get(MonthReport.CUSTOMERSELECT))){
						cap = icap;
						break;
					}
				}
				String fm = "<br></br>";
				out.println("<h2>Monthly report for Customer: "+cap.username+"</h2>"+fm);
				out.println("Revenue generated: "+cap.Revenue+fm);
				out.println("Reservations booked: "+cap.tally+fm);
				
				ArrayList<Reservation> res = TrainProject.Reservations.getPurchaseForMonth(MonthReport.my);
				int amt = 0;
				for(Reservation r : res){
					if(r.username.equals(cap.username)){
						amt++;
						out.println(r.toString() + "<br></br>");
					}
				}
				if(amt == 0){
					out.println("No reservations for this customer during this month");
				}
			}
		}
	%>
	

</form>

<br></br>
<br></br>





</body>
</html>