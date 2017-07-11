package com.jingxin.spring.springmvc.controller;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.annotations.Parameter;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jingxin.Tools.Const;
import com.jingxin.Tools.MD5;
import com.jingxin.Tools.MyTools;
import com.jingxin.Tools.SendEmail;
import com.jingxin.hibernate.dao.ApplyDAO;
import com.jingxin.hibernate.dao.ArticleDAO;
import com.jingxin.hibernate.dao.FieldDAO;
import com.jingxin.hibernate.dao.SetupDAO;
import com.jingxin.hibernate.dao.UserDAO;
import com.jingxin.hibernate.model.Apply;
import com.jingxin.hibernate.model.Article;
import com.jingxin.hibernate.model.Field;
import com.jingxin.hibernate.model.User;



@Controller
public class NoLoginController {

	
	@RequestMapping(value="/index.do", produces="text/plain;charset=UTF-8")
	public String index(HttpSession session,ModelMap model) {
		ArticleDAO a = new ArticleDAO();
		SetupDAO s = new SetupDAO();
		List<Article> AllList = a.findAll(0, 7);
		//最新动态
		List<Article> newData1 = a.findNews(7);
		List<Article> newData2 = a.findNotice(7);
		List<Article> newData3 = a.findResource(7);

		model.addAttribute("allList", AllList);
		model.addAttribute("new1", newData1);
		model.addAttribute("new2", newData2);
		model.addAttribute("new3", newData3);
		model.addAttribute("title", s.findByKey("title"));
		System.out.println(s.findByKey("lunbo1"));
		model.addAttribute("lunbo1", s.findByKey("lunbo1"));
		model.addAttribute("lunbo2", s.findByKey("lunbo2"));
		model.addAttribute("lunbo3", s.findByKey("lunbo3"));
		return "index";
	}
	
	//文件浏览
		@RequestMapping(value="/article.do")
		public String article(@RequestParam("id") Integer id,ModelMap model){
			ArticleDAO a = new ArticleDAO();
			Article data = a.findById(id);
			String Content = data.getContent();
			System.out.println(Content);
			model.addAttribute("content",Content);
			model.addAttribute("data", data);
			return "article";
		}
	
	//前台登录页
	@RequestMapping(value="/loginpage.do")
	public String loginpage(HttpSession session) {
		if(session.getAttribute(Const.USER_KEY) != null){
			return "redirect:index.do";
		}
		return "login";
	}
	
	//登陆
	@RequestMapping(value="/login.do")
	@ResponseBody
	public String login(@RequestParam("userName") String username,
			@RequestParam("passWord") String password,
			@RequestParam("testCode") String code,
			HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		UserDAO dao = new UserDAO();
		if (!(code.equalsIgnoreCase(session.getAttribute("code").toString()))) {  //忽略验证码大小写
			map.put("code", false);
        }else {
        	map.put("code", true);
			if(dao.isRight(username, MD5.GetMD5Code(password))){
				map.put("testUser", true);
				User user = dao.findByUserName(username);
				User editUser = new User();
				boolean list = false;			
				if(user.getIsBlack() != null){
					list = user.getIsBlack();
					
				}
				if(!list){
					map.put("testList", list);
					session.setAttribute(Const.USER_KEY, username);
					java.util.Date  date = new java.util.Date();
					java.sql.Date  lastLog = new java.sql.Date(date.getTime());
					List<Integer> idArr = new ArrayList<Integer>();
					Date contract = new Date();
					if(user.getContractDate() != null){
						contract = user.getContractDate();
					}else{
						contract = new Date(0);
					}
					if(user.getType() != null){
						if(user.getType() == 3 || user.getType() == 4){
							if(contract.before(lastLog)){
								editUser.setType(5);
							}
						}
					}
					idArr.add(user.getId());
					editUser.setLastLoginDate(lastLog);
					dao.UpdateByBatch(idArr, editUser);
	 			}else{
					map.put("testList", list);
				}
			} else {
				map.put("testUser", false);
			}     
        }
		return JSON.toJSONString(map);
	}
	
