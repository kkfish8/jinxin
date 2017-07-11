package com.jingxin.spring.springmvc.controller;
import java.applet.Applet;
import java.io.File;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.zip.DataFormatException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jingxin.Tools.Const;
import com.jingxin.hibernate.dao.ApplyDAO;
import com.jingxin.hibernate.dao.FieldDAO;
import com.jingxin.hibernate.dao.UserDAO;
import com.jingxin.hibernate.model.Apply;
import com.jingxin.hibernate.model.Field;
import com.jingxin.hibernate.model.User;
import com.mysql.fabric.xmlrpc.base.Data;


/**   
 * 文件名：OtherController.java
 *   
 * 版本信息：TODO
 * 日期：2015年7月11日
 * Copyright QiHang Corporation 2015 
 *   
 */
@Controller
@RequestMapping(value="/logined", produces="text/html;charset=UTF-8")
public class LoginedController {
	
	
	
	@RequestMapping(value="/userInfo.do")
	
	public String userInfo(HttpSession session,ModelMap model){
		UserDAO u = new UserDAO();
		
		User us = u.findByUserName((String)session.getAttribute(Const.USER_KEY));
		boolean isApply = u.isApply(us.getId());
		Set<Apply> apply = us.getApplies();
		
		if(!apply.isEmpty()){
			Iterator<Apply> it = apply.iterator();
			model.addAttribute("app", it.next());
		}
		model.addAttribute("us", us);
		model.addAttribute("isApply", isApply);
		return "userInfo";
	}
	
	@RequestMapping(value="/expert.do")
	public String expert(HttpSession session,ModelMap model){
		UserDAO u = new UserDAO();

		User us = u.findByUserName((String)session.getAttribute(Const.USER_KEY));
		
		boolean isApply = u.isApply(us.getId());
		Set<Apply> apply = us.getApplies();
		
		if(!apply.isEmpty()){
			Iterator<Apply> it = apply.iterator();
			model.addAttribute("app", it.next());
		}
		FieldDAO fieldDao = new FieldDAO();
		List<Field> fieldList = fieldDao.findAll();
		model.addAttribute("field", fieldList);
		model.addAttribute("us", us);
		model.addAttribute("isApply", isApply);
		return "expert";
	}
	
	
	@RequestMapping(value="/userDetailed.do")
	public String userDetailed(HttpSession session,ModelMap model){
		UserDAO u = new UserDAO();
		User us = u.findByUserName((String)session.getAttribute("user"));
		boolean isApply = u.isApply(us.getId());
		Set<Apply> apply = us.getApplies();
		
		if(!apply.isEmpty()){
			Iterator<Apply> it = apply.iterator();
			model.addAttribute("app", it.next());
		}
		model.addAttribute("us", us);
		model.addAttribute("isApply", isApply);
		return "userDetailed";
	}
	
