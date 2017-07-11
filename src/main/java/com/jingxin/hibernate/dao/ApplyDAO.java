package com.jingxin.hibernate.dao;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.jingxin.hibernate.model.Apply;
import com.jingxin.hibernate.model.User;
import com.jingxin.hibernate.utils.BaseHibernateDAO;

public class ApplyDAO extends BaseHibernateDAO {
	//保存 更新
	public boolean saveOrUpdate(Apply apply){
		Transaction tr = null;
		Session session = null;
		try{
			session = getSession();
			tr = session.beginTransaction();
			session.saveOrUpdate(apply);
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
	//通过id查询
	public Apply findById(int id){
		Session session = null;
		try{
			session = getSession();
			Apply apply = (Apply) session.get(Apply.class, id);
			return apply;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//查询所有
	public List<Apply> findAll(){
		Session session = null;
		try{
			session = getSession();
			Query query = session.createQuery("from Apply");
			List<Apply> list = query.list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//审核
	public int updateIsPassById(int id){
		Transaction tr = null;
		Session session = null;
		try{
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("update Apply a set a.isPass=1 where id=:id");
			query.setInteger("id", id);
			int d = query.executeUpdate();
			tr.commit();
			return d;
		}catch(Exception e){
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			session.close();
			return 0;
		}
	}
	//查询所有专家
	public List<Apply> findAllExpert(int start,int num,int id){
		Session session = null;
		try {
			session = getSession();
			Query query = null;
			if(id == 0){
				query = session.createQuery("from Apply where IsPass=1");
			}else{
				query = session.createQuery("from Apply where (isPass=1 and field=:id)");
				query.setInteger("id", id);
			}
			query.setFirstResult(start);
			query.setMaxResults(num);
			List<Apply> apply = query.list();
			return apply;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	//通过id删除一条记录
	public boolean deleteById(List<Integer> idArr){
		Session session = null;
		Transaction tr = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("delete Apply where id in:id");
			query.setParameterList("id", idArr);
			query.executeUpdate();
			tr.commit();
			return true;
		}catch(Exception e){
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			session.close();
			return false;
		}
	}
	//随机查询某个领域的N个专家
	public List<User> findRandByField(int field){
		Transaction tr = null;
		Session session = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("from User where ((type=3 or type=4) and field=:field)");
			query.setInteger("field", field);
			List<User> list = query.list();
			tr.commit();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			if(tr!=null){
				tr.rollback();
			}
			session.close();
			return null;
		}
	}
}