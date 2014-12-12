package edu.neu.cs5200.inventory.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.cs5200.inventory.jpa.Car;
import edu.neu.cs5200.inventory.jpa.RecentView;

public class ViewDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Project");
	EntityManager em = null;
	
	public ViewDao() {
		super();
		em = factory.createEntityManager();
	}
	
	public void createView(RecentView view) {
		em.getTransaction().begin();
		em.persist(view);
		em.getTransaction().commit();
	}
	
	/*public List<Long> retrieveViewsOfPersonById(int personId) {
		
		em.getTransaction().begin();
		Query q = em.createNamedQuery("RecentView.findCarsByPersonId");
		q.setParameter("personId", personId);
		List<Long> styleIdsList = q.getResultList();
		em.getTransaction().commit();
		return styleIdsList;
	}*/
	
	public List<RecentView> retrieveViewsOfPersonById(int personId) {
		
		em.getTransaction().begin();
		Query q = em.createNamedQuery("RecentView.findReviewsByPersonId");
		q.setParameter("personId", personId);
		List<RecentView> viewsList = q.getResultList();
		em.getTransaction().commit();
		return viewsList;
	}
	
	public List<RecentView> retrieveViewsOfPersonAndCar(int personId, long styleId) {
		
		em.getTransaction().begin();
		Query q = em.createNamedQuery("RecentView.findIfGivenCarPresentForGivenPerson");
		q.setParameter("personId", personId);
		q.setParameter("styleId", styleId);
		List<RecentView> viewList = q.getResultList();
		em.getTransaction().commit();
		return viewList;
	}
	
	public List<Long> retrieveTopThreeLikesForPerson(int personId) {
		
		em.getTransaction().begin();
	
		Query q = em.createNamedQuery("RecentView.retrieveStyleIdForLikes");
		 q.setParameter("personId", personId);
		if(q.getResultList().size() < 3) {
			return q.getResultList();
		}
		Query q1 = em.createNamedQuery("RecentView.retrieveStyleIdForLikes");
		q1.setParameter("personId", personId);
		q1.setMaxResults(3);
		List<Long> styleIds = q1.getResultList();
		em.getTransaction().commit();
		return styleIds;
	}
	
	

}
