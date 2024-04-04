/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ohwrite.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.ohwrite.entities.Liked;
import com.ohwrite.entities.Post;
import com.ohwrite.entities.User;
import com.ohwrite.helper.FactoryProvider;

/**
 *
 * @author imrya
 */
public class LikeDao {

	private SessionFactory factory;
	Session ss;
	Transaction tx;

	public LikeDao(SessionFactory factory) {
		this.factory = factory;
	}

	public boolean insertLike(User uid, Post pid) {

		boolean f = false;
		try {
			ss = factory.openSession();
			tx = ss.beginTransaction();
			Liked like = new Liked(uid, pid);
			ss.save(like);
			tx.commit();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		ss.close();
		return f;
	}

	public int countLikeOnPost(Post p) {
		int c = 0;

		try {
			String hql = "SELECT COUNT(*) FROM Liked L WHERE L.pid = :post";

			ss = FactoryProvider.getFactory().openSession();
			tx = ss.beginTransaction();

			System.out.println(c);
			Query<Long> query = ss.createQuery(hql, Long.class);
			query.setParameter("post", p);
			Long count = query.uniqueResult();

			c = count.intValue();

			ss.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return c;
	}

	public boolean checkUserLike(Post post, User user) {
		boolean f = false;

		try {

			String hql = "SELECT COUNT(*) FROM Liked L WHERE L.pid = :post and L.uid=:user";

			ss = FactoryProvider.getFactory().openSession();
			tx = ss.beginTransaction();

			Query<Long> query = ss.createQuery(hql, Long.class);
			query.setParameter("post", post);
			query.setParameter("user", user);
			Long count = query.uniqueResult();

			if (count.intValue() > 0) {
				f = true;
			}

			ss.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public boolean deleteLike(Post post, User user) {

		boolean f = false;

		try {

			ss = FactoryProvider.getFactory().openSession();
			tx = ss.beginTransaction();

			String q = "delete Liked L WHERE L.pid = :post and L.uid=:user ";

			Query query = ss.createQuery(q);
			query.setParameter("post", post);
			query.setParameter("user", user);
			int count = query.executeUpdate();

			if (count > 0) {
				f = true;
			}

			ss.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

}