	@RequestMapping(value="/register.do")
	public String register(){
		return "register";
	}
	//z注册
	@RequestMapping(value="/reg.do")
	@ResponseBody
	public String reg(@RequestParam("username") String username,	//用户名
			@RequestParam("userpassword") String password,			//密码
			@RequestParam("name") String name,						//真实姓名
			@RequestParam("sex") String sex,						//性别
			@RequestParam("email") String email						//邮箱
			) {
		User user = new User();
		user.setUsername(username);
		user.setPassword(MD5.GetMD5Code(password));
		user.setName(name);
		user.setSex(sex);
		user.setMail(email);
		/*   初始化     */
		user.setIsBlack(false);										//黑名单
		user.setAbsentNum(0);										//缺席
		user.setParticipateNum(0);									//参与
		user.setType(5); 											//用户类型
		Field newField = new Field();
		newField.setId(0);
		newField.setName("无");
		user.setField(newField);									//领域
		java.util.Date  date = new java.util.Date();
		java.sql.Date  registerDate = new java.sql.Date(date.getTime());
		user.setRegisterDate(registerDate);							//注册时间

		UserDAO dao = new UserDAO();
		if(dao.isRepeat(username)){
			return "-1";
		}
		if(dao.save(user)){
			return "1";
		}else{
			return "0";
		}
	}
	
	 public static boolean isEmail(String email){     
	     String str="^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$";
	        Pattern p = Pattern.compile(str);     
	        Matcher m = p.matcher(email);      
	        return m.matches();     
	    } 
	
	//找回密码接口
	@RequestMapping(value="/findPwd.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String findPwd(HttpSession session,@RequestParam("mail") String toMail,@RequestParam("check") String check,@RequestParam("username") String username){
		String c = (String) session.getAttribute("code");
		if(!c.equalsIgnoreCase(check)){
			return "验证码输入错误";
		}
		
		UserDAO u = new UserDAO();
		User user = u.findByUserName(username);
		
		if(user==null){
			return "用户名不存在";
		}else{
			if(!user.getMail().equals(toMail)){
				return "您填写的邮箱不正确";
			}
		}
		
		boolean isTrue = isEmail(toMail);
		if(isTrue){
			String getHost = MyTools.getHost();
			String href = getHost+"newPassword.do?sid="+ user.getSid() +"&userid="+ user.getId();
			String str  = user.getName() + "您好：<br>"
					+ "这封信是由 广元经信 发送的。<br><br>"
					+ "您收到这封邮件，是由于在 广元经信 进行了新用户注册，或用户修改 Email 使用了这个邮箱地址。如果您并没你有访问过 广元经信，或没有进行上述操作，请忽略这封邮件。您不需要退订或进行其他进一步的操作。<br><br><br>"
					+ "----------------------------------------------------------------------<br>"
					+"帐号激活说明<br>"
					+"----------------------------------------------------------------------<br><br><br>"
					+"如果您是 广元经信 的新用户，或在修改您的注册 Email 时使用了本地址，我们需要对您的地址有效性进行验证以避免垃圾邮件或地址被滥用。<br><br>"
					+"您只需点击下面的链接即可激活您的帐号：<br>"
					+"<a href='" + href + "'>" + href + "</a><br>"
					+"(如果上面不是链接形式，请将该地址手工粘贴到浏览器地址栏再访问)<br><br>"
					+"感谢您的访问，祝您使用愉快！<br><br>"
					+"此致<br>"
					+"<a href='"+ getHost +"'>";
			SendEmail s = new SendEmail(toMail,str,"广元经信提醒您");
			s.start();
			return "邮件发送成功请注意接收邮件";
		}else{
			return "邮箱不正确";
		}
	}
	
