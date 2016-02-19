/**
 * 
 */
/**
 * @author jiahaofeng
 *
 */
package com.testbase.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
@Document(collection = "testBase")
public class TestBase{
	@Id
	private String id;
	private String userName;
	private String pwd;
	private int age;
	
	
	
	public TestBase() {
		super();
	}

	public TestBase(String id, String userName, String pwd, int age) {
		super();
		this.id = id;
		this.userName = userName;
		this.pwd = pwd;
		this.age = age;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	
	
}