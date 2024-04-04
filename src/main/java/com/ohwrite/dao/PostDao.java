/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ohwrite.dao;

import com.ohwrite.entities.Category;
import com.ohwrite.entities.Post;
import com.ohwrite.helper.FactoryProvider;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class PostDao {

	SessionFactory factory;
	Session ss = null;
	Transaction tx = null;

	public PostDao(SessionFactory factory) {
		this.factory = factory;
	}

	public boolean savePost(Post p) {
		boolean f = false;

		try {
			ss = factory.openSession();
			tx = ss.beginTransaction();

			ss.save(p);
			tx.commit();

			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		ss.close();
		return f;
	}

	public List<Category> getAllCategories() {
		List<Category> list = new ArrayList<>();

		try {
			ss = factory.openSession();
			Query<Category> q = ss.createQuery("from Category");
			list = q.list();

		} catch (Exception e) {
			e.printStackTrace();
		}

		ss.close();
		return list;
	}

//    get all the posts
	public List<Post> getAllPosts() {

		List<Post> list = new ArrayList<>();

		try {
			ss = FactoryProvider.getFactory().openSession();
			Query q = ss.createQuery("from Post");
			list = q.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		ss.close();
		return list;
	}

	public List<Post> getPostByCat(Category cat) {
		List<Post> list = new ArrayList<>();

		try {
			ss = FactoryProvider.getFactory().openSession();
			Query q = ss.createQuery("from Post P where P.catId=:cat").setParameter("cat", cat);
			list = q.list();

			System.out.print(list);

		} catch (Exception e) {
			e.printStackTrace();
		}
		ss.close();
		return list;
	}

	public Post getPostByPostId(int postId) {
		Post p = null;
		try {

			ss = FactoryProvider.getFactory().openSession();
			p = (Post) ss.createQuery("from Post P where P.pid=:pid").setParameter("pid", postId).uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
		}
		ss.close();
		return p;
	}

	public Category getCatByCatId(int catid) {
		Category category = null;
		try {

			ss = FactoryProvider.getFactory().openSession();
			category = (Category) ss.createQuery("from Category C where C.cid=:cid").setParameter("cid", catid)
					.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
		}
		ss.close();
		return category;
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