	//忘记密码修改密码的界面
	@RequestMapping(value="/newPassword.do")
	public String newPassword(@RequestParam("sid") String sid,@RequestParam("userid") Integer userid,ModelMap model){
		UserDAO u = new UserDAO();
		String res = "";
		boolean isSub = true;
		User user = u.findById(userid);
		
		if(user==null){
			res = "当前链接已经失效";
			isSub = false;
		}
		
		if(!user.getSid().equals(sid)){
			res = "当前链接已经失效,请重新提交";
			isSub = false;
		}
		
		model.addAttribute("res", res);
		model.addAttribute("isSub", isSub);
		model.addAttribute("userid", userid);
		model.addAttribute("sid", sid);
		return "newPassword";
	}
	
	//修改密码操作
	@RequestMapping(value="/ModPassWordAction.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String modePassWordAction(@RequestParam("sid") String sid,@RequestParam("userid") Integer userid,@RequestParam("password") String password,ModelMap model){
		UserDAO u = new UserDAO();
		String res = "";
		User user = u.findById(userid);
		
		if(user==null){
			res = "当前用户不正确";
		}
		
		if(!user.getSid().equals(sid)){
			res = "验证用户身份错误";
		}
		
		String newPASS = MD5.GetMD5Code(password);
		String Sid = MD5.GetMD5Code(new Date().toString()+res);
		boolean isok = u.updatePassword(userid, newPASS,Sid);
		
		if(isok)
			res = "密码修改成功";
		else
			res = "密码修改失败";
		
		return res;
	}
	
	//找回密码界面
	@RequestMapping(value="/forgetPassWord.do")
	public String forgetPassWord(){
		return "forgetPassword";
	}
	
	
	@RequestMapping(value="/zjfc.do")
	public String zjfc(ModelMap model,
			@RequestParam(value="id", required=false, defaultValue="0") Integer id,
			@RequestParam(value="page", required=false, defaultValue="1") Integer page
			){
		FieldDAO f = new FieldDAO();
		List<Field> data = f.findAll();
		
		int count = 0;
		
	
		
		ApplyDAO a = new ApplyDAO();
		List<Apply> app = a.findAllExpert((page-1)*10, 10, id);
		if(app != null){
			count = app.size();
		}
		model.addAttribute("app", app);
		model.addAttribute("field", data);
		model.addAttribute("page", page);
		model.addAttribute("count", count);
		model.addAttribute("id", id);
		return "zjfc";
	}
	
	@RequestMapping(value="/news.do")
	public String news(HttpServletRequest request,ModelMap model){
		int page = 0;
		int count = 0;
		String p = request.getParameter("page");
		if(p==null)
			page = 1;
		else
			page = Integer.parseInt(p);
		ArticleDAO a = new ArticleDAO();
		List<Article> article = a.findAll((page-1)*15, 15,1);
		if(article != null){
			count = article.size();
		}
		model.addAttribute("article", article);
		model.addAttribute("page", page);
		model.addAttribute("count", count);
		return "news";
	}
	
	@RequestMapping(value="/download.do")
	public String download(HttpServletRequest request,ModelMap model){
		int page = 0;
		int count = 0;
		String p = request.getParameter("page");
		if(p==null)
			page = 1;
		else
			page = Integer.parseInt(p);
		ArticleDAO a = new ArticleDAO();
		List<Article> article = a.findAll((page-1)*15, 15,3);
		if(article != null){
			count = article.size();
		}
		model.addAttribute("article", article);
		model.addAttribute("page", page);
		model.addAttribute("count", count);
		return "download";
	}
	
	@RequestMapping(value="/gonggao.do")
	public String gonggao(HttpServletRequest request,ModelMap model){
		int page = 0;
		int count = 0;
		String p = request.getParameter("page");
		if(p==null)
			page = 1;
		else
			page = Integer.parseInt(p);
		ArticleDAO a = new ArticleDAO();
		List<Article> article = a.findAll((page-1)*15, 15,2);
		if(article != null){
			count = article.size();
		}
		model.addAttribute("article", article);
		model.addAttribute("page", page);
		model.addAttribute("count", count);
		return "gonggao";
	}
}
