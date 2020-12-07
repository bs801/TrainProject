package com.cs336.pkg;

import java.util.ArrayList;
import java.sql.Time;

public class TransitLine {
	public Float fare;
	public Time duration;
	public int numberOfStops;
	public ArrayList<TransitStop> TransitStops = new ArrayList<TransitStop>();
	public String transitLineName;
	
	/*
	public TransitLine(Station orig, Station dest, Float Fare) {
		Stations = new ArrayList<Station>();
		
		this.Fare = Fare;
	}*/
//	public TransitLine(String transitLineName, Float fare, int numberOfStops, Time duration) {
//		this.transitLineName = transitLineName; this.fare = fare; this.numberOfStops 
//	}
	public TransitLine(String transitLineName) {
		this.transitLineName = transitLineName;
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
