package edu.neu.cs5200.inventory.rest;

import javax.ws.rs.Path;

import edu.neu.cs5200.inventory.dao.CarDao;
import edu.neu.cs5200.inventory.dao.PersonDao;
import edu.neu.cs5200.inventory.dao.RatingDao;

@Path("/admin")
public class AdminService {

	RatingDao dao = new RatingDao();
	PersonDao pdao = new PersonDao();
	CarDao cdao = new CarDao();
	
	
}
