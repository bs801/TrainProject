package com.cs336.pkg;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Reservation {
	
	public int reservationID;
	public int roundTrip;
	public Float totalFare;
	
	public String transitLineName;
	public int reverseLine;
	public Timestamp scheduleDepartureTime;
	
	public int origin_stopID;
	public int destination_stopID;
	
	
	public LocalDate dateOfCreation;
	
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
