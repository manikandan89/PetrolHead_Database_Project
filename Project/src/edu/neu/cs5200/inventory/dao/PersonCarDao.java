package edu.neu.cs5200.inventory.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.cs5200.inventory.jpa.Car;
import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.PersonCarMapper;
import edu.neu.cs5200.inventory.jpa.Rating;

public class PersonCarDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Project");
	EntityManager em = null;
	
	public PersonCarDao() {
		super();
		em = factory.createEntityManager();
	}
	
	public void insertLikeEntry(Person person, Car car) {
		
		em.getTransaction().begin();
		//em.persist(view);
		PersonCarMapper pcm = new PersonCarMapper();
		Query query1 = em.createNamedQuery("Mapper.findMappingForPersonandStyle");
		query1.setParameter("personId", person.getPersonId());
		query1.setParameter("styleId", car.getStyleId());
		List<PersonCarMapper> mapperList = query1.getResultList();
		if(mapperList.isEmpty()) {
			pcm.setHasFollowed(false);
			pcm.setHasLiked(true);
			pcm.setMapPerson(person);
			pcm.setMapCar(car);
			em.persist(pcm);
		} else {
			if (mapperList.get(0) != null) {
				PersonCarMapper r = mapperList.get(0);
				if (!r.isHasLiked()) {
					r.setHasLiked(true);
					em.merge(r);
				}
			}
			
		}
		
		em.getTransaction().commit();
	}
	
public void insertUnLikeEntry(Person person, Car car) {
		
		em.getTransaction().begin();
		//em.persist(view);
		Query query1 = em.createNamedQuery("Mapper.findMappingForPersonandStyle");
		query1.setParameter("personId", person.getPersonId());
		query1.setParameter("styleId", car.getStyleId());
		List<PersonCarMapper> mapperList = query1.getResultList();
		if(!mapperList.isEmpty()) {
			if (mapperList.get(0) != null) {
				PersonCarMapper r = mapperList.get(0);
				if (r.isHasLiked()) {
					r.setHasLiked(false);
					em.merge(r);
				}
			}
		}
		
		em.getTransaction().commit();
	}

	public void insertFollowEntry(Person person, Car car) {
		
		em.getTransaction().begin();
		//em.persist(view);
		PersonCarMapper pcm = new PersonCarMapper();
		Query query1 = em.createNamedQuery("Mapper.findMappingForPersonandStyle");
		query1.setParameter("personId", person.getPersonId());
		query1.setParameter("styleId", car.getStyleId());
		List<PersonCarMapper> mapperList = query1.getResultList();
		if(mapperList.isEmpty()) {
			pcm.setHasFollowed(true);
			pcm.setHasLiked(false);
			pcm.setMapPerson(person);
			pcm.setMapCar(car);
			em.persist(pcm);
		} else {
			if (mapperList.get(0) != null) {
				PersonCarMapper r = mapperList.get(0);
				if (!r.isHasFollowed()) {
					r.setHasFollowed(true);
					em.merge(r);
				}
			}
		}
		
		em.getTransaction().commit();
	}
	
public void insertUnfollowEntry(Person person, Car car) {
		
		em.getTransaction().begin();
		//em.persist(view);
		Query query1 = em.createNamedQuery("Mapper.findMappingForPersonandStyle");
		query1.setParameter("personId", person.getPersonId());
		query1.setParameter("styleId", car.getStyleId());
		List<PersonCarMapper> mapperList = query1.getResultList();
		if(!mapperList.isEmpty()) {
			if (mapperList.get(0) != null) {
				PersonCarMapper r = mapperList.get(0);
				if (r.isHasFollowed()) {
					r.setHasFollowed(false);
					em.merge(r);
				}
			}
		}
		
		em.getTransaction().commit();
	}

	public List<PersonCarMapper> retrieveTopThreeLikesForPerson(int personId) {
		
		em.getTransaction().begin();
	
		Query q = em.createNamedQuery("Mapper.retrieveStyleIdForLikes");
		 q.setParameter("personId", personId);
		if(q.getResultList().size() < 3) {
			return q.getResultList();
		}
		Query q1 = em.createNamedQuery("Mapper.retrieveStyleIdForLikes");
		q1.setParameter("personId", personId);
		q1.setMaxResults(3);
		List<PersonCarMapper> styleIds = q1.getResultList();
		em.getTransaction().commit();
		return styleIds;
	}
	
	/*public List<Long> retrieveTopThreeFollowedForPerson(int personId) {
		
		em.getTransaction().begin();
	
		Query q = em.createNamedQuery("Mapper.retrieveStyleIdForFollows");
		 q.setParameter("personId", personId);
		if(q.getResultList().size() < 3) {
			return q.getResultList();
		}
		Query q1 = em.createNamedQuery("Mapper.retrieveStyleIdForFollows");
		q1.setParameter("personId", personId);
		q1.setMaxResults(3);
		List<PersonCarMapper> styleIds = q1.getResultList();
		em.getTransaction().commit();
		return styleIds;
	}*/
	
	public PersonCarMapper retrieveLikeAndFollowStatusForPersonForCar(int personId, long styleId) {
		em.getTransaction().begin();
		Query query1 = em.createNamedQuery("Mapper.findMappingForPersonandStyle");
		query1.setParameter("personId", personId);
		query1.setParameter("styleId", styleId);
		List<PersonCarMapper> mapperList = query1.getResultList();
		if(!mapperList.isEmpty() && mapperList.get(0) != null) {
			System.out.println("test1 for follow");
			return mapperList.get(0);
		}
		System.out.println("test2 for follow");
		em.getTransaction().commit();
		return null;
	}
	
}
