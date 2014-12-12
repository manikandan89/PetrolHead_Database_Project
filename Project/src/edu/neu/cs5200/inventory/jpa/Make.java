package edu.neu.cs5200.inventory.jpa;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;

import org.eclipse.persistence.annotations.CascadeOnDelete;

@Entity
@NamedQueries({ @NamedQuery(name="Make.findMakeById", query="select m.name from Make m where m.makeId = :makeId") })
public class Make implements Serializable {
	
	@Id
	@Column(name="id")
	private long makeId;
	private String name;
	private String niceName;
	@OneToMany(mappedBy="make", cascade = CascadeType.PERSIST, orphanRemoval = true)
	@CascadeOnDelete
	private List<Model> models;
	@OneToMany(mappedBy="make", cascade = CascadeType.PERSIST, orphanRemoval = true)
	@CascadeOnDelete
	private List<Car> cars;
	
	public Make() {
		super();
	}
	
	public List<Car> getCars() {
		return cars;
	}

	public void setCars(List<Car> cars) {
		this.cars = cars;
	}
	
	public List<Model> getModels() {
		return models;
	}
	public void setModels(List<Model> models) {
		this.models = models;
	}
	public long getMakeId() {
		return makeId;
	}
	public void setMakeId(long makeId) {
		this.makeId = makeId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNiceName() {
		return niceName;
	}
	public void setNiceName(String niceName) {
		this.niceName = niceName;
	}

}
