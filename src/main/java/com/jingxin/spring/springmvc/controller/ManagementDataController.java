package com.jingxin.spring.springmvc.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.jingxin.Tools.Const;
import com.jingxin.Tools.MD5;
import com.jingxin.Tools.MyTools;
import com.jingxin.Tools.SendEmail;
import com.jingxin.hibernate.dao.ApplyDAO;
import com.jingxin.hibernate.dao.ArticleDAO;
import com.jingxin.hibernate.dao.FieldDAO;
import com.jingxin.hibernate.dao.RecordDAO;
import com.jingxin.hibernate.dao.SetupDAO;
import com.jingxin.hibernate.dao.UserDAO;
import com.jingxin.hibernate.model.Apply;
import com.jingxin.hibernate.model.Article;
import com.jingxin.hibernate.model.Field;
import com.jingxin.hibernate.model.Record;
import com.jingxin.hibernate.model.Setup;
import com.jingxin.hibernate.model.User;



@Controller
@RequestMapping(value="/admin", produces="text/plain;charset=UTF-8")
public class ManagementDataController {
	
	
	@RequestMapping(value="/management-userInfo.do")
	@ResponseBody
	public String userInfo(){
		SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		UserDAO dao = new UserDAO();
		List<User> list = dao.findAll();
		List<Map<String,Object>> listMap = new ArrayList<>();
		Map<String, Object> map;
		for(User i : list){
			map = new HashMap<>();
			map.put("id", i.getId());
			map.put("username", i.getUsername());
			map.put("truename", i.getName());
			map.put("email", i.getMail());
			String userType;
			int t = i.getType() == null ? 5 : i.getType();
			switch(t){
			case 0:
				userType = "超级管理员";
				break;
			case 1:
				userType = "系统管理员";
				break;
			case 2:
				userType = "管理员";
				break;
			case 3:
				userType = "首席专家";
				break;
			case 4:
				userType = "普通专家";
				break;
			default :
				userType = "普通用户";
				break;
			};
			map.put("type", userType);
			
			String blacklist;
			if(i.getIsBlack() != null && i.getIsBlack()){
				blacklist = "是";
			}else{
				blacklist = "否";		
			}
			map.put("blacklist", blacklist);
			map.put("sex", i.getSex());
			map.put("tel", i.getNumber());
			Field field = i.getField();
			if(field != null){
				map.put("field", field.getName());
			}
			
			map.put("participate", i.getParticipateNum());
			if(i.getContractDate() == null){
				map.put("contract", "0");
			}else{
				map.put("contract", DateFormat.format(i.getContractDate()));
			}
			map.put("absent", i.getAbsentNum());
			if(i.getLastLoginDate() == null){
				map.put("lastlogin", "0");
			}else{
				map.put("lastlogin", dateFormat.format(i.getLastLoginDate()));
			}
			listMap.add(map);
		}
		
		
		return JSON.toJSONString(listMap);
	}
	@RequestMapping(value="/management-addUser.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String addUser(HttpSession session,
			@RequestParam("username") String username,	//用户名
			@RequestParam("password") String password,					//密码
			@RequestParam("truename") String name,						//真实姓名
			@RequestParam("sex") String sex,							//性别
			@RequestParam("email") String email,	
			@RequestParam("tel") String tel,	
			@RequestParam("contract") String contract,	
			@RequestParam("field") String field,	
			@RequestParam("usertype") Integer type	){
			User user = new User();
			UserDAO userDao = new UserDAO();
			int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
			if( this_type >= 2 ){
				return "<script>alert('非法操作！');window.history.go(-1);</script>";
			}
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			FieldDAO fielddao = new FieldDAO();
			user.setUsername(username);
			user.setPassword(MD5.GetMD5Code(password));
			user.setName(name);
			user.setSex(sex);
			user.setMail(email);
			user.setNumber(tel);
			try {
				user.setContractDate(dateFormat.parse(contract));
			} catch (ParseException e) {
				e.printStackTrace();
			}
//			user.setContractDate(contractDate);e(date);
			user.setType(type);
			List<Field> list = fielddao.findByName(field);
			Field newField = new Field();
			newField.setId(0);
			newField.setName("无");
			for(Field f : list){
					newField.setId(f.getId());
					newField.setName(f.getName());
			}
			user.setField(newField);
			user.setAbsentNum(0);
			user.setParticipateNum(0);
			UserDAO dao = new UserDAO();
			if(dao.isRepeat(username)){
				return "<script>alert('用户名已存在！');window.history.go(-1);</script>";
			}
			if(dao.save(user)){
				return "<script>alert('注册成功！');location.href='management-userManage.do';</script>";
			}else{
				return "<script>alert('注册失败！');location.href='management-userManage.do';</script>";
			}
		}
	
