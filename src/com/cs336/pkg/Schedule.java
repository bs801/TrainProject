package com.cs336.pkg;
import java.sql.Timestamp;

public class Schedule {
	public String transitLineName;
	public boolean reverseLine;
	public Timestamp scheduleDepartureTime;
	public int trainID;
	public Schedule(String transitLineName, boolean reverseLine, Timestamp scheduleDepartureTime, int trainID) {
		this.transitLineName = transitLineName; this.reverseLine = reverseLine; this.scheduleDepartureTime = scheduleDepartureTime; this.trainID = trainID;
	}
}
