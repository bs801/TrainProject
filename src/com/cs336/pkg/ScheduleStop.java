package com.cs336.pkg;

import java.sql.SQLException;
import java.time.LocalDateTime;

public class ScheduleStop {
	
	public int stopID;
	public int stationID;
	public LocalDateTime arrivalTime;
	public LocalDateTime departureTime;

	public ScheduleStop(Schedule schedule, TransitStop t, int stopID, int stationID) {
	
		this.arrivalTime = schedule.scheduleDepartureTime.toLocalDateTime().plusHours(t.arrivalTime.toLocalTime().getHour()).plusMinutes(t.arrivalTime.toLocalTime().getMinute());
		this.departureTime = schedule.scheduleDepartureTime.toLocalDateTime().plusHours(t.departureTime.toLocalTime().getHour()).plusMinutes(t.departureTime.toLocalTime().getMinute());
		this.stopID = stopID;
		this.stationID = stationID;
	}
	
	@Override
	public String toString() {
		try {
			return TrainProject.Stations.get(this.stationID).toString();
		} catch (SQLException e) {
			return null;
		}
	}
	public Station getStation() throws SQLException {
		return TrainProject.Stations.get(this.stationID);
	}
}
