package com.will.fashion.services;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.will.fashion.entity.model.Users;
import com.will.fashion.util.DateTimeUtil;
@Service
public class userService {
	@Autowired
	@Qualifier("mongoTemplate")
	private MongoTemplate mongoTemplate;
	
	//用户保存
	public void saveUsers(Users users) throws Exception {
		mongoTemplate.save(users);
	}
	
	//用户登录
	public Users queryLogin(String loginName,String password) {
		Criteria criteria = new Criteria();
		criteria.and("loginName").is(loginName);
		criteria.and("password").is(password);
		Query query = new Query(criteria);
		return mongoTemplate.findOne(query, Users.class,"users");
	}
	
	//用户列表
	public List<Users> usersQuery(int pageIndex,int pageSize,String userName,String email,String roles,
								String status,String startDate,String endDate){
		List<Users> userList = null;
		Criteria criteria = new Criteria();
		if (!StringUtils.isEmpty(userName.trim())) {
			criteria.and("userName").regex(userName);
		}
		if (!StringUtils.isEmpty(email.trim())) {
			criteria.and("email").regex(email);
		}
		if (!StringUtils.isEmpty(roles.trim())) {
			
			criteria.and("roles").is(roles);
		}
		if (!StringUtils.isEmpty(status.trim())) {
			criteria.and("status").is(status);
		}
		if (!StringUtils.isEmpty(startDate.trim())&&!StringUtils.isEmpty(endDate.trim())) {
			criteria.and("updateTime").gte(DateTimeUtil.StringToLong(startDate)).lte(DateTimeUtil.StringToLong(endDate));
		}
		Query query = new Query();
		query.addCriteria(criteria);
		query.skip(pageIndex);  
        query.limit(pageSize);
		try {
			userList = mongoTemplate.find(query, Users.class);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return userList;
	}
	
	//用户总数
	public int usersTotal(String userName,String email,String roles,String status,String startDate,String endDate){
		int userTotal = 0;
		Criteria criteria = new Criteria();
		if (!StringUtils.isEmpty(userName.trim())) {
			criteria.and("userName").regex(userName);
		}
		if (!StringUtils.isEmpty(email.trim())) {
			criteria.and("email").regex(email);
		}
		if (!StringUtils.isEmpty(roles.trim())) {
			
			criteria.and("roles").is(roles);
		}
		if (!StringUtils.isEmpty(status.trim())) {
			criteria.and("status").is(status);
		}
		if (!StringUtils.isEmpty(startDate.trim())&&!StringUtils.isEmpty(endDate.trim())) {
			criteria.and("updateTime").gte(DateTimeUtil.StringToLong(startDate)).lte(DateTimeUtil.StringToLong(endDate));
		}
		Query query = new Query(criteria);		
		try {
			userTotal = mongoTemplate.find(query, Users.class).size();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return userTotal;
	}
	
	public String dateLongToString(String date_long) {
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date(date_long);
		return sdf.format(date);
	}
	
}
