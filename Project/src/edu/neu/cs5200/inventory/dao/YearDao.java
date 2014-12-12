package edu.neu.cs5200.inventory.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import edu.neu.cs5200.inventory.jpa.Model;
import edu.neu.cs5200.inventory.jpa.Years;

public class YearDao {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Project");
	EntityManager em = null;
	
	public YearDao() {
		super();
		em = factory.createEntityManager();
	}
	
	public void createYear(Years year) {
		em.getTransaction().begin();
		em.persist(year);
		em.getTransaction().commit();
	}
	
	public Years findYear(long year) {
		em.getTransaction().begin();
		Years yearObj = em.find(Years.class,year);
		em.getTransaction().commit();
		return yearObj;
	}
}
