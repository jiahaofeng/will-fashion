package com.will.fashion.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sendfax")
public class SendFaxController {
	@RequestMapping(value = "/addUser3")  
	public void add3(HttpServletRequest request,HttpServletResponse response) throws IOException{  
	    response.setContentType("application/json;charset=utf-8");  
	    PrintWriter out = response.getWriter();  
	    String str = "{username:'残缺的孤独',password:'admin123'}";  
	    out.write(str);  
	}  
}
