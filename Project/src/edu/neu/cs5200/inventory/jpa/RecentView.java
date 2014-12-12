package edu.neu.cs5200.inventory.jpa;

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
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.MappedSuperclass;


@Entity
@Table(name="user_view_car")
@IdClass(RecentViewId.class)
@NamedQueries({ @NamedQuery(name="RecentView.findCarsByPersonId", query="select rv.styleId from RecentView rv where "
							+ "rv.personId = :personId"), 
				@NamedQuery(name="RecentView.findIfGivenCarPresentForGivenPerson", query="select rv from RecentView rv where "
							+ "rv.personId = :personId and rv.styleId = :styleId" ), 
				@NamedQuery(name="RecentView.retrieveStyleIdForLikes", query="select rv.styleId from RecentView rv  "
							+ " where rv.personId = :personId and rv.hasLiked=1 order by rv.createdAt desc "), 
				@NamedQuery(name="RecentView.findReviewsByPersonId", query="select rv from RecentView rv  "
									+ " where rv.personId = :personId order by rv.createdAt desc ")})

public class RecentView {
	
	@Id
	@Column(name="person_id", insertable=false, updatable=false)
	private long personId;
	
	@Id
	@Column(name="style_id", insertable=false, updatable=false)
	private long styleId;
	
	@Column(name="has_liked")
	private boolean hasLiked = false;
	@ManyToOne
	@JoinColumn(name="person_id")
	private Person searchPerson;
	
	@ManyToOne
	@JoinColumn(name="style_id")
	private Car searchCar;
	
	@Column(name="created_at")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdAt;
	
	  public void save() {
	    createdAt();
	  }
	
	@PrePersist
	  void createdAt() {
	    this.createdAt =  new Date();
	  }
	 
	public RecentView() {
		
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

	public Person getSearchPerson() {
		return searchPerson;
	}

	public void setSearchPerson(Person searchPerson) {
		this.searchPerson = searchPerson;
	}

	public Car getSearchCar() {
		return searchCar;
	}

	public void setSearchCar(Car searchCar) {
		this.searchCar = searchCar;
	}

}
