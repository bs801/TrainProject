package com.cs336.pkg;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;

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
	public String toString() {
		try {
			return getTransitLine().toString() + " @ " + scheduleDepartureTime;
		} catch (SQLException e) {
			return "ERROR NULL";
		}
	}
	
	public TransitLine getTransitLine() throws SQLException {
		return TrainProject.TransitLines.get(transitLineName, reverseLine);
	}
	
	ArrayList<ScheduleStop> ScheduleStopTable;
	
	public ArrayList<ScheduleStop> getScheduleStops() throws SQLException{
		if(ScheduleStopTable != null) {
			return ScheduleStopTable;
		}
		ArrayList<TransitStop> transitStops = getTransitLine().getTransitStops();
		ArrayList<ScheduleStop> scheduleStops = new ArrayList<ScheduleStop>();
		for(TransitStop t : transitStops) {
			scheduleStops.add(new ScheduleStop(this, t, t.stopID, t.stationID));
		}
		return scheduleStops;
	}
	
	public ScheduleStop getScheduleStop(TransitStop t) throws SQLException {
		for(ScheduleStop st : getScheduleStops()) {
			if(t.stationID == st.stationID) {
				return st;
			}
		}
		return null;
	}
	public ScheduleStop scheduleStopForStation(Station s) throws SQLException {
		for(ScheduleStop st : getScheduleStops()) {
			if(st.stationID == s.stationID) {
				return st;
			}
		}
		return null;
	}
	
	public LocalDateTime dateTimeOfArrival(TransitStop t) throws SQLException {
		return getScheduleStop(t).arrivalTime;
	}
	public LocalDateTime dateTimeOfDeparture(TransitStop t) throws SQLException {
		return getScheduleStop(t).departureTime;
	}
	public LocalDateTime dateTimeOfArrival(Station s) throws SQLException {
		return scheduleStopForStation(s).arrivalTime;
	}
	public LocalDateTime dateTimeOfDeparture(Station s) throws SQLException {
		return scheduleStopForStation(s).departureTime;
	}
	
	
	
	// Say you have a schedule that does F -> D -> A -> H -> J -> B -> K -> L 
	// This method will return arraylist { A H J B } or NULL
	public ArrayList<Station> getCoverage(Station A, Station B) throws SQLException{ 
		ScheduleStop s1 = scheduleStopForStation(A);
		ScheduleStop s2 = scheduleStopForStation(B);
		System.out.println("s1: "+s1);
		System.out.println("s2: "+s2);
		if(s1 == null || s2 == null) {
			return null;
		}
		if(!(s1.stopID < s2.stopID)) {
			return null;
		}
		ArrayList<ScheduleStop> scheduleStop = getScheduleStops();
		ArrayList<Station> stations = new ArrayList<Station>();
		int i;
		for(i=0; i<scheduleStop.size(); i++) {
			if(scheduleStop.get(i).stationID == s1.stationID) {
				break;
			}
		}
		for(i=i; i<scheduleStop.size(); i++) {
			stations.add(TrainProject.Stations.get(scheduleStop.get(i).stationID));
			if(scheduleStop.get(i).stationID == s2.stationID) {
				break;
			}
		}
		System.out.println("FOUND A SCHEDULE ");
		return stations;
	}

	// Returns all the schedules that can take you from A to B. 
	public static ArrayList<Schedule> getCoveringSchedules(Station A, Station B) throws SQLException {
		HashMap<String, Schedule[]> transitLineTypes = new HashMap<String, Schedule[]>();
		ArrayList<Schedule> schedules = TrainProject.Schedules.getAsList();
		ArrayList<Schedule> covering = new ArrayList<Schedule>();
		for(Schedule s : schedules) {
			if(transitLineTypes.get(s.transitLineName) != null) {
				if(transitLineTypes.get(s.transitLineName)[s.reverseLine] != null) {
					schedules.add(s);
				}	
				continue;
			}
			if(s.getCoverage(A, B) != null) {
				transitLineTypes.put(s.transitLineName, new Schedule[2]);
				transitLineTypes.get(s.transitLineName)[s.reverseLine] = s;
				schedules.add(s);
			}
		}
		return covering;
	}
	
	
	
	/*
	LocalDateTime dateTimeOfArrival(TransitStop t) {
		
	}*/
	/*
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
	*/
	
	//public static boolean conflict(LocalDateTime A1, LocalDateTime A2, LocalDateTime B1, LocalDateTime B2) {
		
	//}
}
