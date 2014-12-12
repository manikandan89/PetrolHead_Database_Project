package edu.neu.cs5200.inventory.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;

import edu.neu.c5200.inventory.client.InventoryWebserviceClient;
import edu.neu.cs5200.inventory.jpa.Make;
import edu.neu.cs5200.inventory.jpa.Master;

@Path("/master")
public class MasterService {
	@POST
	@Path("/")
	@Consumes("application/json")
	public void createMaster(Master newMaster) {
		
		InventoryWebserviceClient client = InventoryWebserviceClient.getInstance();
		if (newMaster.getUsername() == null) {
			System.out.println("Master USername failure");
		} else {
			System.out.println("Master USername success");
		}
		client.processMasterUrl(newMaster.getUrl(),newMaster.getUsername());
	}
	

}
