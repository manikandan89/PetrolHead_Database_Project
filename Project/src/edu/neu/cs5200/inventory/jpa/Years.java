package edu.neu.cs5200.inventory.jpa;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.eclipse.persistence.annotations.CascadeOnDelete;

@Entity
public class Years implements Serializable {

	@Id
	private long year;
	
	@ManyToMany(mappedBy = "years")
	private List<Model> models;
	
	@OneToMany(mappedBy="year", cascade = CascadeType.ALL, orphanRemoval = true)
	@CascadeOnDelete
	private List<Car> cars;

	public long getYear() {
		return year;
	}

	public void setYear(long year) {
		this.year = year;
	}

	public List<Car> getCars() {
		return cars;
	}

	public void setCars(List<Car> cars) {
		this.cars = cars;
	}

	public Years() {
		super();
	}
	
	public List<Model> getModels() {
		return models;
	}

	public void setModels(List<Model> models) {
		this.models = models;
	}

}
