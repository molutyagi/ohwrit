package com.ohwrite.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import java.util.Date;

@Entity
@Table(name = "user")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(nullable = false)
	private int id;

	@Column(columnDefinition = "varchar(100)", nullable = false)
	private String name;

	@Column(columnDefinition = "varchar(100)", nullable = false, unique = true)
	private String email;

	@Column(columnDefinition = "varchar(100)", nullable = false)
	private String password;

	@Column(columnDefinition = "varchar(10)", nullable = false)
	private String gender;

	@Column(columnDefinition = "longtext")
	private String about;

	private String profile = "default.png";

	@Temporal(value = TemporalType.TIMESTAMP)
	private Date rDate = new Date();

	@Column(columnDefinition = "varchar(100)")
	private String salt;

	public User(int id, String name, String email, String password, String gender, String about, Date rDate) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.about = about;
		this.rDate = rDate;
	}

	public User() {
	}

	public User(String name, String email, String password, String gender, String about, String salt) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.about = about;
		this.salt = salt;
	}

	public User(String name, String email, String password, String gender) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
	}

//    getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public Date getrDate() {
		return rDate;
	}

	public void setrDate(Date rDate) {
		this.rDate = rDate;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}
}