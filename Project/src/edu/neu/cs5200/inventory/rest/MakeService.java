package edu.neu.cs5200.inventory.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

import edu.neu.cs5200.inventory.dao.MakeDao;
import edu.neu.cs5200.inventory.jpa.Make;

@Path("/make")
public class MakeService {

	MakeDao dao = new MakeDao();
	
	@POST
	@Path("/")
	@Consumes("application/json")
	public void createMake(Make newMake) {
		dao.createMake(newMake);
	}
	
	@GET
	@Path("/getmake/{id}")
	@Consumes("application/json")
	public Make getMake(@PathParam("id") int makeId) {
		return dao.findMake(makeId);
	}
	
	@GET
	@Path("/sayHello")
	public String sayHello() {
		return "Hello World!!!!!!!";
	}
}
