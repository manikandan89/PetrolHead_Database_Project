package edu.neu.cs5200.inventory.servlets;

import edu.neu.c5200.inventory.*;
import edu.neu.cs5200.inventory.dao.BaseDao;
import edu.neu.cs5200.inventory.dao.PersonDao;
import edu.neu.cs5200.inventory.jpa.Person;
import edu.neu.cs5200.inventory.jpa.User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "register", urlPatterns = { "/register" })
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Hello from register servlet");
		
		PersonDao dao = new PersonDao();
		
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String emailid = request.getParameter("emailid");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retypePassword = request.getParameter("retypepassword");
		
		Person person = new User();
		person.setFirstName(firstname);
		person.setLastName(lastname);
		person.setEmailid(emailid);
		person.setUsername(username);
		person.setPassword(password);
		
		if(!username.isEmpty() && !password.isEmpty() && password.equals(retypePassword)) {
			Person person2 = dao.findPersonByUsername(username);
			if (person2 == null) {
				dao.createPerson(person);
				response.sendRedirect("/Project/login.jsp");
			} else {
				response.sendRedirect("/Project/register.jsp");
			}
		
		} else {
			response.sendRedirect("/Project/register.jsp");
		}
		
		
		
		
	}

}
