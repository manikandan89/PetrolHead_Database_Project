package edu.neu.cs5200.inventory.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.codehaus.jackson.annotate.JsonIgnore;

import edu.neu.cs5200.inventory.dao.PersonDao;
import edu.neu.cs5200.inventory.dao.RatingDao;
import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.Rating;
import flexjson.JSONSerializer;

@Path("/person")
public class PersonService {
	
	PersonDao dao = new PersonDao();
	RatingDao rdao = new RatingDao();
			
	
	@GET
	@Path("/get/{name}")
	@Produces("application/json")
	public Person getPersonByUserName(@PathParam("name") String username) {
		System.out.println(username);
		Person person = dao.findPersonByUsername(username);
		System.out.println(person.getEmailid());
		return person;
	}
	
	@GET
	@Path("/getallusersforadmin")
	@Produces(MediaType.APPLICATION_JSON)
	public String getAllPersonsForAdmin() {
		System.out.println("Webservice called");
		List<Person> persons = dao.findAllPersons();
		System.out.println(persons.size());
		JSONSerializer serializer = new JSONSerializer();
	    return serializer.serialize(persons);
	}
	
	@DELETE
	@Path("/deleteuser/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String removeUser(@PathParam("name") String username) {
		//int personId = pdao.findPersonIdByUsername(name);
		System.out.println("retrieve all persons for delete");
		List<Person> persons = dao.removePerson(username);
		JSONSerializer serializer = new JSONSerializer();
	    return serializer.serialize(persons);
	}
	
	@GET
	@Path("/getallcommentsforuser/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getAllCommentsForAdmin(@PathParam("name") String username) {
		int personId = dao.findPersonIdByUsername(username);
		List<Rating> rates = rdao.findAllRatesForPerson(personId);
		System.out.println(rates.size());
		JSONSerializer serializer = new JSONSerializer();
	    return serializer.serialize(rates);
	}
	
	@DELETE
	@Path("/deletecomment/{user}/{comment}")
	@Produces(MediaType.APPLICATION_JSON)
	public String removeComment(@PathParam("user") String username,@PathParam("comment") String comment) {
		int personId = dao.findPersonIdByUsername(username);
		System.out.println("delete comment");
		List<Rating> rates = rdao.removeComment(personId,comment);
		JSONSerializer serializer = new JSONSerializer();
	    return serializer.serialize(rates);
	}
}
