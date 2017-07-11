package com.jingxin.hibernate.dao;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jingxin.hibernate.model.Setup;
import com.jingxin.hibernate.utils.BaseHibernateDAO;

public class SetupDAO extends BaseHibernateDAO{
	//查询全部
	public List<Setup> findAll(){
		try {
			Query query = getSession().createQuery("from Setup");
			return query.list();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	//保存或更新
	
	public boolean update(Setup setup){
		Transaction tr = null;
		Session session = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("update Setup s set s.value=:value where name=:name");
			query.setString("value", setup.getValue());
			query.setString("name", setup.getName());
			query.executeUpdate();
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

	//以键查值
	public String findByKey(String key){
		Session session = null;
		try {
			session = getSession();
			Query query = session.createQuery("from Setup where name=:key");
			query.setString("key", key);
			Setup setup = (Setup)query.list().get(0);
			return setup.getValue();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}