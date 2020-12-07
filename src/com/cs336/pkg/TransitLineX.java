package com.cs336.pkg;

import java.util.ArrayList;

public class TransitLineX {
	Float Fare;
	public String transitLineName;
	public ArrayList<Station> Stations;
	
	public TransitLineX(Station orig, Station dest, Float Fare) {
		Stations = new ArrayList<Station>();
		Stations.add(orig);
		Stations.add(dest);
		this.Fare = Fare;
	}
	public TransitLineX(String transitLineName) {
		Stations = new ArrayList<Station>();
		this.transitLineName = transitLineName;
	}
	public String primaryKeySet() {
		String u = "("+Stations.get(0).stationID;
		for(int i=1; i<Stations.size(); i++) {
			u += ", "+Stations.get(i).stationID;
		}
		u += ")";
		return u;
	}
}
