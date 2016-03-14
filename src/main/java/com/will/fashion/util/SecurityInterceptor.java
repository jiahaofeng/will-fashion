package com.will.fashion.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.catalina.util.RequestUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.will.fashion.entity.model.WillUsers;
import com.will.fashion.services.userService;

public class SecurityInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private userService userservice;
	private final Logger log = LoggerFactory.getLogger(SecurityInterceptor.class);  
    public static final String LAST_PAGE = "com.alibaba.lastPage";  
	/**  
     * 在业务处理器处理请求之前被调用  
     * 如果返回false  
     *     从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链 
     * 如果返回true  
     *    执行下一个拦截器,直到所有的拦截器都执行完毕  
     *    再执行被拦截的Controller  
     *    然后进入拦截器链,  
     *    从最后一个拦截器往回执行所有的postHandle()  
     *    接着再从最后一个拦截器往回执行所有的afterCompletion()  
     */   
	 @Override    
    public boolean preHandle(HttpServletRequest request,    
            HttpServletResponse response, Object handler) throws Exception {    
        /*if ("GET".equalsIgnoreCase(request.getMethod())) {  
            RequestUtil.saveRequest();  
        }*/  
        log.info("==============执行顺序: 1、preHandle================");    
        String requestUri = request.getRequestURI();  
        String contextPath = request.getContextPath();  
        String url = requestUri.substring(contextPath.length());  
        
        log.info("requestUri:"+requestUri);    
        log.info("contextPath:"+contextPath);    
        log.info("url:"+url);    
          
        String username =  request.getSession().getAttribute("userName")==null?null:request.getSession().getAttribute("userName").toString();   
        if(username == null){ 
        	log.info("Interceptor：跳转到login页面！");
            if(isAjaxRequest(request)){      	 
//            	response.setCharacterEncoding("UTF-8");  
//                response.sendError(HttpStatus.UNAUTHORIZED.value(), "您已经太长时间没有操作,请刷新页面");  
//            	response.setCharacterEncoding("UTF-8");
//				response.setContentType("text/html");
//				response.setHeader("Cache-Control", "no-cache");

//				response.getWriter().write("<script type=\"text/javascript\">window.location.href = '${path}/views/index.jsp'</script>");
            	JSONObject jsObject = new JSONObject();
            	jsObject.put("status", "404");//未登录
            	jsObject.put("isLogin", false);
            	response.getWriter().write(jsObject.toString());
				response.getWriter().flush();
				response.getWriter().close();
            	return true;
			}else{
				response.sendRedirect(request.getContextPath()+"/views/login.jsp");
				return false;  
			}
            
        } else {
			boolean loginAuth = userservice.checkLoginName(username);
			if (!loginAuth) {
				if(isAjaxRequest(request)){
					JSONObject jsObject = new JSONObject();
	            	jsObject.put("status", "404");//未登录
	            	jsObject.put("isLogin", false);
	            	response.getWriter().write(jsObject.toString());
					response.getWriter().flush();
					response.getWriter().close();
	            	return true;
				}else {
					response.sendRedirect(request.getContextPath()+"/views/login.jsp");
					return false;
				}
			}
		}
        return true;    
    }  
	 /** 
     * 在业务处理器处理请求执行完成后,生成视图之前执行的动作    
     * 可在modelAndView中加入数据，比如当前时间 
     */  
    @Override    
    public void postHandle(HttpServletRequest request,    
            HttpServletResponse response, Object handler,    
            ModelAndView modelAndView) throws Exception {     
        log.info("==============执行顺序: 2、postHandle================");    
        if(modelAndView != null){  //加入当前时间    
            modelAndView.addObject("var", "测试postHandle");    
        }    
    }    
	    
    /**  
     * 在DispatcherServlet完全处理完请求后被调用,可用于清理资源等   
     *   
     * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion()  
     */    
    @Override    
    public void afterCompletion(HttpServletRequest request,    
            HttpServletResponse response, Object handler, Exception ex)    
            throws Exception {    
        log.info("==============执行顺序: 3、afterCompletion================");    
    }
    
    public static boolean isAjaxRequest(HttpServletRequest request)  
    {  
        String header = request.getHeader("X-Requested-With");   
        if (header != null && "XMLHttpRequest".equals(header))   
            return true;   
        else   
            return false;    
    } 
    
    
}
