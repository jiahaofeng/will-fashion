package com.will.fashion.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.will.fashion.entity.model.WillUsers;
import com.will.fashion.services.userService;
import com.will.fashion.util.StringCommon;

@Controller
@RequestMapping("/users")
public class UserController {
	@Autowired
	private userService userservice;
	
	
	@RequestMapping(value = "/userList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object>  userList(@RequestParam String pageIndex,String pageSize,String userName,String email,String roles,
															String status,String startDate,String endDate){
		/*JSONObject data = new JSONObject();*/
		Map<String, Object> data = new HashMap<String, Object>();
		int limitIndex = (Integer.parseInt(pageIndex)-1)*Integer.parseInt(pageSize);
		
		int totalNum = userservice.usersTotal(StringCommon.StrFormat(userName),StringCommon.StrFormat(email),StringCommon.StrFormat(roles),StringCommon.StrFormat(status),
				StringCommon.StrFormat(startDate),StringCommon.StrFormat(endDate));
		
		List<WillUsers>userList = userservice.usersQuery(limitIndex,Integer.parseInt(pageSize),StringCommon.StrFormat(userName),
				StringCommon.StrFormat(email),StringCommon.StrFormat(roles),StringCommon.StrFormat(status),
				StringCommon.StrFormat(startDate),StringCommon.StrFormat(endDate));
		
		if (userList!=null) {
			for (int i = 0; i < userList.size(); i++) {
				if ("1".equals(userList.get(i).getRoles())) {
					userList.get(i).setRoles("管理员");
				}
				if ("2".equals(userList.get(i).getRoles())) {
					userList.get(i).setRoles("普通用户");
				}
				if ("0".equals(userList.get(i).getStatus())) {
					userList.get(i).setStatus("禁用");
				}
				if ("1".equals(userList.get(i).getStatus())) {
					userList.get(i).setStatus("活跃");
				}
				
			}
		}
		data.put("users", userList);
		data.put("totalNum", totalNum);
		return data;
	}
	
	/*
	 * 增加用户
	 * */
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public @ResponseBody ModelAndView userRegister(@RequestParam String userName,String pwd,String email,String status,String roles) {
		JSONObject result = new JSONObject();
		WillUsers users = new WillUsers();
		users.setUserName(userName.trim());
		users.setPassword(pwd.trim());
		users.setEmail(email.trim());
		users.setStatus(status.trim());
		users.setRoles(roles.trim());
		users.setCreateTime(System.currentTimeMillis());
		users.setUpdateTime(System.currentTimeMillis());
		try {
			userservice.saveUsers(users);
			result.put("message", "success");
		} catch (Exception e) {
			result.put("message", "fail");
			e.printStackTrace();
		}
		return new ModelAndView("User/UserList","result",result);
	}
	
	/*
	 * 用户登录
	 * */
	@RequestMapping(value = "/usersLogin", method = RequestMethod.POST)
	public @ResponseBody JSONObject usersLogin(HttpServletRequest request,@RequestParam String loginName,String loginPwd) {
		JSONObject result = new JSONObject();
		if (StringUtils.isEmpty(loginName)) {
			result.put("status", "0");
		}
		if (StringUtils.isEmpty(loginPwd)) {
			result.put("status", "0");
		}
		WillUsers users = userservice.queryLogin(loginName, loginPwd);
		if (users!=null) {
			result.put("status", "1");
			result.put("loginName", users.getUserName());
			result.put("roles", users.getRoles());
			HttpSession session = request.getSession();
			session.setAttribute("userName", users.getUserName());
			System.out.println(session);
		}else {
			result.put("status", "2");
		}
		return result;
	}
	
	/*
	 * 用户登录
	 * */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody void login() {
		System.out.println("djksdkdsd");
	}
}
