package edu.neu.cs5200.inventory.rest;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import edu.neu.cs5200.inventory.dao.CarDao;
import edu.neu.cs5200.inventory.dao.MakeDao;
import edu.neu.cs5200.inventory.dao.ModelDao;
import edu.neu.cs5200.inventory.dao.PersonDao;
import edu.neu.cs5200.inventory.dao.RatingDao;
import edu.neu.cs5200.inventory.dao.ViewDao;
import edu.neu.cs5200.inventory.jpa.Car;
import edu.neu.cs5200.inventory.jpa.Details;
import edu.neu.cs5200.inventory.jpa.Make;
import edu.neu.cs5200.inventory.jpa.Model;
import edu.neu.cs5200.inventory.jpa.PersonCarMapper;
import edu.neu.cs5200.inventory.jpa.RecentView;
import flexjson.JSONSerializer;

@Path("/view")
public class ViewService {

	ViewDao dao = new ViewDao();
	PersonDao pdao = new PersonDao();
	RatingDao rdao = new RatingDao();
	MakeDao mdao = new MakeDao();
	ModelDao modao = new ModelDao();
	CarDao cdao = new CarDao();
			
	
/*	@GET
	@Path("/viewsforperson/{name}")
	@Produces("application/json")
	public List<Long> getViewsForPerson(@PathParam("name") String username) {
		int personId = pdao.findPersonIdByUsername(username);
		return dao.retrieveViewsOfPersonById(personId);
	}*/
	
	@GET
	@Path("/viewsforperson/{name}")
	@Produces("application/json")
	public String getViewsForPerson(@PathParam("name") String username) {
		int personId = pdao.findPersonIdByUsername(username);
		System.out.println("now::" + personId);
		List<RecentView> views =  dao.retrieveViewsOfPersonById(personId);
		List<Details> details = new ArrayList();
		//List
		if (views != null) {
			for (RecentView view : views) {
				Details detail = new Details();
				Car car = cdao.findCar(view.getSearchCar().getStyleId());
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
	
	@GET
	@Path("/likedbyrperson/{name}")
	@Produces("application/json")
	public List<Long> getLikedForPerson(@PathParam("name") String username) {
		int personId = pdao.findPersonIdByUsername(username);
		return dao.retrieveTopThreeLikesForPerson(personId);
	}
}
