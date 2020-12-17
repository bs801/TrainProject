package com.cs336.pkg;

public class TrainActivityPacket {
	public String transitLineName;
	public int tally = 0;
	public int forward = 0;
	public int returnT = 0;
	
	public int resTally = 0;
	public int revenue = 0;
	
	public TrainActivityPacket(String transitLineName) {
		this.transitLineName = transitLineName;
	}
	public void tapForward(float f) {
		revenue += f;
		tally++;
		forward++;
	}
	public void tapResTally() {
		this.resTally++;
	}
	public void tapReturn(float f) {
		revenue += f;
		tally++;
		returnT++;
	}
	
	public float getRevenue() {
		return tally;
	}
}