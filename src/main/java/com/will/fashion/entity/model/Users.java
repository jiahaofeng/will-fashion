package com.will.fashion.entity.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import com.will.fashion.entity.domin.UserInfo;

@Document(collection = "Will_Users")
public class Users {
	@Id
	private String id;
	private String userName;
	private String password;
	private String email;
	private String status; //0禁用，1启用
	private String roles; //1管理员，2普通用户
	private UserInfo userInfo;
	private Long createTime;
	private Long updateTime;
	private Long lastloginTime;
	
	public Users() {
		super();
	}

	public Users(String id, String userName, String password, String email,
			String status, String roles, Long createTime, Long updateTime,
			Long lastloginTime) {
		super();
		this.id = id;
		this.userName = userName;
		this.password = password;
		this.email = email;
		this.status = status;
		this.roles = roles;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.lastloginTime = lastloginTime;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRoles() {
		return roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public Long getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Long updateTime) {
		this.updateTime = updateTime;
	}

	public Long getLastloginTime() {
		return lastloginTime;
	}

	public void setLastloginTime(Long lastloginTime) {
		this.lastloginTime = lastloginTime;
	}
	
	
}
