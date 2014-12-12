package edu.neu.cs5200.inventory.jpa;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;

import org.eclipse.persistence.annotations.CascadeOnDelete;

@Entity
@NamedQueries({ @NamedQuery(name="Person.findAllPersons", query="select p from Person p"), 
				@NamedQuery(name="Person.findPasswordForUsername", query="select p.password from Person p where p.username = :username"), 
				@NamedQuery(name="Person.findPersonByUserName", query="select p from Person p where p.username = :username"), 
				@NamedQuery(name="Person.findPersonIdByUserName", query="select p.personId from Person p where p.username = :username")})
public class Person {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int personId;
	@Column(name="fname")
	private String firstName;
	@Column(name="lname")
	private String lastName;
	private String emailid;
	private String username;
	private String password;
	
	@OneToMany(mappedBy="searchPerson",cascade = CascadeType.ALL, orphanRemoval = true)
	@CascadeOnDelete
	private List<RecentView> viewCarList;
	
	@OneToMany(mappedBy="ratePerson",cascade = CascadeType.ALL, orphanRemoval = true)
	@CascadeOnDelete
	private List<Rating> ratingCarList;
	
	@OneToMany(mappedBy="mapPerson",cascade = CascadeType.ALL, orphanRemoval = true)
	@CascadeOnDelete
	private List<PersonCarMapper> mapperCarList;
	
	public List<PersonCarMapper> getMapperCarList() {
		return mapperCarList;
	}
	public void setMapperCarList(List<PersonCarMapper> mapperCarList) {
		this.mapperCarList = mapperCarList;
	}
	public List<Rating> getRatingCarList() {
		return ratingCarList;
	}
	public void setRatingCarList(List<Rating> ratingCarList) {
		this.ratingCarList = ratingCarList;
	}
	public List<RecentView> getViewCarList() {
		return viewCarList;
	}
	public void setViewCarList(List<RecentView> viewCarList) {
		this.viewCarList = viewCarList;
	}
	public int getPersonId() {
		return personId;
	}
	public void setPersonId(int personId) {
		this.personId = personId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmailid() {
		return emailid;
	}
	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
}

