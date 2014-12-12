package edu.neu.cs5200.inventory.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.ws.rs.PathParam;

import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.Rating;
import edu.neu.cs5200.inventory.jpa.RecentView;

public class RatingDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Project");
	EntityManager em = null;
	
	public RatingDao() {
		super();
		em = factory.createEntityManager();
	}

	public void createRating(Rating rate) {
		em.getTransaction().begin();
		em.persist(rate);
		em.getTransaction().commit();
	}
	
	public List<Rating> findAllRating() {
		em.getTransaction().begin();
		Query query = em.createNamedQuery("Rating.findAll");
		List<Rating> rates = query.getResultList();
		em.getTransaction().commit();
		return rates;
	}

	public List<Rating> updateRate(int personId, Rating rate) {
		
		em.getTransaction().begin();
		Query query1 = em.createNamedQuery("Rating.findRateForPersonandStyle");
		query1.setParameter("personId", personId);
		query1.setParameter("styleId", rate.getStyleId());
		Rating r = (Rating) query1.getSingleResult();
		r.setName(rate.getName());
		em.merge(r);
		Query query = em.createNamedQuery("Rating.findAll");
		List<Rating> rates = query.getResultList();
		em.getTransaction().commit();
		return rates;
	}
	
	public List<Rating> removeRate(int personId,long styleId) {
		em.getTransaction().begin();
		Query query1 = em.createNamedQuery("Rating.findRateForPersonandStyle");
		query1.setParameter("personId", personId);
		query1.setParameter("styleId", styleId);
		Rating rate = (Rating) query1.getSingleResult();
		em.remove(rate);
		Query query = em.createNamedQuery("Rating.findAll");
		List<Rating> rates = query.getResultList();
		em.getTransaction().commit();
		return rates;
	}
	
	public List<Rating> findAllRatesForPerson(int personId) {
		em.getTransaction().begin();
		Query query1 = em.createNamedQuery("Rating.findAllRatesForPerson");
		query1.setParameter("personId", personId);
		List<Rating> rates = query1.getResultList();
		em.getTransaction().commit();
		return rates;
	}
	
	public List<Rating> findAllRatesForCar(long styleId) {
		em.getTransaction().begin();
		Query query1 = em.createNamedQuery("Rating.findAllRatesForCar");
		query1.setParameter("styleId", styleId);
		List<Rating> rates = query1.getResultList();
		if (rates == null) {
			System.out.println("Not present");
		} else {
			System.out.println("Present");
		}
		em.getTransaction().commit();
		return rates;
	}
	
	public Rating retrieveLatestReview(int personId, long styleId) {
		
		em.getTransaction().begin();
	
		Query q = em.createNamedQuery("Rating.findLatestReviewForCar");
		 q.setParameter("personId", personId);
		 q.setParameter("styleId", styleId);
		if(q.getResultList().size() < 1) {
			return null;
		}
		Query q1 = em.createNamedQuery("Rating.findLatestReviewForCar");
		 q1.setParameter("personId", personId);
		 q1.setParameter("styleId", styleId);
		q1.setMaxResults(1);
		Rating rating = (Rating) q1.getSingleResult();
		em.getTransaction().commit();
		return rating;
	}
	
	public List<Rating> removeComment(int personId, String comment) {
		em.getTransaction().begin();
		Query query1 = em.createNamedQuery("Rating.findRateForUserAndComment");
		query1.setParameter("personId", personId);
		query1.setParameter("comment", comment);
		Rating rating = (Rating) query1.getSingleResult();
		em.remove(rating);
		Query query = em.createNamedQuery("Rating.findAllRatesForPerson");
		query.setParameter("personId", personId);
		List<Rating> rates = query.getResultList();
		em.getTransaction().commit();
		return rates;
	}
	
	public List<Rating> editRate(int personId, Rating rate) {
		em.getTransaction().begin();
		Query query1 = em.createNamedQuery("Rating.findRateForPersonandStyle");
		query1.setParameter("personId", personId);
		query1.setParameter("styleId", rate.getStyleId());
		List<Rating> rateList = query1.getResultList();
		if (!rateList.isEmpty() && rateList.get(0) != null && rateList.get(0).getComment() != null) {
			rateList.get(0).setComment(rate.getComment());
			em.merge(rateList.get(0));
		}
		
		Query query = em.createNamedQuery("Rating.findAllRatesForPerson");
		query.setParameter("personId", personId);
		List<Rating> rates = query.getResultList();
		em.getTransaction().commit();
		return rates;
	}

}
