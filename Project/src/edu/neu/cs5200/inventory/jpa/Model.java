package edu.neu.cs5200.inventory.jpa;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.eclipse.persistence.annotations.CascadeOnDelete;

@Entity
public class Model implements Serializable {
	
	@Id
	@Column(name="id")
	private String modelId;
	private String name;
	private String niceName;
	
	@ManyToOne
	@JoinColumn(name="makeId")
	private Make make;
	
	@ManyToMany
	@JoinTable(name="model_map_year", joinColumns={@JoinColumn(name="id")}, inverseJoinColumns={@JoinColumn(name="year")})
	private List<Years> years;
	
	@OneToMany(mappedBy="model", cascade = CascadeType.ALL, orphanRemoval = true)
	@CascadeOnDelete
	private List<Car> cars;
	
	public List<Car> getCars() {
		return cars;
	}

	public void setCars(List<Car> cars) {
		this.cars = cars;
	}

	public Model() {
		super();
	}
	
	public String getNiceName() {
		return niceName;
	}

	public void setNiceName(String niceName) {
		this.niceName = niceName;
	}
	
	public List<Years> getYears() {
		return years;
	}
	public void setYears(List<Years> years) {
		this.years = years;
	}
	public String getModelId() {
		return modelId;
	}
	public void setModelId(String modelId) {
		this.modelId = modelId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Make getMake() {
		return make;
	}
	public void setMake(Make make) {
		this.make = make;
	}
	
	/*public void addYear(Years year) {
		
		MapModelYear map = new MapModelYear();
		map.setModel(this);
		map.setYear(year);
		this.years.add(map);
		year.getModels().add(map);
	}*/
}
