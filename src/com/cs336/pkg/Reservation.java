package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Reservation {
	
	public int reservationID;
	public int cancelled;
	public String username;
	
	
	public String forward_transitLineName;
	public int forward_reverseLine;
	public Timestamp forward_scheduleDepartureTime;
	public int forward_trainID;
	public float forward_fare;

	public int roundTrip;
	
	public String return_transitLineName;
	public int return_reverseLine;
	public Timestamp return_scheduleDepartureTime;
	public int return_trainID;
	public float return_fare;
	
	public int origin_stationID;
	public int destination_stationID;
	
	//ArrayList<Reservation> res = TrainProject.Reservations.getAsList();
	
	public Timestamp dateOfCreation;
	public float discount;
	public float totalFare;
	
	public String title;
	public String firstName;
	public String lastName;
	
	public Reservation(
			int reservationID,
			int cancelled,
			String username,
				
			String forward_transitLineName,
			int forward_reverseLine,
			Timestamp forward_scheduleDepartureTime,
			int forward_trainID,
			float forward_fare,

			int roundTrip,
			
			String return_transitLineName,
			int return_reverseLine,
			Timestamp return_scheduleDepartureTime,
			int return_trainID,
			float return_fare,
			
			int origin_stationID,
			int destination_stationID,
			
			Timestamp dateOfCreation,
			float discount,
			float totalFare,
			
			String title,
			String firstName,
			String lastName
			) {
		this.reservationID = reservationID;
		this.cancelled = cancelled;
		this.username = username;
		
		this.forward_transitLineName = forward_transitLineName;
		this.forward_reverseLine = forward_reverseLine;
		this.forward_scheduleDepartureTime = forward_scheduleDepartureTime;
		this.forward_trainID = forward_trainID;
		this.forward_fare = forward_fare;
		
		this.roundTrip = roundTrip;

		this.return_transitLineName = return_transitLineName;
		this.return_reverseLine = return_reverseLine;
		this.return_scheduleDepartureTime = return_scheduleDepartureTime;
		this.return_trainID = return_trainID;
		this.return_fare = return_fare;
		
		this.origin_stationID = origin_stationID;
		this.destination_stationID = destination_stationID;
		this.dateOfCreation = dateOfCreation;
		this.discount = discount;
		this.totalFare = totalFare;	
		
		this.title = title;
		this.firstName = firstName;
		this.lastName = lastName;
		
		/*
		LocalDate.of(0,0,0).isAfter(other);
		LocalDate.of(0,0,31).isAfter(other);
		dateOfCreation.toLocalDateTime().toLocalDate().isAfter(LocalDate.of(0,0,31).isAfter(other))
		*/
	}
	
	public Reservation(ResultSet rs) throws SQLException {
		this(
			rs.getInt("reservationID"),
			rs.getInt("cancelled"),
			rs.getString("username"),
			
			rs.getString("forward_transitLineName"),
			rs.getInt("forward_reverseLine"),
			rs.getTimestamp("forward_scheduleDepartureTime"),
			rs.getInt("forward_trainID"),
			rs.getFloat("forward_fare"),
			
			rs.getInt("roundTrip"),
			
			rs.getString("return_transitLineName"),
			rs.getInt("return_reverseLine"),
			rs.getTimestamp("return_scheduleDepartureTime"),
			rs.getInt("return_trainID"),
			rs.getFloat("return_fare"),
			
			rs.getInt("origin_stationID"),
			rs.getInt("destination_stationID"),
			
			rs.getTimestamp("dateOfCreation"),
			rs.getFloat("discount"),
			rs.getFloat("totalFare"),
			
			rs.getString("title"),
			rs.getString("firstName"),
			rs.getString("lastName")
		);
		
		
	}
	public Schedule getForwardSchedule() throws SQLException {
		if(TrainProject.Schedules.get(forward_transitLineName, forward_reverseLine, forward_scheduleDepartureTime) == null) {
			return new Schedule(forward_transitLineName, forward_reverseLine, forward_scheduleDepartureTime, forward_trainID);
		}
		return TrainProject.Schedules.get(forward_transitLineName, forward_reverseLine, forward_scheduleDepartureTime);
	}
	public Schedule getReturnSchedule() throws SQLException {
		if(TrainProject.Schedules.get(return_transitLineName, return_reverseLine, return_scheduleDepartureTime) == null) {
			return new Schedule(forward_transitLineName, return_reverseLine, return_scheduleDepartureTime, return_trainID);
		}
		return TrainProject.Schedules.get(return_transitLineName, return_reverseLine, return_scheduleDepartureTime);
	}
	public Station getOriginStation() throws SQLException {
		return TrainProject.Stations.get(origin_stationID);
	}
	public Station getDestinationStation() throws SQLException {
		return TrainProject.Stations.get(destination_stationID);
	}
	public LocalDateTime timeOfForwardDeparture() throws SQLException {
		return getForwardSchedule().dateTimeOfDeparture(getOriginStation());
	}
	public LocalDateTime timeOfForwardArrival() throws SQLException {
		return getForwardSchedule().dateTimeOfArrival(getDestinationStation());
	}
	public LocalDateTime timeOfReturnDeparture() throws SQLException {
		return getReturnSchedule().dateTimeOfDeparture(getDestinationStation());
	}
	public LocalDateTime timeOfReturnArrival() throws SQLException {
		return getReturnSchedule().dateTimeOfArrival(getOriginStation());
	}
	
	public void updateTrain(Schedule s, Schedule ns) throws SQLException {
		Schedule fsc = getForwardSchedule();
		if(s.transitLineName.equals(fsc.transitLineName) && s.reverseLine == fsc.reverseLine && s.scheduleDepartureTime.toLocalDateTime().isEqual(fsc.scheduleDepartureTime.toLocalDateTime()) && s.trainID == fsc.trainID) {
			this.forward_trainID = ns.trainID;
		}
		if(roundTrip == 1) {
		Schedule rsc = getReturnSchedule();
		if(s.transitLineName.equals(rsc.transitLineName) && s.reverseLine == rsc.reverseLine && s.scheduleDepartureTime.toLocalDateTime().isEqual(rsc.scheduleDepartureTime.toLocalDateTime()) && s.trainID == rsc.trainID) {
			this.return_trainID = ns.trainID;
		}
		}
	}
	
	private String getString() throws SQLException {
		
		String l1 = forward_transitLineName+": "+getOriginStation()+" "+Formatting.displayTime(timeOfForwardDeparture())+" --> "+getDestinationStation()+" "+Formatting.displayTime(timeOfForwardArrival())+"  (Train "+Formatting.getTrainID(forward_trainID)+")";
		if(roundTrip == 1) {
			String l2 = return_transitLineName+": "+getDestinationStation()+" "+Formatting.displayTime(timeOfReturnDeparture())+" --> "+getOriginStation()+" "+Formatting.displayTime(timeOfReturnArrival())+"  (Train "+Formatting.getTrainID(return_trainID)+")";
			l1 = l1+"<br></br>"+l2;
		}
		l1 = l1;// + "<br></br>";
		l1 = "<h3>"+l1+"</h3>";
		
		String bn = "Booked on "+Formatting.displayTime(dateOfCreation.toLocalDateTime().toLocalDate()) + ".  Customer username: "+username+".  Reservation ID: "+reservationID+".<br></br>";
		String p1 = "Passenger "+ ((title == null || "".equals(title)) ? "" : title ) + " " + firstName +" "+ lastName;
		p1 = p1 + "<br></br>";
		
		
	
		String tf = "Total fare: "+Formatting.getFare(totalFare) + "<br></br>";
		String ad = "Applied discount: "+Formatting.getDiscount(discount) + "<br></br>";
		
		return l1 + p1 + bn + ad + tf;
		
	}
	
	@Override
	public String toString() {
		try {
			System.out.println("CALLING TO STRIGN");
			return getString();
		
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			return "ERROR";
		}
	}
}
