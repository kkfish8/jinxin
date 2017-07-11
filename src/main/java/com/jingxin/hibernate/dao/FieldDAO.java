package com.jingxin.hibernate.dao;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.jingxin.hibernate.model.Field;
import com.jingxin.hibernate.utils.BaseHibernateDAO;

public class FieldDAO extends BaseHibernateDAO {
	//查询所有
	public List<Field> findAll(){
		Session session = null;
		try {
			session = getSession();
			Query query = session.createQuery("from Field");
			List<Field> list = query.list();
			return list;
		} catch (Exception  e) {
			e.printStackTrace();
			return null;
		}
	}
	//通过id查找
	public Field findById(int id){
		Session session = null;
		try {
			session = getSession();
			Field field = (Field) session.get(Field.class, id);
			return field;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	//通过名字查询
	public List<Field> findByName(String name){
		Session session = null;
		try {
			session = getSession();
			Query query = getSession().createQuery("from Field where name=:name");
			query.setString("name", name);
			List<Field> list = query.list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	//保存或者更新
	public boolean saveOrUpdate(Field field){
		Session session = null;
		Transaction tr = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			session.saveOrUpdate(field);
			tr.commit();
			return true;
		}catch(Exception e){
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			return false;
		}
	}
	//通过id删除
	public boolean deleteById(List<Integer> idArr){
		Session session = null;
		Transaction tr = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("delete Field where id in:idArr");
			query.setParameterList("idArr", idArr);
			query.executeUpdate();
			tr.commit();
			return true;
		}catch(Exception e){
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			return false;
		}
	}
}