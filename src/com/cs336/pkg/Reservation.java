package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Reservation {
	
	public int reservationID;
	public int roundTrip;
	public float totalFare;
	
	public String transitLineName;
	public int reverseLine;
	public Timestamp scheduleDepartureTime;
	
	public int origin_stopID;
	public int destination_stopID;
	
	
	public Timestamp dateOfCreation;
	
	public Reservation(int reservationID, int roundTrip, float totalFare, String transitLineName,
			int reverseLine, Timestamp scheduleDepartureTime, int origin_stopID, 
			int destination_stopID, Timestamp dateOfCreation
			
			) {
		this.reservationID = reservationID; this.roundTrip = roundTrip; this.totalFare = totalFare; this.transitLineName = transitLineName;
		this.reverseLine = reverseLine; this.scheduleDepartureTime = scheduleDepartureTime; this.origin_stopID = origin_stopID;
		this.destination_stopID = destination_stopID; this.dateOfCreation = dateOfCreation;
	}
	
	public Reservation(ResultSet rs) throws SQLException {
		this(rs.getInt("reservationID"), rs.getInt("roundTrip"), rs.getFloat("totalFare"), rs.getString("transitLineName"),
		rs.getInt("reverseLine"), rs.getTimestamp("scheduleDepartureTime"), rs.getInt("origin_stopID"), 
		rs.getInt("destination_stopID"), rs.getTimestamp("dateOfCreation"));
	}
	public Schedule getSchedule() throws SQLException {
		return TrainProject.Schedules.get(transitLineName, reverseLine, scheduleDepartureTime);
	}
	public TransitStop getOriginStop() throws SQLException {
		return TrainProject.TransitStops.get(transitLineName, reverseLine, origin_stopID);
	}
	public TransitStop getDestinationStop() throws SQLException {
		return TrainProject.TransitStops.get(transitLineName, reverseLine, destination_stopID);
	}
	public LocalDateTime timeOfDeparture() throws SQLException {
		return getSchedule().dateTimeOfDeparture(getOriginStop());
	}
	public LocalDateTime timeOfArrival() throws SQLException {
		return getSchedule().dateTimeOfArrival(getDestinationStop());
	}
	
	
	
}
