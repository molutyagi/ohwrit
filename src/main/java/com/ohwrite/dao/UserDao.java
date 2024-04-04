/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ohwrite.dao;

import com.ohwrite.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class UserDao {

	SessionFactory factory;
	Session ss = null;
	Transaction tx = null;

	public UserDao(SessionFactory factory) {
		this.factory = factory;
	}

	// method to insert user to data base:
	public boolean saveUser(User user) {
		boolean f = false;
		try {

			ss = factory.openSession();
			tx = ss.beginTransaction();

			ss.save(user);
			tx.commit();

			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		ss.close();
		return f;

	}

	public String debug(User user) {
		String s = "UserDao: " + user.getId() + ", " + user.getName() + ", " + user.getEmail() + ", "
				+ user.getPassword() + ", " + user.getAbout() + ", " + user.getGender() + ", " + user.getProfile() + "";

		return s;
	}

	// get user by useremail and userpassword:
	public User getUserByEmail(String email) {
		User user = null;

		try {
			ss = factory.openSession();
			tx = ss.beginTransaction();
			user = (User) ss.createQuery("from User U where U.email=:email").setParameter("email", email)
					.uniqueResult();
		}

		catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	public boolean updateUser(User user) {

		boolean f = false;
		try {

			ss = factory.openSession();
			tx = ss.beginTransaction();

			ss.update(user);
			tx.commit();

			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		ss.close();
		return f;
	}

	public User getUserByUserId(int userId) {
		User user = null;
		try {

			ss = factory.openSession();
			tx = ss.beginTransaction();
			user = (User) ss.createQuery("from User U where U.id=:id").setParameter("id", userId).uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	public void closeSession() {
		if (ss != null) {
			ss.close();
		}
	}

	public void txRollback() {
		if (tx != null) {
			tx.rollback();
		}
	}
}

//CREATE TABLE `techblog`.`user1` (
//  `id` INT NOT NULL AUTO_INCREMENT,
//  `name` VARCHAR(100) NOT NULL,
//  `email` VARCHAR(100) NOT NULL,
//  `password` VARCHAR(100) BINARY NULL,
//  `gender` VARCHAR(45) NULL,
//  `about` LONGTEXT NULL,
//  `profile` VARCHAR(100) NULL DEFAULT 'default.png',
//  `rdate` TIMESTAMP NULL DEFAULT now(),
//  PRIMARY KEY (`id`),
//  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
//  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);