	@RequestMapping(value="/management-editUser.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String editUser(HttpSession session,
			@RequestParam("IDArray") String idArrStr,	//id Arr
			@RequestParam(value = "editpass", required = false) String password,			//密码
			@RequestParam(value = "editrepass", required = false) String repass,			//密码
			@RequestParam(value = "edittruename", required = false) String name,						//真实姓名
			@RequestParam(value = "editsex", required = false) String sex,						//性别
			@RequestParam(value = "editeamil", required = false) String email,	
			@RequestParam(value = "editblack", required = false) String black,	
			@RequestParam(value = "edittel", required = false) String tel,	
			@RequestParam(value = "editcontract", required = false) String contract,	
			@RequestParam(value = "editfield", required = false) String field,	
			@RequestParam(value = "edittype", required = false) String type	){
		@SuppressWarnings("unchecked")
		List<Integer> idArr = (List<Integer>) JSON.parse(idArrStr);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		FieldDAO fielddao = new FieldDAO();
		User user = new User();
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		int this_id = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getId();
		for(int id : idArr){
			if(id == 1 && this_id != 1 ){
				return "<script>alert('您没有权限修改超级管理员！');window.history.go(-1);</script>";
			}
		}
		if(password != null){
			if(!password.isEmpty()){
				if(password.length() < 5 && password.length() > 16){
					return "<script>alert('密码必须在6-16位之间！');window.history.go(-1);</script>";
				}else{
					if(password.equals(repass)){
						return "<script>alert('两次密码不一致！');window.history.go(-1);</script>";
					}
				}
				user.setPassword(MD5.GetMD5Code(password));
			}
		}
		if(name != null){
			if(!name.isEmpty()){
				user.setName(name);
			}
		}
		if(sex != null){
			if(!sex.isEmpty()){
				user.setSex(sex);
			}
		}
		if(email != null){
			if(!email.isEmpty()){
				user.setMail(email);
			}
		}
		if(tel != null){
			if(!tel.isEmpty()){
				user.setNumber(tel);
			}
		}
		if(contract != null){
			if(!contract.isEmpty()){
				try {
				user.setContractDate(dateFormat.parse(contract));
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		if(type != null){
			if(!type.isEmpty()){
				int edittype = 5;
				if(type.equals("超级管理员")){
					edittype = 0;
				}
				if(type.equals("系统管理员")){
					edittype = 1;
				}
				if(type.equals("管理员")){
					edittype = 2;
				}
				if(type.equals("首席专家")){
					edittype = 3;
				}
				if(type.equals("普通专家")){
					edittype = 4;
				}
				if(type.equals("普通用户")){
					edittype = 5;
				}
				user.setType(edittype);
			}
		}
		if(black != null){
			if(!black.isEmpty()){
				boolean blacklist;
				if(black.equals("是")){
					blacklist = true;
				}else{
					blacklist = false;
				}
				user.setIsBlack(blacklist);
			}
		}
		if(field != null){
			if(!field.isEmpty()){
				List<Field> list = fielddao.findByName(field);
				Field newField = new Field();
				newField.setId(0);
				newField.setName("无");
				for(Field f : list){
					newField.setId(f.getId());
					newField.setName(f.getName());
				}
				user.setField(newField);
			}
		}
		if(userDao.UpdateByBatch(idArr, user)){
			return "<script>alert('更改成功！');location.href='management-userManage.do';</script>";
		}else{
			return "<script>alert('更改失败！');location.href='management-userManage.do';</script>";
		}
	}

	@RequestMapping(value="/deleteUser.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String deleteUser(HttpSession session,
			@RequestParam("IDArray") String idArrStr){
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		@SuppressWarnings("unchecked")
		List<Integer> idArr = (List<Integer>) JSON.parse(idArrStr);
		for(int id : idArr){
			if(id == 1){
				return "ID";
			}
		}
		for(int id : idArr){
			ApplyDAO dao = new ApplyDAO();
			Apply apply = dao.findById(id);
			if(apply.getInchPhoto() != null ){
				File file = new File(apply.getInchPhoto());
				file.delete();
			}
			if(apply.getDeclarationPath() != null ){
				File file = new File(apply.getDeclarationPath());
				file.delete();
			}
			if(apply.getEducationPath() != null ){
				File file = new File(apply.getEducationPath());
				file.delete();
			}
			if(apply.getProfessionalPath() != null ){
				File file = new File(apply.getProfessionalPath());
				file.delete();
			}
		}
		UserDAO dao = new UserDAO();
		if(dao.deleteByIdArr(idArr)){
			return "OK";
		}else{
			return "ERO";
		}

	}

	@RequestMapping(value="/logout.do", produces="text/plain;charset=UTF-8")
	public String logout(HttpSession session){		
		session.removeAttribute(Const.USER_KEY);
		return "redirect:../index.do";
	}
	
	@RequestMapping(value="/expertManage.do")
	@ResponseBody
	public String expertManage(){
		
		HashMap<String,Object> map;
		ApplyDAO apply = new ApplyDAO();
		List<HashMap<String, Object>> listmap = new ArrayList<>();
		List<Apply> list = apply.findAll();
		for(Apply app : list){
			map = new HashMap<>();
			map.put("academicdegree",app.getAcademicDegree());
			map.put("brithday", app.getBrithday());
			map.put("class", app.getClass());
			map.put("declarationPath", app.getDeclarationPath());
			map.put("department", app.getDepartment());
			map.put("education", app.getEducation());
			map.put("educationPath", app.getEducationPath());
			map.put("familiarField", app.getFamiliarField());
			map.put("field",app.getField());
			map.put("fixedTelephone", app.getFixedTelephone());
			map.put("graduateSchool", app.getGraduateSchool());
			map.put("id", app.getId());
			map.put("idcard", app.getIdCard());
			map.put("inchPhoto", app.getInchPhoto());
			if(app.getIsPass() == null){
				map.put("ispass","未通过");
			}else if(app.getIsPass() == 1){
				map.put("ispass","已通过");
			}else{
				map.put("ispass","未通过");
			}
			map.put("jobresume", app.getJobResume());
			map.put("mail", app.getMail());
			map.put("mailingaddress", app.getMailingAddress());
			map.put("major", app.getMajor());
			map.put("name", app.getName());
			map.put("nation", app.getNation());
			map.put("note", app.getNote());
			map.put("nowmajor", app.getNowMajor());
			map.put("onlyproperty", app.getOnlyProperty());
			map.put("phonenumber", app.getPhoneNumber());
			map.put("politicalstatus", app.getPoliticalStatus());
			map.put("professionalpath", app.getProfessionalPath());
			map.put("publishedMonograph", app.getPublishedMonograph());
			map.put("publishedpapers",app.getPublishedPapers());
			map.put("researchproject", app.getResearchProject());
			map.put("sciencetechnology", app.getScienceTechnology());
			map.put("sex", app.getSex());
			if(app.getUser() != null) {
				map.put("user", app.getUser().getUsername());
				if(app.getUser().getIsBlack() == null){
					map.put("blacklist", "未加黑");
				}else if(app.getUser().getIsBlack() == true){
					map.put("blacklist", "加黑");
				}else{
					map.put("blacklist", "未加黑");
				}
			}
			map.put("workaddress", app.getWorkAddress());
			map.put("workduties", app.getWorkDuties());
			map.put("workname", app.getWorkName());
			map.put("worktitle", app.getWorkTitle());
			map.put("worktype", app.getWorkType());
			listmap.add(map);
		}
		return JSON.toJSONString(listmap);
	}



	@RequestMapping(value="/pass.do")
	@ResponseBody
	public String pass(HttpSession session,
			@RequestParam("id") Integer id,
			@RequestParam("mail") String mail,
			@RequestParam("user") String username
			){
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		ApplyDAO app = new ApplyDAO();
		UserDAO user = new UserDAO();
		String getHost = MyTools.getHost();
		String href = getHost+"index.do";
		String str  = "您好：<br>"
				+ "这封信是由 广元经信 发送的。<br><font color='red'>您已经通过广元经信的专家认证</font><br>"
				+ "您收到这封邮件，是由于在 广元经信 进行了专家认证，使用了这个邮箱地址。如果您并没你有访问过 广元经信，或没有进行上述操作，请忽略这封邮件。您不需要退订或进行其他进一步的操作。<br><br><br>"
				+ "----------------------------------------------------------------------<br>"
				+"<a href='" + href + "'>" + href + "</a><br>"
				+"(如果上面不是链接形式，请将该地址手工粘贴到浏览器地址栏再访问)<br><br>"
				+"感谢您的访问，祝您使用愉快！<br><br>"
				+"此致<br>"
				+"<a href='"+ getHost +"'>";
		User u = user.findById(id);
		if(u.getType() == 5 && app.updateIsPassById(id) != 0 && user.updateIsPassById(username) != 0){
			SendEmail s = new SendEmail(mail,str,"广元经信提醒您");
			s.start();
			return "通过审核";
		}else{
			return "未通过审核";
		}
	}
	
	@RequestMapping(value="/deleteapply.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteapply(HttpSession session,
			@RequestParam("IDArray") String idArrStr){
		List<Integer> idArr = (List<Integer>) JSON.parse(idArrStr);
		ApplyDAO dao = new ApplyDAO();
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		if(dao.deleteById(idArr)){
			return "OK";
		}else{
			return "ERO";
		}
		

	}
	@RequestMapping(value="/management-fielInfo.do")
	@ResponseBody
	public String fielInfo(){
		FieldDAO dao = new FieldDAO();
		List<Field> list = dao.findAll();
		List<Map<String,Object>> listMap = new ArrayList<>();
		Map<String, Object> map;
		for(Field i : list){
			if(i.getId() != 0){
				map = new HashMap<>();
				map.put("id", i.getId());
				map.put("name", i.getName());
				map.put("note", i.getNote());
				listMap.add(map);
			}
		}
		return JSON.toJSONString(listMap);
	}
	
	@RequestMapping(value="/management-addField.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String addField(HttpSession session,
		@RequestParam("name") String name,
		@RequestParam("note") String note){
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		Field field = new Field();
		field.setName(name);
		field.setNote(note);
		FieldDAO dao = new FieldDAO();
		List<Field> list = dao.findByName(name);
		Field newField = new Field();
		if(list != null){
			for(Field l : list){
				if(l.getId() != null)
				newField.setId(l.getId());
				if(l.getName() != null)
				newField.setName(l.getName());
			}
		}
		if(newField.getName() != null){
			return "<script>alert('此领域已存在！');window.history.go(-1);</script>";
		}
		if(dao.saveOrUpdate(field)){
			return "<script>alert('增加成功！');location.href='management-fieldManage.do';</script>";
		}else{
			return "<script>alert('增加失败！');location.href='management-fieldManage.do';</script>";
		}
	}
	@RequestMapping(value="/deleteField.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String deleteField(HttpSession session,
		@RequestParam("IDArray") String idArrStr){
		@SuppressWarnings("unchecked")
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		List<Integer> idArr = (List<Integer>) JSON.parse(idArrStr);
		FieldDAO dao = new FieldDAO();
		if(dao.deleteById(idArr)){
			return "OK";
		}else{
			return "ERO";
		}

	}
	@RequestMapping(value="/management-editField.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String editField(HttpSession session,
			@RequestParam("IDArray") String idArrStr,
			@RequestParam("editname") String name,
			@RequestParam("editnote") String note){
		FieldDAO dao = new FieldDAO();
		List<Field> list = dao.findByName(name);
		Field newField = new Field();
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		if(list != null){
			for(Field l : list){
				newField.setId(l.getId());
				newField.setName(l.getName());
			}
		}
		@SuppressWarnings("unchecked")
		List<Integer> idArr = (List<Integer>) JSON.parse(idArrStr);
		int id = 0;
		for(int i : idArr){
			id = i;
		}
		if(newField.getId() != null )
			if(id != newField.getId()){
				return "<script>alert('此领域已存在！');window.history.go(-1);</script>";
			}
		Field field = new Field();
		field.setId(id);
		field.setName(name);
		field.setNote(note);
		if(dao.saveOrUpdate(field)){
			return "<script>alert('修改成功！');location.href='management-fieldManage.do';</script>";
		}else{
			return "<script>alert('修改失败！');location.href='management-fieldManage.do';</script>";
		}
	}
	@RequestMapping(value="/adminarticle.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String adminarticle(){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HashMap<String,Object> map;
		ArticleDAO art = new ArticleDAO();
		List<HashMap<String, Object>> listmap = new ArrayList<>();
		List<Article> list = art.findAll(0,100 );
		for(Article app : list){
			map = new HashMap<String , Object>();
			map.put("id", app.getId());
			map.put("title", app.getTitle());
			String t = null;
			if(app.getType() == 2){
				t = "公告";
			}else if(app.getType() == 1){
				t = "新闻";
			}else if(app.getType() == 3){
				t = "资料";
			}
			map.put("type", t);
			map.put("content", app.getContent());
			if(app.getPublishDate() == null){
				map.put("publishdate", "0");
			}else{
				map.put("publishdate", dateFormat.format(app.getPublishDate()));
			}
			map.put("name", app.getUser().getUsername());
			listmap.add(map);
		}
		return JSON.toJSONString(listmap);
	}

	//发表文章
	@RequestMapping(value="/management-addArticle.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String addArticle(HttpSession session ,
			@RequestParam("type") String type,
			@RequestParam("title") String title,
			@RequestParam("content") String content){
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		ArticleDAO articleDao = new ArticleDAO();
		Article article = new Article();
		int t = 0 ;
		if(type.equals("公告")){
			t = 2;
		}else if(type.equals("新闻")){
			t = 1;
		}else if(type.equals("资料")){
			t = 3;
		}
			
		article.setType(t);														//类型
		article.setTitle(title);												//标题
		article.setContent(content);							//内容
		Date  date = new Date();
		article.setPublishDate(date);									//时间
		String username = (String) session.getAttribute(Const.USER_KEY);
		User user = userDao.findByUserName(username);
		if(user.getId() != null && user.getUsername() != null){
			User newUser = new User();
			newUser.setId(user.getId());
			newUser.setUsername(user.getUsername());
			article.setUser(newUser);
		}
		//初始化
		article.setClickCount(0);												//点击量
		article.setArticleOrder(0);													//排序
		if(articleDao.saveOrUpdate(article)){
			return "<script>alert('发表成功！');location.href='management-article.do';</script>";
		}else{
			return "<script>alert('发表失败！');location.href='management-article.do';</script>";
		}
	}
	
	//management-updArticle.do
	@RequestMapping(value="/management-updArticle.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String updArticle(HttpSession session ,
			@RequestParam("editid") Integer id,
			@RequestParam("edittype") String type,
			@RequestParam("edittitle") String title,
			@RequestParam("editcontent") String content){
		UserDAO userDao = new UserDAO();
		String username = (String) session.getAttribute(Const.USER_KEY);
		User user = userDao.findByUserName(username);
		if(user == null || user.getType() == null){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		int this_type = user.getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		ArticleDAO articleDao = new ArticleDAO();
		Article article = articleDao.findById(id);
		int t = 0 ;
		if(type.equals("公告")){
			t = 2;
		}else if(type.equals("新闻")){
			t = 1;
		}else if(type.equals("资料")){
			t = 3;
		}
		article.setType(t);														//类型
		article.setTitle(title);												//标题
		article.setContent(content);							//内容
		if(articleDao.saveOrUpdate(article)){
			return "<script>alert('修改成功！');location.href='management-article.do';</script>";
		}else{
			return "<script>alert('修改失败！');location.href='management-article.do';</script>";
		}
	}
	
	//deleteArticle
	@RequestMapping(value="/deleteArticle.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String deleteArticle(HttpSession session,
			@RequestParam("IDArray") String idArrStr){
		@SuppressWarnings("unchecked")
		List<Integer> idArr = (List<Integer>) JSON.parse(idArrStr);
		ArticleDAO dao = new ArticleDAO();
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		if(dao.deleteByIdArr(idArr)){
			return "OK";
		}else{
			return "ERO";
		}
	}
	
	@RequestMapping(value="/article_content.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String article_content(@RequestParam("id") String id){
		ArticleDAO dao = new ArticleDAO();
		Article article = dao.findById(Integer.parseInt(id));
		return article.getContent();
	}
	//抽取专家
	@RequestMapping(value="/startExtract.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String startExtract(
			HttpSession session,
			@RequestParam("field") Integer field,
			@RequestParam("num") Integer num,
			@RequestParam("mark") String mark){
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		HashMap<String,Object> map;
		UserDAO dao = new UserDAO();
		List<HashMap<String, Object>> listmap = new ArrayList<>();
		List<User> list = dao.findByRandom(field, num);
		Calendar calendar = Calendar.getInstance();
		String date = calendar.get(Calendar.YEAR)+"-"+(calendar.get(Calendar.MONTH)+1)+"-"+calendar.get(Calendar.DAY_OF_MONTH);
		String getHost = MyTools.getHost();
		String href = getHost+"index.do";
		String str  =  "尊敬的用户您好：<br>"
				+ "这封信是由 广元经信 发送的。<br><font color='red'>您好，你被抽取为" + mark + "的专家，请登录官方网站查看</font><br>"
				+ "您收到这封邮件，是由于在 广元经信 进行了专家认证，或用户修改 Email 使用了这个邮箱地址。如果您并没你有访问过 广元经信，或没有进行上述操作，请忽略这封邮件。您不需要退订或进行其他进一步的操作。<br><br><br>"
				+ "----------------------------------------------------------------------<br>"
				+"帐号激活说明<br>"
				+"----------------------------------------------------------------------<br><br><br>"
				+"如果您是 广元经信 的新用户，或在修改您的注册 Email 时使用了本地址，我们需要对您的地址有效性进行验证以避免垃圾邮件或地址被滥用。<br><br>"
				+"您只需点击下面的链接：<br>"
				+"<a href='" + href + "'>" + href + "</a><br>"
				+"(如果上面不是链接形式，请将该地址手工粘贴到浏览器地址栏再访问)<br><br>"
				+"感谢您的访问，祝您使用愉快！<br><br>"
				+"此致<br>"
				+"<a href='"+ getHost +"'>";
		for(User user : list){
			String type = "";
			map = new HashMap<String , Object>();
			map.put("id", user.getId());
			map.put("userName", user.getUsername());
			if(!user.getApplies().isEmpty()){
				map.put("name", user.getApplies().iterator().next().getName());
			}
			
			map.put("field", user.getField().getName());
			if(user.getApplies().iterator().hasNext()){
				map.put("date", user.getApplies().iterator().next().getPhoneNumber());
			}
			if(user.getType()==3){
				type = "首席专家";
			}else{
				type = "普通专家";
			}
			map.put("type", type);
			listmap.add(map);
		}
		
		Set<User> set = new HashSet<>(list);
		for(User user:set){
			Iterator it = user.getApplies().iterator();
			if(it.hasNext()){
				Apply apply = (Apply) it.next();
				SendEmail s = new SendEmail(apply.getMail(),str,"广元经信提醒您");
				s.start();
			}
		}
		
		UserDAO userDAO = new UserDAO();
		User user = userDAO.findByUserName((String)session.getAttribute(Const.USER_KEY));
		Record record = new Record();
		record.setUsers(set);
		record.setUser(user);
		record.setField(new FieldDAO().findById(field));
		record.setRecordDate(new Date());
		
		
		record.setNote(mark);
		RecordDAO recordDAO = new RecordDAO();
		if(recordDAO.saveOrUpdate(record)){
			System.out.println("保存成功");
		}else{
			System.out.println("保存失败");
		}
		return JSON.toJSONString(listmap);
	}
	
	//获取记录表数据
	@RequestMapping(value="/getExtractRecord.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String getExtractRecord(){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		HashMap<String,Object> map;
		List<HashMap<String, Object>> listmap = new ArrayList<>();
		RecordDAO dao = new RecordDAO();
		List<Record> list = dao.findAll();
		for(Record rec : list){
			map = new HashMap<String , Object>();
			map.put("id", rec.getId());
			map.put("extractPeople", rec.getUser().getUsername());
			map.put("extractDate", dateFormat.format(rec.getRecordDate()));
			map.put("extractField", rec.getField().getName());
			map.put("extractRemarks", rec.getNote());
			listmap.add(map);
		}
		return JSON.toJSONString(listmap);
	}
	//获取详情数据
	@RequestMapping(value="/ExtractInfo.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String ExtractInfo(@RequestParam("id") String id){
		HashMap<String,Object> map;
		SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy-MM-dd");
		List<HashMap<String, Object>> listmap = new ArrayList<>();
		RecordDAO dao = new RecordDAO();
		Record record = dao.findById(Integer.parseInt(id));
		Set<User> list = record.getUsers();
		System.out.println("-->"+list.size());
		for(User u:list){
			map = new HashMap<String , Object>();
			map.put("id", u.getId());
			map.put("userName", u.getUsername());
			map.put("name", u.getName());
			map.put("field", u.getField().getName());
			if(record.getUser().getApplies().iterator().hasNext()){
				map.put("date", record.getUser().getApplies().iterator().next().getPhoneNumber());
			}
			listmap.add(map);
		}
		return JSON.toJSONString(listmap);
	}
	//删除记录表数据
	@RequestMapping(value="/deleteRecord.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String deleteRecord(HttpSession session,
		@RequestParam("IDArray") String idArrStr){
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		@SuppressWarnings("unchecked")
		List<Integer> idArr = (List<Integer>) JSON.parse(idArrStr);
		RecordDAO dao = new RecordDAO();
		if(dao.deleteByBatch(idArr)){
			return "OK";
		}else{
			return "ERO";
		}
	}
	
	@RequestMapping(value="/setindex.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String setindex(){
		HashMap<String,Object> map;
		List<HashMap<String, Object>> listmap = new ArrayList<>();
		SetupDAO setup = new SetupDAO();
		List<Setup> list = setup.findAll();
		for(Setup u:list){
			map = new HashMap<String , Object>();
			map.put("name", u.getName());
			map.put("value", u.getValue());
			listmap.add(map);
		}
		return JSON.toJSONString(listmap);
	}
	
	@RequestMapping(value="/set.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String set(HttpSession session,
			@RequestParam("value") String value){
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		SetupDAO setup = new SetupDAO();
		Setup s = new Setup();
		s.setName("title");
		s.setValue(value);
		if(setup.update(s)){
			return "修改成功";
		}else{
			return "修改失败";
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
	private String saveFile(MultipartFile file, String paramName, String path, String username,String rand){
		String of = file.getOriginalFilename();
		String Suffix = of.substring(of.lastIndexOf(".")+1, of.length());
		
        String newFilename = username + "_"+ rand + "_" + paramName + "." + Suffix;
        
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
	
	@RequestMapping(value="/Update_Index.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String Update_Index(@RequestParam(value="key") String key,@RequestParam(value = "fileupload") MultipartFile files,HttpSession session, HttpServletRequest request){
		String username = (String)session.getAttribute(Const.USER_KEY);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String webappPath = Const.UPLOAD_SAVE_PATH + "/" + dateFormat.format(new Date()) + Const.APPLY_IMG_SAVE_PATH;
        String path = request.getSession().getServletContext().getRealPath(webappPath);
        String of2 = files.getOriginalFilename();
        String rand = Math.random()*100+"";
		String Suffix2 = of2.substring(of2.lastIndexOf(".")+1, of2.length());
        String newFilename2 = webappPath+"/"+username +"_"+ rand +"_fileupload" + "." + Suffix2;//新路径
        SetupDAO s = new SetupDAO();
      String p = s.findByKey(key);
      File f = new File("../"+p);
      f.delete();
      String str = saveFile(files,"fileupload", path, username,rand);
      Setup sss = new Setup();
      sss.setName(key);
      sss.setValue(newFilename2.substring(1));
      s.update(sss);
      if(str==null)
    	  return "<script>alert('上传成功');document.location.href='management-index.do';</script>";
      else
    	  return "<script>alert('上传失败');document.location.href='management-index.do';</script>";
	}

	//删除记录表数据
	@RequestMapping(value="/title.do", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String title(HttpSession session){
		UserDAO userDao = new UserDAO();
		int this_type = userDao.findByUserName((String) session.getAttribute(Const.USER_KEY)).getType();
		if( this_type >= 2 ){
			return "<script>alert('非法操作！');window.history.go(-1);</script>";
		}
		SetupDAO dao = new SetupDAO();
		try {
			return dao.findByKey("title");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
