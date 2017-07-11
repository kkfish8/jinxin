package com.jingxin.hibernate.dao;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.jingxin.hibernate.model.Record;
import com.jingxin.hibernate.utils.BaseHibernateDAO;

public class RecordDAO extends BaseHibernateDAO{
	//保存或更新
	public boolean saveOrUpdate(Record record){
		Transaction tr = null;
		Session session = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			session.saveOrUpdate(record);
			tr.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			session.close();
			return false;
		}
	}
	//查找全部
	public List<Record> findAll(){
		Session session = null;
		try {
			session = getSession();
			Query query = session.createQuery("from Record");
			List<Record> list = query.list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//批量删除
	public boolean deleteByBatch(List<Integer> idArr){
		Transaction tr = null;
		Session session = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("delete Record where id in:idArr");
			query.setParameterList("idArr", idArr);
			query.executeUpdate();
			tr.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			session.close();
			return false;
		}
	}
	//批量查找
	public List<Record> findByIdBatch(List<Integer> idArr){
		Session session = null;
		try {
			session = getSession();
			Query query = session.createQuery("from Record where id in:idArr");
			query.setParameterList("idArr", idArr);
			List<Record> list = query.list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//通过id查找
	public Record findById(int id){
		Session session = null;
		try {
			session = getSession();
			Record record = (Record)session.get(Record.class, id);
			return record;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
}
