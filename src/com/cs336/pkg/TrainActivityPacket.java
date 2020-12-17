package com.cs336.pkg;

public class TrainActivityPacket {
	public String transitLineName;
	public int tally = 0;
	public int forward = 0;
	public int returnT = 0;
	
	public int resTally = 0;
	
	public TrainActivityPacket(String transitLineName) {
		this.transitLineName = transitLineName;
	}
	public void tapForward() {
		tally++;
		forward++;
	}
	public void tapResTally() {
		this.resTally++;
	}
	public void tapReturn() {
		tally++;
		returnT++;
	}
	
	public float getRevenue() {
		return tally;
	}
}