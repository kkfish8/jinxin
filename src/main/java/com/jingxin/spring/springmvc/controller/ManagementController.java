package com.jingxin.spring.springmvc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jingxin.Tools.Const;
import com.jingxin.hibernate.dao.FieldDAO;
import com.jingxin.hibernate.dao.UserDAO;
import com.jingxin.hibernate.model.Field;
import com.jingxin.hibernate.model.User;




@Controller
@RequestMapping(value="/admin")
public class ManagementController {

	
	@RequestMapping(value="/management.do")
	public String index(){
		return "management";
	}
	@RequestMapping(value="/management-userManage.do")
	public String userManage( ModelMap model){
		FieldDAO dao = new FieldDAO();
		List<Field> field = new ArrayList<>();
		field = dao.findAll();
		model.addAttribute("field", field);
		return "management-userManage";
	}

	@RequestMapping(value="/management-userGroupManage.do")
	public String userGroupManage(){
		return "management-userGroupManage";
	}
	
	@RequestMapping(value="/management-fieldManage.do")
	public String fieldManage(){
		return "management-fieldManage";
	}
	
	@RequestMapping(value="/management-expertManage.do")
	public String expertManage(){
		return "management-expertManage";
	}

	@RequestMapping(value="/management-extractRecord.do")
	public String extractRecord(ModelMap model){
		FieldDAO dao = new FieldDAO();
		List<Field> field = new ArrayList<>();
		field = dao.findAll();
		model.addAttribute("field", field);
		return "management-extractRecord";
	}
	
	@RequestMapping(value="/management-article.do")
	public String article(){
		return "management-article";
	}
	@RequestMapping(value="/management-index.do")
	public String m_index(){
		return "management-index";
	}
	
}
