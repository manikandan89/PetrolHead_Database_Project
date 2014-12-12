package edu.neu.c5200.inventory.client;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import edu.neu.cs5200.inventory.dao.CarDao;
import edu.neu.cs5200.inventory.dao.MakeDao;
import edu.neu.cs5200.inventory.dao.ModelDao;
import edu.neu.cs5200.inventory.dao.PersonDao;
import edu.neu.cs5200.inventory.dao.RatingDao;
import edu.neu.cs5200.inventory.dao.ViewDao;
import edu.neu.cs5200.inventory.dao.YearDao;
import edu.neu.cs5200.inventory.jpa.Car;
import edu.neu.cs5200.inventory.jpa.Make;
import edu.neu.cs5200.inventory.jpa.Model;
import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.RecentView;
import edu.neu.cs5200.inventory.jpa.Years;

public class InventoryWebserviceClient {
	
	private static InventoryWebserviceClient instance = null;
	protected InventoryWebserviceClient() {}
	public static InventoryWebserviceClient getInstance() {
		if(instance == null)
			instance = new InventoryWebserviceClient();
		return instance;
	}
	
	
	public void processMasterUrl(String url,String username) {
		
		MakeDao makeDao = new MakeDao();
		ModelDao modelDao = new ModelDao();
		YearDao yearDao = new YearDao();
		CarDao carDao = new CarDao();
		ViewDao viewDao = new ViewDao();
		RatingDao ratingDao = new RatingDao();
		PersonDao personDao = new PersonDao();
		
		Make make = new Make();
		Model model = new Model();
		Years year = new Years();
		Car car = new Car();
		RecentView view = new RecentView();
		RatingDao rate = new RatingDao();
		
		boolean isMake = false;
		boolean isModel = false;
		boolean isYear = false;
		boolean isCar = false;
		boolean isPresentInRecentList = false;
		
		try {
			URL urlModel = new URL(url);
			HttpURLConnection connection = (HttpURLConnection) urlModel.openConnection();
			connection.setRequestMethod("GET");
			InputStreamReader isr = new InputStreamReader(connection.getInputStream());
			BufferedReader br = new BufferedReader(isr);
			String inputLine;
			StringBuffer buffer = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				buffer.append(inputLine);
			}
			br.close();
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(buffer.toString());
			JSONObject makeJson = (JSONObject) obj.get("make");
			JSONObject modelJson = (JSONObject) obj.get("model");
			JSONObject yearJson = (JSONObject) obj.get("year");
			
			
			long makeId = (long) makeJson.get("id");
			String makeName = (String) makeJson.get("name");
			String makeNiceName = (String) makeJson.get("niceName");
			make.setMakeId(makeId);
			make.setName(makeName);
			make.setNiceName(makeNiceName);
			if (makeDao.findMake(makeId) == null) {
				makeDao.createMake(make);
				isMake = true;
			}
			
			long yearId = (long) yearJson.get("year");
			System.out.println(yearId);
			year.setYear(yearId);
			if(yearDao.findYear(yearId) == null) {
				yearDao.createYear(year);
				isYear = true;
			}
			
			String modelId = (String) modelJson.get("id");
			String name = (String)modelJson.get("name");
			String niceName = (String) modelJson.get("niceName");
			model.setModelId(modelId);
			model.setName(makeName);
			model.setNiceName(niceName);
			model.setMake(make);
			if(modelDao.findModel(modelId) == null) {
				List<Years> yearList = model.getYears();
				if(yearList == null) {
					yearList = new ArrayList<Years>();
				}
				yearList.add(year);
				model.setYears(yearList);
				List<Model> modelList = year.getModels();
				if(modelList == null) {
					modelList = new ArrayList<Model>();
				}
				modelList.add(model);
				year.setModels(modelList);
				modelDao.createModel(model);
				isModel = true;
			}
			
			
			long styleId = (Long)obj.get("id");
			String styleName = (String)obj.get("name");
			car.setStyleId(styleId);
			car.setName(styleName);
			car.setMake(make);
			car.setModel(model);
			car.setYear(year);
			if(carDao.findCar(styleId) == null) {
				carDao.createCar(car);
				isCar = true;
			}
			
			int personId = personDao.findPersonIdByUsername(username);
			Person person = personDao.findPersonByUsername(username);
				view.setSearchPerson(person);
				view.setSearchCar(car);
				//viewDao.createView(view);
		
			
		
			
			List<RecentView> carList = person.getViewCarList(); 
			if(carList == null) {
				carList = new ArrayList<RecentView>();
				carList.add(view);
				person.setViewCarList(carList);
			} else {
				for (RecentView view2 : carList) {
					if (view2.getSearchPerson().getPersonId() == personId && 
							view2.getSearchCar().getStyleId() == styleId) {
						isPresentInRecentList = true;
						break;
					}
				}
				if (!isPresentInRecentList) {
					if(carList.size() >= 3) {
						carList.remove(0);
					}
					carList.add(view);
					person.setViewCarList(carList);
				}
			}
			
			List<RecentView> personList = car.getViewPersonList();
			if(personList == null) {
				personList = new ArrayList<RecentView>();
				personList.add(view);
				car.setViewPersonList(personList);
			}else {
				for (RecentView view2 : personList) {
					if (view2.getSearchPerson().getPersonId() == personId && 
							view2.getSearchCar().getStyleId() == styleId) {
						isPresentInRecentList = true;
						break;
					}
				}
				if (!isPresentInRecentList) {
					if(personList.size() >= 3) {
						personList.remove(0);
					}
					personList.add(view);
					car.setViewPersonList(personList);
				}
			}
			//List<RecentView> tempList = 
			if(viewDao.retrieveViewsOfPersonAndCar(personId, styleId).size() < 1) {
				System.out.println("Inserting into views");
				viewDao.createView(view);
			}
			System.out.println(styleId + "::" + styleName + "::" );
		}catch (IOException | ParseException e) {
			e.printStackTrace();
		}
		return;
	}

	public static void main(String args[]) {
		//InventoryWebserviceClient inv = InventoryWebserviceClient.getInstance();
		//inv.processMasterUrl("https://api.edmunds.com/api/vehicle/v2/styles/101353967?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep&view=full");
	}
}
