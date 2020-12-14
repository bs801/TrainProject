package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Reservation {
	
	public int reservationID;


	
	
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
	
	
	public Timestamp dateOfCreation;
	public float discount;
	public float totalFare;
	
	public Reservation(
			int reservationID,

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
			float totalFare
			) {
		this.reservationID = reservationID;
		
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
	}
	
	public Reservation(ResultSet rs) throws SQLException {
		this(
			rs.getInt("reservationID"),
			
			rs.getString("foward_transitLineName"),
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
			rs.getFloat("totalFare")
		);
	}
	public Schedule getForwardSchedule() throws SQLException {
		return TrainProject.Schedules.get(forward_transitLineName, forward_reverseLine, forward_scheduleDepartureTime);
	}
	public Schedule getReturnSchedule() throws SQLException {
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
	
	
}
