package com.cs336.pkg;

public class CustomerRevenuePacket {
	public String username;
	public float Revenue;
	public int tally = 0;
	public CustomerRevenuePacket(String u, float f) {
		this.Revenue = f;
		tally = 0;
		this.username = u;
	}
	public void add(float f) {
		this.Revenue += f;
		tally++;
	}
	public float getRevenue() {
		return Revenue;
	}
}
