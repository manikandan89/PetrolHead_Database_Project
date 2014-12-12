package edu.neu.cs5200.inventory.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.cs5200.inventory.jpa.Car;
import edu.neu.cs5200.inventory.jpa.Make;
import edu.neu.cs5200.inventory.jpa.Model;
import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.RecentView;
import edu.neu.cs5200.inventory.jpa.User;
import edu.neu.cs5200.inventory.jpa.Years;



public class CarDao {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("Project");
	EntityManager em = null;
	
	public CarDao() {
		super();
		em = factory.createEntityManager();
	}
	
	public void createCar(Car car) {
		em.getTransaction().begin();
		if(car != null && car.getStyleId() > 0) { 
			Car carForGivenId = em.find(Car.class,car.getStyleId());
			if(carForGivenId == null) {
				em.persist(car);
			} else {
				int hitCount = carForGivenId.getHitCount();
				hitCount+=1;
				carForGivenId.setHitCount(hitCount);
				em.merge(carForGivenId);
			}
			//Query query = em.createNamedQuery("Person.findAllPersons");
			//List<Make> makes = query.getResultList();
			em.getTransaction().commit();
//			/return persons;
		}
		
	}
	
	public Car findCar(long styleId) {
		em.getTransaction().begin();
		Car car = em.find(Car.class,styleId);
		em.getTransaction().commit();
		return car;
	}
	
	public List<Long> retrieveTopThreeForTrends() {
		
		em.getTransaction().begin();
	
		Query q = em.createNamedQuery("Car.retrieveStyleIdForTrends");
		 
		if(q.getResultList().size() < 3) {
			return q.getResultList();
		}
		Query q1 = em.createNamedQuery("Car.retrieveStyleIdForTrends");
		q1.setMaxResults(3);
		List<Long> styleIds = q1.getResultList();
		em.getTransaction().commit();
		return styleIds;
	}
	
	public void createYear(Years year) {
		em.getTransaction().begin();
		em.persist(year);
		em.getTransaction().commit();
	}
	
	public void createMake(Make make) {
		em.getTransaction().begin();
		em.persist(make);
		em.getTransaction().commit();
	}
	
	public void createModel(Model model) {
		em.getTransaction().begin();
		em.persist(model);
		em.getTransaction().commit();
	}
	
	public void createView(RecentView view) {
		em.getTransaction().begin();
		em.persist(view);
		em.getTransaction().commit();
	}
	
	public List<Long> retrieveViewsOfPersonById(int personId) {
		
		em.getTransaction().begin();
		Query q = em.createNamedQuery("RecentView.findCarsByPersonId");
		q.setParameter("personId", personId);
		List<Long> styleIds= q.getResultList();
		em.getTransaction().commit();
		return styleIds;
	}
	
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		PersonDao pdao = new PersonDao();
		
		Person person = new User();
		person.setFirstName("mani");
		person.setLastName("kandan");
		person.setUsername("rafa");
		person.setPassword("nadal");
		person.setEmailid("@gmail");
		
		pdao.createPerson(person);
		
		CarDao dao = new CarDao();
		
		Make make1 = new Make();
		make1.setMakeId(1);
		make1.setName("Make1 Name");
		make1.setNiceName("Make1 Nice Name");
		
		dao.createMake(make1);
		
		/*Make make2 = new Make();
		make2.setMakeId(2);
		make2.setName("Make2 Name");
		make2.setNiceName("Make2 Nice Name");*/
		
		Model model1 = new Model();
		//Model model2 = new Model();
		//Model model3 = new Model();
		
		
		
		//dao.createModel(model1);
		
		/*model2.setModelId(2);
		model2.setName("Model2 Name");
		model2.setMake(make2);
		
		model3.setModelId(3);
		model3.setName("Model3 Name");
		model3.setMake(make1);*/
		
		Years year1 = new Years();
		Years year2 = new Years();
		/*Years year3 = new Years();
		Years year4 = new Years();*/
		
		year1.setYear(2011);
		year2.setYear(2012);
		/*year3.setYears(2013);
		year4.setYears(2014);*/
		
		dao.createYear(year1);
		dao.createYear(year2);
		
		List<Years> yearList = new ArrayList<Years>();
		yearList.add(year1);
		yearList.add(year2);
		
		model1.setModelId("Model1");
		model1.setName("Model1 Name");
		model1.setMake(make1);
		model1.setYears(yearList);
		
		List<Model> modelList = new ArrayList<Model>();
		modelList.add(model1);
		
		year1.setModels(modelList);
		year2.setModels(modelList);
		
		dao.createModel(model1);
		
