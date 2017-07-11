package com.jingxin.hibernate.dao;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jingxin.hibernate.model.Apply;
import com.jingxin.hibernate.model.User;
import com.jingxin.hibernate.utils.BaseHibernateDAO;

public class UserDAO extends BaseHibernateDAO{
	//查询全部
	public List<User> findAll(){
		try{
			String queryString = "from User";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//更新并保存
	public boolean save(User user){
		Transaction t = null;
		Session session = null;
		try{
			session = getSession();
			t = session.beginTransaction();
			session.save(user);
			t.commit();
			return true;
		}catch(Exception e){
			t.rollback();
			e.printStackTrace();
			return false;
		}
	}
	//通过id查找
	public User findById(Integer id){
		User user = (User) getSession().get(User.class, id);
		return user;
	}
	//通过用户名查找
	public User findByUserName(String userName){
		Query query = getSession().createQuery("from User where username=:userName");
		query.setString("userName", userName);
		List list = query.list();
		if(list.isEmpty()){
			return null;
		}else{
			return (User) list.get(0);
		}
	}
	//验证用户
	public boolean isRight(String userName,String userPass){
		User user = findByUserName(userName);
		if(user!=null && userPass != null){
			if(userPass.equals(user.getPassword())){
				return true;
			}
			else{
				return false;
			}
		}
		return false;
	}
	/**
	 * 验证用户名是否重复
	 * @param userName
	 * @return true 为重复，  false为不重复
	 */
	public boolean isRepeat(String userName){
		Query query = getSession().createQuery("from User where username=:userName");
		query.setString("userName", userName);
		List list = query.list();
		if(list.isEmpty()){
			return false;
		}else{
			return true;
		}
	}
	//提取指定领域的指定人数的随机用户
	public List<User> findByRandom(int field,int num){
		Session session = null;
		try {
			session = getSession();
			Query query = session.createQuery("from User where (field=:field and (type=3 or type=4)) order by rand()");
			query.setInteger("field", field);
			query.setMaxResults(num);
			List<User> list = query.list();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	//查询用户是否提交申请
	public boolean isApply(int id){
		User user = new UserDAO().findById(id);
		if(user.getApplies().isEmpty()){
			return false;
		}else{
			return true;
		}
	}
	//根据邮箱查用户
	public User findByEmail(String email){
		Query query = getSession().createQuery("from User where Mail=:mail");
		query.setString("mail", email);
		List<User> list = query.list();
		if(list.isEmpty()){
			return null;
		}else{
			return (User)list;
		}
	}
	/*	根据id修改密码和sid
	 * 	返回true为修改成功  否则修改失败
	 * */
	public boolean updatePassword(int id,String password,String sId){
		Session session = null;
		Transaction tr = null;
		try{
			session = getSession();
			tr = session.beginTransaction();
			User user = findById(id);
			user.setPassword(password);
			user.setSid(sId);
			session.update(user);
			tr.commit();
			return true;
		}catch(Exception e){
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
		}
		return false;
	}
	/*批量更新
	 * 返回true为修改成功  否则修改失败
	 * */
	public boolean UpdateByBatch(List<Integer> idArr, User user) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("FROM User WHERE Id IN :idarr");
			query.setParameterList("idarr", idArr);
			
			@SuppressWarnings("unchecked")
			List<User> userList = query.list();
			for (User u : userList) {
				if(user.getField() != null) {
					u.setField(user.getField());
				}
				if(user.getUsername() != null){
					u.setUsername(user.getUsername());
				}
				if(user.getPassword() != null){
					u.setPassword(user.getPassword());
				}
				if(user.getSid() != null){
					u.setSid(user.getSid());
				}
				if(user.getType() != null){
					u.setType(user.getType());
				}
				if(user.getName() != null){
					u.setName(user.getName());
				}
				if(user.getSex() != null){
					u.setSex(user.getSex());
				}
				if(user.getNumber() != null){
					u.setNumber(user.getNumber());
				}
				if(user.getMail() != null){
					u.setMail(user.getMail());
				}
				if(user.getIsBlack() != null){
					u.setIsBlack(user.getIsBlack());
				}
				if(user.getUserImage() != null){
					u.setUserImage(user.getUserImage());
				}
				if(user.getAbsentNum() != null){
					u.setAbsentNum(user.getAbsentNum());
				}
				if(user.getParticipateNum() != null){
					u.setParticipateNum(user.getParticipateNum());
				}
				if(user.getRegisterDate() != null){
					u.setRegisterDate(user.getRegisterDate());
				}
				if(user.getLastLoginDate() != null){
					u.setLastLoginDate(user.getLastLoginDate());
				}
				if(user.getNote() != null){
					u.setNote(user.getNote());
				}
				if(user.getContractDate() != null){
					u.setContractDate(user.getContractDate());
				}
				session.update(u);
			}
			tr.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
		}
		return false;
	}
	/*批量删除字段
	 * 返回true为修改成功 否则修改失败
	 * */
	public boolean deleteByIdArr(List<Integer> idArr){
		Session session = null;
		Transaction tr = null;
		Query query = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			query = session.createQuery("DELETE User WHERE Id IN :idArr");
			query.setParameterList("idArr", idArr);
			query.executeUpdate();
			tr.commit();
			return true;
		} catch (Exception e) {
			if(tr!=null){
				tr.rollback();
			}
			e.printStackTrace();
		}
		return false;
	}
	//根据用户名修改sid
	public boolean updateSidByUserName(String userName,String sId){
		Session session = null;
		Transaction tr = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			User user = findByUserName(userName);
			user.setSid(sId);
			session.save(user);
			tr.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			return false;
		}
	}
	//更新用户
	public boolean updateUser(User user){
		try {
			getSession().update(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	public int updateIsPassById(String username){
		Transaction tr = null;
		Session session = null;
		try{
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("update User a set a.type=4 where username=:username");
			query.setString("username", username);
			int d = query.executeUpdate();
			tr.commit();
			return d;
		}catch(Exception e){
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			return 0;
		}
	}
	//抽取出的专家参与次数+1
}