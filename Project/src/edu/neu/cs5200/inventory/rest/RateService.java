package edu.neu.cs5200.inventory.rest;

import java.text.DateFormat;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.commons.collections.functors.ForClosure;













import edu.neu.cs5200.inventory.dao.CarDao;
import edu.neu.cs5200.inventory.dao.MakeDao;
import edu.neu.cs5200.inventory.dao.ModelDao;
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

@Path("/rate")
public class RateService {

	RatingDao dao = new RatingDao();
	PersonDao pdao = new PersonDao();
	CarDao cdao = new CarDao();
	RatingDao rdao = new RatingDao();
	MakeDao mdao = new MakeDao();
	ModelDao modao = new ModelDao();
	
	@POST
	@Path("/{name}")
	@Consumes("application/json")
	@Produces("application/json")
	public String postComment(@PathParam("name") String username, Rating rate) {
		int personId = pdao.findPersonIdByUsername(username);
		Car car = cdao.findCar(rate.getStyleId());
		Person person = pdao.findPersonByUsername(username);
		rate.setRatePerson(person);
		rate.setRateCar(car);
		System.out.println("rate::" + rate.getRate());
		System.out.println("style::" + rate.getStyleId());
		System.out.println("comment::" + rate.getComment());
		System.out.println("person::" + username);
		rate.setPersonId(personId);
		dao.createRating(rate);
		System.out.println("retrieve all rates");
		List<Rating> ratesList = dao.findAllRating();
		String reportDate = null;
		for (Rating rating : dao.findAllRating()) {
			System.out.println(rating.getCommentDate());
			/*Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			reportDate = formatter.format(rating.getCommentDate());*/
		}
		  JSONSerializer serializer = new JSONSerializer();
	       return serializer.serialize(ratesList);
	}
	
	@GET
	@Path("/ratesforstyle/{styleId}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getRatesForCar(@PathParam("styleId") long styleId) {
		System.out.println("styleId in rateservice " + styleId);
		List<Rating> ratesList = dao.findAllRatesForCar(styleId);
		JSONSerializer serializer = new JSONSerializer();
	    return serializer.serialize(ratesList);
	}
	
	@PUT
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public String editComment(Rating rate) {
		int personId = pdao.findPersonIdByUsername(rate.getName());
		System.out.println("retrieve all rates for update");
		List<Rating> ratesList = dao.updateRate(personId, rate);
		JSONSerializer serializer = new JSONSerializer();
	    return serializer.serialize(ratesList);
	}
	
	@POST
	@Path("/deletecomment")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public String removeRating(Rating rate) {
		int personId = pdao.findPersonIdByUsername(rate.getName());
		System.out.println("retrieve all rates for update");
		List<Rating> ratesList = dao.removeRate(personId,rate.getStyleId());
		JSONSerializer serializer = new JSONSerializer();
	    return serializer.serialize(ratesList);
	}
	
	@PUT
	@Path("/editcomment")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public String editRating(Rating rate) {
		int personId = pdao.findPersonIdByUsername(rate.getName());
		System.out.println("retrieve all rates for edit");
		List<Rating> ratesList = dao.editRate(personId,rate);
		JSONSerializer serializer = new JSONSerializer();
	    return serializer.serialize(ratesList);
	}
	
	
	@GET
	@Path("/ratesforperson/{name}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getRatesForPerson(@PathParam("name") String username) {
		int personId = pdao.findPersonIdByUsername(username); 
		List<Rating> ratesList = dao.findAllRatesForPerson(personId);
		List<Details> details = new ArrayList();
		//List
		if (ratesList != null) {
			for (Rating rate : ratesList) {
				Details detail = new Details();
				Car car = cdao.findCar(rate.getRateCar().getStyleId());
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
	
}
