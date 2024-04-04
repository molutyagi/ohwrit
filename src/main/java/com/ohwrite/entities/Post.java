package com.ohwrite.entities;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "post")
public class Post {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(nullable = false)
	private int pid;

	@Column(columnDefinition = "varchar(500)", nullable = false)
	private String pTitle;

	@Column(columnDefinition = "longtext", nullable = false)
	private String pContent;

	@Column(columnDefinition = "longtext", nullable = false)
	private String pCode;

	@Column(columnDefinition = "varchar(100)", nullable = false)
	private String pPic;

	@Temporal(value = TemporalType.DATE)
	private Date pDate = new Date();

	@OneToOne
	@JoinColumn(name = "catId")
	private Category catId;

	@ManyToOne
	@JoinColumn(name = "authorId")
	private User authorId;

//	Constructors

	public Post() {
		super();
	}

	public Post(int pid, String pTitle, String pContent, String pCode, String pPic, Date pDate, Category catId,
			User authorId) {
		super();
		this.pid = pid;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.pDate = pDate;
		this.catId = catId;
		this.authorId = authorId;
	}

	public Post(String pTitle, String pContent, String pCode, String pPic, Category catId, User authorId) {
		super();
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pCode = pCode;
		this.pPic = pPic;
		this.catId = catId;
		this.authorId = authorId;
	}

//	getters and setters

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getpTitle() {
		return pTitle;
	}

	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}

	public String getpContent() {
		return pContent;
	}

	public void setpContent(String pContent) {
		this.pContent = pContent;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public String getpPic() {
		return pPic;
	}

	public void setpPic(String pPic) {
		this.pPic = pPic;
	}

	public Date getpDate() {
		return pDate;
	}

	public void setpDate(Date pDate) {
		this.pDate = pDate;
	}

	public Category getCatId() {
		return catId;
	}

	public void setCatId(Category catId) {
		this.catId = catId;
	}

	public User getAuthorId() {
		return authorId;
	}

	public void setAuthorId(User authorId) {
		this.authorId = authorId;
	}

}
