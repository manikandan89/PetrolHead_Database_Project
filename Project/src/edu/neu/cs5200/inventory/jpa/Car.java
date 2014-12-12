package edu.neu.cs5200.inventory.jpa;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;

import org.eclipse.persistence.annotations.CascadeOnDelete;

@Entity
@NamedQueries({ @NamedQuery(name="Car.retrieveStyleIdForTrends", query="select c.styleId from Car c order by "
		+ "c.hitCount desc ")})

public class Car {

	@Id
	@Column(name="id")
	private long styleId;
	
	@Column(length = 500)
	private String name;

	@ManyToOne
	@JoinColumn(name="modelId")
	private Model model;
	
	@ManyToOne
	@JoinColumn(name="year")
	private Years year;
	
	@ManyToOne
	@JoinColumn(name="makeId")
	private Make make;
	
	@OneToMany(mappedBy="searchCar",cascade = CascadeType.ALL, orphanRemoval = true)
	@CascadeOnDelete
	private List<RecentView> viewPersonList;
	
	@OneToMany(mappedBy="rateCar",cascade = CascadeType.ALL, orphanRemoval = true)
	@CascadeOnDelete
	private List<Rating> ratingPersonList;
	
	@Column(name="count")
	private int hitCount=1;
	
	@OneToMany(mappedBy="mapCar",cascade = CascadeType.ALL, orphanRemoval = true)
	@CascadeOnDelete
	private List<PersonCarMapper> mapperPersonList;
	
	public List<PersonCarMapper> getMapperPersonList() {
		return mapperPersonList;
	}

	public void setMapperPersonList(List<PersonCarMapper> mapperPersonList) {
		this.mapperPersonList = mapperPersonList;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public List<Rating> getRatingPersonList() {
		return ratingPersonList;
	}

	public void setRatingPersonList(List<Rating> ratingPersonList) {
		this.ratingPersonList = ratingPersonList;
	}

	public List<RecentView> getViewPersonList() {
		return viewPersonList;
	}

	public void setViewPersonList(List<RecentView> viewPersonList) {
		this.viewPersonList = viewPersonList;
	}

	public Model getModel() {
		return model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public Years getYear() {
		return year;
	}

	public void setYear(Years year) {
		this.year = year;
	}
	
	public Car() {
		super();
	}
	
	public long getStyleId() {
		return styleId;
	}

	public void setStyleId(long styleId) {
		this.styleId = styleId;
	}

	public Make getMake() {
		return make;
	}

	public void setMake(Make make) {
		this.make = make;
	}
	
}


