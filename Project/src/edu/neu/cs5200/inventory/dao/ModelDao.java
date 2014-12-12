package edu.neu.cs5200.inventory.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import edu.neu.cs5200.inventory.jpa.Make;
import edu.neu.cs5200.inventory.jpa.Model;

public class ModelDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Project");
	EntityManager em = null;
	
	public ModelDao() {
		super();
		em = factory.createEntityManager();
	}
	
	public void createModel(Model model) {
		em.getTransaction().begin();
		if(model != null && model.getModelId() != null) {
			em.persist(model);
		}
		em.getTransaction().commit();
		
	}
	public Model findModel(String modelId) {
		em.getTransaction().begin();
		Model model = em.find(Model.class,modelId);
		em.getTransaction().commit();
		return model;
	}
}