		/*MapModelYear map1 = new MapModelYear();
		map1.setModel(model1);
		map1.setYear(year1);
		
		MapModelYear map2 = new MapModelYear();
		map2.setModel(model1);
		map2.setYear(year2);
		
		List<MapModelYear> mapModelYearsList = new ArrayList<MapModelYear>();
		mapModelYearsList.add(map1);
		mapModelYearsList.add(map2);*/
		
		/*year1.setModels(mapModelYearsList);
		year2.setModels(mapModelYearsList);
		
		model1.setYears(mapModelYearsList);*/
		
		
		dao.createModel(model1);
		/*dao.createYear(year1);
		dao.createYear(year2);*/
		
		
		/*MapModelYear map3 = new MapModelYear();
		map3.setModel(model3);
		map3.setYear(year3);
		
		MapModelYear map4 = new MapModelYear();
		map4.setModel(model3);
		map4.setYear(year4);
		
		MapModelYear map5 = new MapModelYear();
		map5.setModel(model2);
		map5.setYear(year2);
		
		MapModelYear map6 = new MapModelYear();
		map6.setModel(model1);
		map6.setYear(year4);*/
		
		Car car1 = new Car();
		Car car2 = new Car();
		
		Car car3 = new Car();
		
		car1.setMake(make1);
		car1.setStyleId(1);
		car1.setModel(model1);
		car1.setYear(year2);
		
		car2.setMake(make1);
		car2.setStyleId(2);
		car2.setModel(model1);
		car2.setYear(year2);
		
		car3.setMake(make1);
		car3.setStyleId(3);
		car3.setModel(model1);
		car3.setYear(year1);
		
		List<Car> carList1 = new ArrayList<Car>();
		List<Car> carList2 = new ArrayList<Car>();
		List<Car> carList3 = new ArrayList<Car>();
		
		carList1.add(car3);
		carList2.add(car1);
		carList2.add(car2);
		carList2.add(car3);
	
		carList3.add(car1);
		carList3.add(car2);
		
		
		//make1.setCars(carList1);
		make1.setCars(carList2);
		model1.setCars(carList2);
		year1.setCars(carList1);
		year2.setCars(carList3);
		

		/*mapModelYearsList.add(map3);
		mapModelYearsList.add(map4);
		mapModelYearsList.add(map5);
		mapModelYearsList.add(map6);*/
		
/*		List<Years> yearList = new ArrayList<Years>();
		yearList.add(year1);
		yearList.add(year2);
		yearList.add(year3);
		yearList.add(year4);*/
		
	
	/*	year3.setModels(mapModelYearsList);
		year4.setModels(mapModelYearsList);*/
		
		
		/*model2.setYears(mapModelYearsList);
		model3.setYears(mapModelYearsList);*/
		
		List<Model> modelList1 = new ArrayList<Model>();
		modelList1.add(model1);
		//modelList1.add(model2);
		
		/*List<Model> modelList2 = new ArrayList<Model>();
		modelList2.add(model3);*/
		
		make1.setModels(modelList1);
//		/make2.setModels(modelList2);
		
		
		dao.createCar(car1);
		dao.createCar(car2);
		dao.createCar(car3);
		
		/*person.addCar(car1, true);
		person.addCar(car2, true);
		person.addCar(car3, true);*/
		
		RecentView view1 = new RecentView();
		RecentView view2 = new RecentView();
		
		view1.setHasLiked(true);
		view1.setSearchCar(car1);
		view1.setSearchPerson(person);
		
		view2.setHasLiked(false);
		view2.setSearchCar(car2);
		view2.setSearchPerson(person);
		
		List<RecentView> carsViewdByPerson = person.getViewCarList();
		if(carsViewdByPerson == null) {
			carsViewdByPerson = new ArrayList();
		}else {
			carsViewdByPerson = person.getViewCarList();
		}
		carsViewdByPerson.add(view1);
		person.setViewCarList(carsViewdByPerson);
		
		
		List<RecentView> personsViewedThisCar = car1.getViewPersonList();
		personsViewedThisCar = new ArrayList();
		personsViewedThisCar.add(view1);
		car1.setViewPersonList(personsViewedThisCar);
		
		dao.createView(view1);
		
		carsViewdByPerson = person.getViewCarList();
		carsViewdByPerson.add(view2);
		person.setViewCarList(carsViewdByPerson);
		
		List<RecentView> personsViewedSecondCar = car2.getViewPersonList();
		personsViewedSecondCar = new ArrayList();
		personsViewedSecondCar.add(view2);
		car2.setViewPersonList(personsViewedSecondCar);
		
		dao.createView(view2);
		System.out.println("**************************************************************");
		for (long styleId : dao.retrieveViewsOfPersonById(1)) {
			System.out.println(styleId);
		}
	}

}
