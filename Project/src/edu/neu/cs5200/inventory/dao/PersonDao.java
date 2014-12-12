package edu.neu.cs5200.inventory.dao;

import edu.neu.c5200.inventory.*;
import edu.neu.cs5200.inventory.jpa.Make;
import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.Rating;
import edu.neu.cs5200.inventory.jpa.User;
import flexjson.JSONSerializer;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;



public class PersonDao extends BaseDao{
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Project");
	EntityManager em = null;
	
	public PersonDao() {
		super();
		em = factory.createEntityManager();
	}
	
	public List<Person> createPerson(Person person) {
		em.getTransaction().begin();
		em.persist(person);
		Query query = em.createNamedQuery("Person.findAllPersons");
		List<Person> persons = query.getResultList();
		em.getTransaction().commit();
		return persons;
	}
	
	public String findPasswordForUserName(String username) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Person.findPasswordForUsername");
		q.setParameter("username", username);
		String password = (String)q.getSingleResult();
		em.getTransaction().commit();
		return password;
	}
	
	public Person findPersonByUsername(String username) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Person.findPersonByUserName");
		q.setParameter("username", username);
		//System.out.println(q.getSingleResult());
		
		List<Person> persons = q.getResultList();
		System.out.println("Person "+persons.size());
		Person per = (persons == null || persons.isEmpty()) ? null : persons.get(0);
		em.getTransaction().commit();
		return  per;
	}
	
	public int findPersonIdByUsername(String username) {
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Person.findPersonIdByUserName");
		q.setParameter("username", username);
		System.out.println(q.getSingleResult());
		int personId = (int) q.getSingleResult();
		em.getTransaction().commit();
		return personId;
	}
	
	public List<Person> findAllPersons() {
		
		em.getTransaction().begin();
		Query q = em.createNamedQuery("Person.findAllPersons");
		List<Person> persons = q.getResultList();
		em.getTransaction().commit();
		return persons;
	}
	
	public List<Person> removePerson(String username) {
		em.getTransaction().begin();
		Query query1 = em.createNamedQuery("Person.findPersonByUserName");
		query1.setParameter("username", username);
		Person person = (Person) query1.getSingleResult();
		em.remove(person);
		Query query = em.createNamedQuery("Person.findAllPersons");
		List<Person> persons = query.getResultList();
		em.getTransaction().commit();
		return persons;
	}
	
	public static void main(String args[]) {
		/*PersonDao dao = new PersonDao();
		Person person = dao.findPersonByUsername("rafa");
		System.out.println(person.getEmailid());*/
		
	}

}
