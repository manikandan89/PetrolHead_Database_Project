package edu.neu.cs5200.inventory.jpa;

public class Details {

	private String make;
	private long styleId;
	public long getStyleId() {
		return styleId;
	}
	public void setStyleId(long styleId) {
		this.styleId = styleId;
	}
	public String getMake() {
		return make;
	}
	public void setMake(String make) {
		this.make = make;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public long getYear() {
		return year;
	}
	public void setYear(long year) {
		this.year = year;
	}
	private String model;
	private long year;
}
