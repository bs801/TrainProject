package com.cs336.pkg;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;

public class Schedule {
	public String transitLineName;
	public int reverseLine;
	public Timestamp scheduleDepartureTime;
	public int trainID;
	
	public Schedule(String transitLineName, int reverseLine, Timestamp scheduleDepartureTime, int trainID) {
		this.transitLineName = transitLineName; this.reverseLine = reverseLine; this.scheduleDepartureTime = scheduleDepartureTime; this.trainID = trainID;
	}
	public Schedule(ResultSet rs) throws SQLException {
		this(rs.getString(1), rs.getInt("reverseLine"), rs.getTimestamp(3), rs.getInt(4));
	}
	
	public TransitLine getTransitLine() throws SQLException {
		return TrainProject.TransitLines.get(transitLineName, reverseLine);
	}
	
	
	public String toString() {
		try {
			return getTransitLine().toString() + " at " + scheduleDepartureTime;
		} catch (SQLException e) {
			return "ERROR NULL";
		}
	}
	
	LocalDateTime datetimeOfArrival(ArrayList<TransitStop> transitStops, int stopIndex){
		if(0 == reverseLine) {
			LocalTime relativeAT = transitStops.get(stopIndex).arrivalTime.toLocalTime();
			return scheduleDepartureTime.toLocalDateTime().plusHours(relativeAT.getHour()).plusMinutes(relativeAT.getMinute());
		} else {
			LocalTime relativeDT = transitStops.get(stopIndex).departureTime.toLocalTime(); 
			LocalTime lastStopArrival = transitStops.get(transitStops.size() - 1).arrivalTime.toLocalTime();
			return (scheduleDepartureTime.toLocalDateTime().plusHours(lastStopArrival.getHour()).plusMinutes(lastStopArrival.getMinute())).minusHours(relativeDT.getHour()).minusMinutes(relativeDT.getMinute());
		}
	}
	LocalDateTime datetimeOfDeparture(ArrayList<TransitStop> transitStops, int stopIndex){
		if(0 == reverseLine) {
			LocalTime relativeDT = transitStops.get(stopIndex).departureTime.toLocalTime();
			return scheduleDepartureTime.toLocalDateTime().plusHours(relativeDT.getHour()).plusMinutes(relativeDT.getMinute());
		} else {
			LocalTime relativeAT = transitStops.get(stopIndex).arrivalTime.toLocalTime(); 
			LocalTime lastStopArrival = transitStops.get(transitStops.size() - 1).arrivalTime.toLocalTime();
			return (scheduleDepartureTime.toLocalDateTime().plusHours(lastStopArrival.getHour()).plusMinutes(lastStopArrival.getMinute())).minusHours(relativeAT.getHour()).minusMinutes(relativeAT.getMinute());
		}
	}
	
	
	//public static boolean conflict(LocalDateTime A1, LocalDateTime A2, LocalDateTime B1, LocalDateTime B2) {
		
	//}
}
