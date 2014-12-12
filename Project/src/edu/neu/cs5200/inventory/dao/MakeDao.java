package edu.neu.cs5200.inventory.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import edu.neu.cs5200.inventory.jpa.Make;

public class MakeDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Project");
	EntityManager em = null;
	
	public MakeDao() {
		super();
		em = factory.createEntityManager();
	}

	public void createMake(Make make) {
		em.getTransaction().begin();
		if(make != null && make.getMakeId() > 0) {
			em.persist(make);
		}
		
		em.getTransaction().commit();
	}
	
	public Make findMake(long makeId) {
		em.getTransaction().begin();
		Make make = em.find(Make.class,makeId);
		em.getTransaction().commit();
		return make;
	}
}