	//文件上传
	@RequestMapping(value="/SaveApply.do")
	@ResponseBody
	public String SaveApply(HttpSession session, HttpServletRequest request,
			@RequestParam(value = "name") String name,
			@RequestParam(value = "sex") String sex,
			@RequestParam(value = "birthday") String birthday,
			@RequestParam(value = "number") String number,
			@RequestParam(value = "status") String status,
			@RequestParam(value = "unit") String unit,
			@RequestParam(value = "work") String work,
			@RequestParam(value = "department") String department,
			@RequestParam(value = "place") String place,
			@RequestParam(value = "duties") String duties,
			@RequestParam(value = "Title") String Title,
			@RequestParam(value = "address") String address,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "telephone") String telephone,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "Education") String Education,
			@RequestParam(value = "degree") String degree,
			@RequestParam(value = "major") String major,
			@RequestParam(value = "school") String school,
			@RequestParam(value = "Engaged") String Engaged,
			@RequestParam(value = "resume") String resume,
			@RequestParam(value = "field") String field,
			@RequestParam(value = "Provincial") String Provincial,
			@RequestParam(value = "paper") String paper,
			@RequestParam(value = "monograph") String monograph,
			@RequestParam(value = "technology") String technology,
			@RequestParam(value = "intellectual") String intellectual,
			@RequestParam(value = "project") String project,
			@RequestParam(value = "licencePhoto") MultipartFile licencePhoto,
			@RequestParam(value = "Titleup") MultipartFile Titleup,
			@RequestParam(value = "degreeup") MultipartFile degreeup
			
			){
		
		String username = (String)session.getAttribute(Const.USER_KEY);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		String webappPath = Const.UPLOAD_SAVE_PATH + "/" + dateFormat.format(new Date()) + Const.APPLY_IMG_SAVE_PATH;
        String path = request.getSession().getServletContext().getRealPath(webappPath);
        
        Apply apply = new Apply();
        apply.setName(name);
        apply.setSex(sex);
        try {
			apply.setBrithday(dateFormat.parse(birthday));
		} catch (ParseException e) {
			e.printStackTrace();
		}
        User user = new UserDAO().findByUserName(username);
        apply.setUser(user);
        apply.setIdCard(number);
        apply.setPoliticalStatus(status);
        apply.setWorkType(unit);
        apply.setWorkName(work);
        apply.setDepartment(department);
        apply.setWorkAddress(place);
        apply.setWorkDuties(duties);
        apply.setWorkTitle(Title);
        apply.setMailingAddress(address);
        apply.setPhoneNumber(phone);
        apply.setFixedTelephone(telephone);
        apply.setMail(email);
        apply.setEducation(Education);
        apply.setAcademicDegree(degree);
        apply.setMajor(major);
        apply.setGraduateSchool(school);
        apply.setNowMajor(Engaged);
        apply.setField(1);
        apply.setJobResume(resume);
        apply.setFamiliarField(field);
        apply.setResearchProject(Provincial);
        apply.setPublishedPapers(paper);
        apply.setPublishedMonograph(monograph);
        apply.setScienceTechnology(technology);
        apply.setOnlyProperty(intellectual);
        apply.setProjectDevelopment(project);
        //apply.setDeclarationPath(declarationPath);
        
		String of = licencePhoto.getOriginalFilename();
		String Suffix = of.substring(of.lastIndexOf(".")+1, of.length());
        String newFilename1 = username + "_licencePhoto" + "." + Suffix;
        apply.setInchPhoto(webappPath + "/" + newFilename1);
        

		String of2 = Titleup.getOriginalFilename();
		String Suffix2 = of2.substring(of2.lastIndexOf(".")+1, of2.length());
        String newFilename2 = username + "_Titleup" + "." + Suffix2;
        apply.setProfessionalPath(webappPath+"/"+ newFilename2);
        
        String of3 = degreeup.getOriginalFilename();
		String Suffix3 = of3.substring(of3.lastIndexOf(".")+1, of3.length());
        String newFilename3 = username + "_degreeup" + "." + Suffix3;
        apply.setEducationPath(webappPath +"/"+ newFilename3);
        
        
        
        
        String str = saveFile(licencePhoto, "licencePhoto", path, username);
        if(str != null){
    		return "<script>alert('提交成功。');window.location.href='userInfo.do';</script>";
        }
        String str2 = saveFile(Titleup, "Titleup", path, username);
        if(str2 != null){
    		return "<script>alert('" + str2 + "');window.location.href='userInfo.do';</script>";
        }
        String str3 = saveFile(degreeup, "degreeup", path, username);
        if(str3 != null){
    		return "<script>alert('" + str3 + "');window.location.href='userInfo.do';</script>";
        }

        ApplyDAO dao = new ApplyDAO();
        if(!dao.saveOrUpdate(apply)){
        	return "<script>alert('数据库错误。');window.location.href='userInfo.do';</script>";
        }else{
        	return "<script>alert('提交成功。');window.location.href='userInfo.do';</script>";
        }
  
		
	}
	
	
	/**   
	 * 保存文件到本地
	 * @author 范子才
	 * @param file 上传的文件
	 * @param paramName 文件参数name
	 * @param path 文件的保存绝对路径
	 * @param username 上传的用户名
	 * @return 返回null表示正确，其他则表示错误信息
	 * @version 2015年12月27日 下午6:22:07
	 */
	private String saveFile(MultipartFile file, String paramName, String path, String username){
		String of = file.getOriginalFilename();
		String Suffix = of.substring(of.lastIndexOf(".")+1, of.length());
		
        String newFilename = username + "_" + paramName + "." + Suffix;
        
        File dirFile = new File(path);  
        if(!dirFile.exists()){  
        	dirFile.mkdirs();  
        }  

		
		if((!"jpg".equalsIgnoreCase(Suffix)) && (!"jpeg".equalsIgnoreCase(Suffix)) && (!"gif".equalsIgnoreCase(Suffix)) && (!"png".equalsIgnoreCase(Suffix)) && (!"bmp".equalsIgnoreCase(Suffix))) {
			return "证件照请上传正确的格式";
		}
		
		
		File targetFile = new File(path, newFilename);
		
        //保存  
        try {  
            file.transferTo(targetFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
            return "服务器错误," + paramName + "保存失败。";
        }  
		return null;
	}
	
	//退出
	@RequestMapping(value="/logout.do", produces="text/plain;charset=UTF-8")
	public String logout(HttpSession session){		
		session.removeAttribute(Const.USER_KEY);
		return "redirect:../index.do";
	}
	
	@RequestMapping(value="/changeInfo.do")
	public String changeInfo(HttpSession session,ModelMap model){
		UserDAO u = new UserDAO();
		User user = u.findByUserName((String)session.getAttribute("user"));
		Set<Apply> apply = user.getApplies();
		
		if(!apply.isEmpty()){
			Iterator<Apply> it = apply.iterator();
			model.addAttribute("app", it.next());
		}
		model.addAttribute("us", user);
		boolean isApply = u.isApply(user.getId());
		model.addAttribute("isApply", isApply);
		return "changeInfo";
	}
	
	
	@RequestMapping(value="/UpdateInfo.do")
	@ResponseBody
	public String UpdateInfo(HttpSession session,@RequestParam("name") String name,@RequestParam("sex") String sex,@RequestParam("mail") String mail,@RequestParam("number") String number){
		
		UserDAO u = new UserDAO();
		User user = u.findByUserName((String)session.getAttribute("user"));
		user.setName(name);
		user.setMail(mail);
		user.setNumber(number);
		user.setSex(sex);
		boolean is = u.updateUser(user);
		if(is)
			return "ok";
		else
			return "no";
		
	}

	
}
