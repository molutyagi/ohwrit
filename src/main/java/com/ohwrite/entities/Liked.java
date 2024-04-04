package com.ohwrite.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "liked")
public class Liked {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(nullable = false)
	private int lid;

	@ManyToOne
	@JoinColumn(name = "uid")
	private User uid;

	@ManyToOne
	@JoinColumn(name = "pid")
	private Post pid;

	public Liked() {
		super();
	}

	public Liked(int lid, User uid, Post pid) {
		super();
		this.lid = lid;
		this.uid = uid;
		this.pid = pid;
	}

	public Liked(User uid, Post pid) {
		super();
		this.uid = uid;
		this.pid = pid;
	}

	public int getLid() {
		return lid;
	}

	public void setLid(int lid) {
		this.lid = lid;
	}

	public User getUid() {
		return uid;
	}

	public void setUid(User uid) {
		this.uid = uid;
	}

	public Post getPid() {
		return pid;
	}

	public void setPid(Post pid) {
		this.pid = pid;
	}

}
