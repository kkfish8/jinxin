/**   
 * 文件名：SecurityInterceptor.java
 *   
 * 版本信息：TODO
 * 日期：2015年7月9日
 * Copyright QiHang Corporation 2015 
 *   
 */
package com.jingxin.spring.springmvc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.jingxin.Tools.Const;
import com.jingxin.hibernate.dao.UserDAO;
import com.jingxin.hibernate.model.User;
import com.jingxin.spring.springmvc.controller.NoLoginController;

public class SecurityInterceptor implements HandlerInterceptor{

	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.HandlerInterceptor#afterCompletion(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, java.lang.Exception)
	 */
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.HandlerInterceptor#postHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object, org.springframework.web.servlet.ModelAndView)
	 */
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.HandlerInterceptor#preHandle(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Object)
	 */
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2) throws Exception {
		HttpSession session = arg0.getSession(true); 
		String username = (String) session.getAttribute(Const.USER_KEY);
		User user = new UserDAO().findByUserName(username);
		if(user != null && user.getType() != null && user.getType() <= 2) {

			arg0.setAttribute("loginedUser", user);
			return true;
		}
		arg1.sendRedirect("../loginpage.do");
		return false;
	}

	
	
}
