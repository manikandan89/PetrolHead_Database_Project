package edu.neu.cs5200.inventory.jpa;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@IdClass(PersonCarMapperId.class)
@Table(name="user_map_car")
@NamedQueries({@NamedQuery(name="Mapper.findMappingForPersonandStyle", query="select r from PersonCarMapper r where r.personId = :personId "
			+ "and r.styleId = :styleId"), 
			@NamedQuery(name="Mapper.retrieveStyleIdForLikes", query="select rv from PersonCarMapper rv  "
					+ " where rv.personId = :personId and rv.hasLiked=1 order by rv.updatedAt desc"), 
			@NamedQuery(name="Mapper.retrieveStyleIdForFollows", query="select rv.styleId from PersonCarMapper rv  "
							+ " where rv.personId = :personId and rv.hasFollowed=1 order by rv.updatedAt desc")})
public class PersonCarMapper implements Serializable {

	@Id
	@Column(name="person_id", insertable=false, updatable=false)
	private long personId;
	
	@Id
	@Column(name="style_id", insertable=false, updatable=false)
	private long styleId;
	
	@Column(name="has_liked")
	private boolean hasLiked;
	
	@Column(name="has_followed")
	private boolean hasFollowed;
	
	

	@ManyToOne
	@JoinColumn(name="person_id")
	private Person mapPerson;
	
	@ManyToOne
	@JoinColumn(name="style_id")
	private Car mapCar;
	
	@Column(name="created_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdAt;
	
	@Column(name="updated_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatedAt;
	
	public boolean isHasFollowed() {
		return hasFollowed;
	}

	public void setHasFollowed(boolean hasFollowed) {
		this.hasFollowed = hasFollowed;
	}
	
	  public long getPersonId() {
		return personId;
	}

	public void setPersonId(long personId) {
		this.personId = personId;
	}

	public long getStyleId() {
		return styleId;
	}

	public void setStyleId(long styleId) {
		this.styleId = styleId;
	}

	public boolean isHasLiked() {
		return hasLiked;
	}

	public void setHasLiked(boolean hasLiked) {
		this.hasLiked = hasLiked;
	}

	public Person getMapPerson() {
		return mapPerson;
	}

	public void setMapPerson(Person mapPerson) {
		this.mapPerson = mapPerson;
	}

	public Car getMapCar() {
		return mapCar;
	}

	public void setMapCar(Car mapCar) {
		this.mapCar = mapCar;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void save() {
		setCreatedAt();
	  }
	
	@PrePersist
	  void setCreatedAt() {
	    this.createdAt = this.updatedAt=  new Date();
	  }
	

	  @PreUpdate
	  protected void onUpdate() {
		  updatedAt = new Date();
	  }
	
}
