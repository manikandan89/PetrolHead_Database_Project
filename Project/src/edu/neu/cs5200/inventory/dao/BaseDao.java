package edu.neu.cs5200.inventory.dao;


public class BaseDao {

	private static BaseDao instance = null;
	
	protected BaseDao() { }
	
	public static BaseDao getInstance() {
		if (instance == null) {
			System.out.println("create new instance");
			instance = new BaseDao();
		} else {
			System.out.println("returning old");
		}
		
		return instance;
	}
}
