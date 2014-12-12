package edu.neu.cs5200.inventory.rest;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import edu.neu.cs5200.inventory.dao.CarDao;



@Path("/car")
public class CarService {
	
	CarDao dao = new CarDao();
	@GET
	@Path("/")
	@Produces("application/json")
	public List<Long> getTrendingStyleIds() {
		return dao.retrieveTopThreeForTrends();
	}

}
