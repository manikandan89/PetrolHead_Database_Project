package edu.neu.cs5200.inventory.jpa;

import java.util.Date;

public class CommentDetail {

	private String comment;
	private Date date;
	private String username;
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
}
