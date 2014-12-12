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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name="user_rating_car")
@IdClass(RatingId.class)
@NamedQueries({ @NamedQuery(name="Rating.findAll", query="select r from Rating r"), 
				@NamedQuery(name="Rating.findRateForPersonandStyle", query="select r from Rating r where r.personId = :personId "
						+ "and r.styleId = :styleId"), 
				@NamedQuery(name="Rating.findAllRatesForPerson", query="select r from Rating r where r.personId = :personId"), 
				@NamedQuery(name="Rating.findAllRatesForCar", query="select r from Rating r where r.styleId = :styleId"), 
				@NamedQuery(name="Rating.findLatestReviewForCar", query="select r from Rating r where r.styleId = :styleId "
						+ "and r.personId != :personId order by r.commentDate desc"), 
				@NamedQuery(name="Rating.findRateForUserAndComment", query="select r from Rating r where "
						+ "r.personId = :personId and r.comment = :comment")})
public class Rating implements Serializable{
	
	@Id
	@Column(name="person_id", insertable=false, updatable=false)
	private long personId;
	
	@Id
	@Column(name="style_id", insertable=false, updatable=false)
	private long styleId;
	
	@Column(length=1024)
	private String comment;
	@Column(name="comment_date", nullable=false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date commentDate;


	public void save() {
		    createdAt();
		  }
		
		@PrePersist
		  void createdAt() {
		    this.commentDate =  new Date();
		  }
	
	private int rate;
	
	@ManyToOne
	@JoinColumn(name="person_id")
	private Person ratePerson;
	
	@ManyToOne
	@JoinColumn(name="style_id")
	private Car rateCar;
	
	private String name;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Rating() {
		
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

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	public Person getRatePerson() {
		return ratePerson;
	}

	public void setRatePerson(Person ratePerson) {
		this.ratePerson = ratePerson;
	}

	public Car getRateCar() {
		return rateCar;
	}

	public void setRateCar(Car rateCar) {
		this.rateCar = rateCar;
	}

}
