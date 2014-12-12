package edu.neu.cs5200.inventory.rest;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import edu.neu.cs5200.inventory.dao.CarDao;
import edu.neu.cs5200.inventory.dao.MakeDao;
import edu.neu.cs5200.inventory.dao.ModelDao;
import edu.neu.cs5200.inventory.dao.PersonCarDao;
import edu.neu.cs5200.inventory.dao.PersonDao;
import edu.neu.cs5200.inventory.dao.RatingDao;
import edu.neu.cs5200.inventory.jpa.Car;
import edu.neu.cs5200.inventory.jpa.Details;
import edu.neu.cs5200.inventory.jpa.Make;
import edu.neu.cs5200.inventory.jpa.Model;
import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.PersonCarMapper;
import edu.neu.cs5200.inventory.jpa.Rating;
import flexjson.JSONSerializer;

@Path("/mapper")
public class PersonCarMapperService {
	
	PersonCarDao dao = new PersonCarDao();
	PersonDao pdao = new PersonDao();
	CarDao cdao = new CarDao();
	RatingDao rdao = new RatingDao();
	MakeDao mdao = new MakeDao();
	ModelDao modao = new ModelDao();
	
	
	@POST
	@Path("/insertlike/{name}/{styleId}")
	@Produces(MediaType.APPLICATION_JSON)
	public String postLike(@PathParam("name") String username, @PathParam("styleId") long styleId) {
		
		Person person = pdao.findPersonByUsername(username);
		Car car = cdao.findCar(styleId);
		
		dao.insertLikeEntry(person, car);
		
		return "false";
	}
	
	@POST
	@Path("/insertunlike/{name}/{styleId}")
	@Produces(MediaType.APPLICATION_JSON)
	public String postunLike(@PathParam("name") String username, @PathParam("styleId") long styleId) {
		
		Person person = pdao.findPersonByUsername(username);
		Car car = cdao.findCar(styleId);
		
		dao.insertUnLikeEntry(person, car);
		
		return "true";
	}
	
	@POST
	@Path("/insertfollow/{name}/{styleId}")
	@Produces(MediaType.APPLICATION_JSON)
	public String postFollow(@PathParam("name") String username, @PathParam("styleId") long styleId) {
		
		Person person = pdao.findPersonByUsername(username);
		Car car = cdao.findCar(styleId);
		
		dao.insertFollowEntry(person, car);
		
		return "false";
		
	}
	
	@POST
	@Path("/insertunfollow/{name}/{styleId}")
	@Produces(MediaType.APPLICATION_JSON)
	public String postUnfollow(@PathParam("name") String username, @PathParam("styleId") long styleId) {
		
		Person person = pdao.findPersonByUsername(username);
		Car car = cdao.findCar(styleId);
		
		dao.insertUnfollowEntry(person, car);
		return "true";
		
	}
	
	@GET
	@Path("/getlikes/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String retrieveLikesForUser(@PathParam("name") String username) {
		
		int personId = pdao.findPersonIdByUsername(username);
		
		List<PersonCarMapper> mappers = dao.retrieveTopThreeLikesForPerson(personId);
		List<Details> details = new ArrayList();
		//List
		if (mappers != null) {
			for (PersonCarMapper mapper : mappers) {
				Details detail = new Details();
				Car car = cdao.findCar(mapper.getMapCar().getStyleId());
				Make make = mdao.findMake(car.getMake().getMakeId());
				Model model = modao.findModel(car.getModel().getModelId());
				detail.setMake(make.getName());
				detail.setModel(model.getNiceName());
				detail.setStyleId(car.getStyleId());
				detail.setYear(car.getYear().getYear());
				details.add(detail);
			}
		}
		JSONSerializer serializer = new JSONSerializer();
	       return serializer.serialize(details);
	}
	
	/*@GET
	@Path("/getfollows/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Rating> retrieveFollowsForUser(@PathParam("name") String username) {
		
		int personId = pdao.findPersonIdByUsername(username);
		List<Rating> rateList = new ArrayList<Rating>();
		List<Long> styleIdsList = dao.retrieveTopThreeFollowedForPerson(personId);
		for (long styleId : styleIdsList) {
			Rating r = rdao.retrieveLatestReview(personId, styleId);
			if (r != null) {
				rateList.add(r);
			}
		}
		return rateList;
	}*/
	
	@GET
	@Path("/getlikeforcarforthisperson/{name}/{styleId}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getLikeForCarForThisPerson(@PathParam("name") String username, @PathParam("styleId") long styleId) {
		System.out.println("Get like webservice clalled");
		int personId = pdao.findPersonIdByUsername(username);
		PersonCarMapper mapper  = dao.retrieveLikeAndFollowStatusForPersonForCar(personId,styleId);
		if (mapper != null) {
			System.out.println("boolean::" + mapper.isHasLiked());
			if(mapper.isHasLiked()) {
				System.out.println("Going to return false");
				return "false";
			}else {
				System.out.println("Going to return true");
				return "true";
			}
			
		}
		return "true";
	}
	
	@GET
	@Path("/getfollowforcarforthisperson/{name}/{styleId}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getFollowForCarForThisPerson(@PathParam("name") String username, @PathParam("styleId") long styleId) {
		System.out.println("Get follow webservice clalled");
		int personId = pdao.findPersonIdByUsername(username);
		PersonCarMapper mapper  = dao.retrieveLikeAndFollowStatusForPersonForCar(personId,styleId);
		if (mapper != null) {
			System.out.println("boolean::" + mapper.isHasLiked());
			if(mapper.isHasFollowed()) {
				System.out.println("Going to return false for follow");
				return "false";
			}else {
				System.out.println("Going to return true for follow");
				return "true";
			}
			
		}
		return "true";
	}
	
}
