package com.cs336.pkg;
import java.time.*;
import java.sql.*;

public class TransitStop implements Comparable<TransitStop> {
	String transitLineName;
	int reverseLine;
	int stopID;
	int stationID;
	Time arrivalTime;
	Time departureTime;
	
	public TransitStop(String transitLineName, int reverseLine, int stopID, int stationID, Time arrivalTime, Time departureTime) {
		this.transitLineName = transitLineName; this.reverseLine = reverseLine; this.stopID = stopID; this.stationID = stationID; this.arrivalTime = arrivalTime; this.departureTime = departureTime;
	}
	public TransitStop(ResultSet rs) throws SQLException {
		this(rs.getString("transitLineName"), rs.getInt("reverseLine"), rs.getInt("stopID"), rs.getInt("stationID"), rs.getTime("arrivalTime"), rs.getTime("departureTime"));
	}
	
	public TransitLine getTransitLine() throws SQLException {
		return TrainProject.TransitLines.get(transitLineName, reverseLine);
	}
	
	
	@Override
	public String toString() {
		try {
			return TrainProject.Stations.get(this.stationID).toString();
		} catch (SQLException e) {
			return null;
		}
	}
	
	@Override
	public int compareTo(TransitStop t) {
		if(this.stopID < t.stopID) {
			return -1;
		} else if(this.stopID > t.stopID) {
			return 1;
		}
		return 0;
	}
	
}
