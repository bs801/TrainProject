package com.cs336.pkg;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

public class TransitLine implements Comparable<TransitLine>{
	public String transitLineName;
	public int reverseLine;
	public Float fare;
	public int numberOfStops;
	public Time duration;
	//public ArrayList<TransitStop> TransitStops = new ArrayList<TransitStop>();
	
	public TransitLine(String transitLineName, int reverseLine, Float fare, int numberOfStops, Time duration) {
		this.transitLineName = transitLineName; this.reverseLine = reverseLine; this.fare = fare; this.numberOfStops = numberOfStops; this.duration = duration;
	}
	public TransitLine(ResultSet rs) throws SQLException {
		this(rs.getString("transitLineName"), rs.getInt("reverseLine"), rs.getFloat("fare"), rs.getInt("numberOfStops"), rs.getTime("duration"));
	}
	
	public static TransitLine getKey(String transitLineName, int reverseLine) {
		System.out.println("INPUTTIGN TL "+transitLineName);
		return new TransitLine(transitLineName, reverseLine, 0f, 0, null);
	}
	public static TransitLine getKey(ResultSet weakRS) throws SQLException {
		return getKey(weakRS.getString("transitLineName"), weakRS.getInt("reverseLine"));
	}
	
	public ArrayList<TransitStop> getTransitStops() throws SQLException{
		ArrayList<TransitStop> transitStops = new ArrayList<TransitStop>(TrainProject.TransitStops.getAll().get(this).values());
		Collections.sort(transitStops);
		return transitStops;
	}
	
	public TransitStop getStop(int stopID) throws SQLException {
		 return TrainProject.TransitStops.get(this, stopID);
	}
	
	public ArrayList<Schedule> getSchedules() throws SQLException{
		ArrayList<Schedule> schedules = TrainProject.Schedules.getAsList();
		ArrayList<Schedule> tls = new ArrayList<Schedule>();
		for(Schedule sc : schedules) {
			if(sc.transitLineName.equals(this.transitLineName) && sc.reverseLine == this.reverseLine) {
				tls.add(sc);
			}
		}
		return tls;
	}
	
	@Override
	public String toString() {
	//	System.out.println("toString");
		try {
			return transitLineName + ": "+TrainProject.TransitStops.get(this, 0).toString() + " -> " + TrainProject.TransitStops.get(this, numberOfStops-1).toString();
		} catch (SQLException e) {
			return "ERROR!!! THIS IS BAD!!! NULL";
		}
	}
	
	@Override
	public int compareTo(TransitLine tl) {
		if(this.transitLineName.compareTo(tl.transitLineName) != 0) {
			return this.transitLineName.compareTo(tl.transitLineName);
		}
		if(this.reverseLine < tl.reverseLine) {
			return -1;
		} else {
			return 1;
		}
	}
	
	@Override
	public boolean equals(Object o) { 
		//System.out.println("COMPARIGN "+o+" TO "+this);
		if(o == this) {
			return true;
		}
		if(!(o instanceof TransitLine)) {
			return false;
		}
		TransitLine tl = (TransitLine) o;
		//System.out.println("COMPARING "+this.transitLineName+" to "+  tl.transitLineName);
		//System.out.println("AND "+this.reverseLine+" to "+  tl.reverseLine);
		//System.out.println("IS IT EQUALS? VAL="+(this.transitLineName == tl.transitLineName && this.reverseLine == tl.reverseLine));
		return this.transitLineName.equals(tl.transitLineName) && this.reverseLine == tl.reverseLine;
	}
	
	
	@Override
	public int hashCode() {
		//System.out.println("BEING CALLED "+( transitLineName.hashCode() + reverseLine));
		return transitLineName.hashCode() + reverseLine;
	}
	

	
	/* public String primaryKeySet() {
		String u = "("+Stations.get(0).stationID;
		for(int i=1; i<Stations.size(); i++) {
			u += ", "+Stations.get(i).stationID;
		}
		u += ")";
		return u;
	} */
}
