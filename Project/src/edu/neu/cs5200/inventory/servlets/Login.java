package edu.neu.cs5200.inventory.servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.neu.c5200.inventory.client.InventoryWebserviceClient;
import edu.neu.cs5200.inventory.dao.PersonDao;
import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.User;

@WebServlet(name = "login", urlPatterns = { "/login" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Hello Login Servlet");
		
		PersonDao dao = new PersonDao();
		InventoryWebserviceClient webserviceClient = InventoryWebserviceClient.getInstance();
		
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if(username.equalsIgnoreCase("admin") && password.equalsIgnoreCase("admin")) {  
			response.sendRedirect("/Project/admin");
		} else {
			
			Person person = new User();
			person.setUsername(username);
			person.setPassword(password);
			
			String passwordFetchedfromDB = dao.findPasswordForUserName(username);
			if (password.equalsIgnoreCase(passwordFetchedfromDB)) {
				HttpSession session = request.getSession();
	            session.setAttribute("user", username);
	            session.setMaxInactiveInterval(30*60);
	            Cookie userName = new Cookie("user", username);
	            userName.setMaxAge(30*60);
	            response.addCookie(userName);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
				dispatcher.forward(request, response);
				
				//response.sendRedirect("/Project/search");
			} else {
				response.sendRedirect("/Project/login");
			}
			
		}
			
			
		
	}	

}
