package com.jingxin.hibernate.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jingxin.hibernate.model.Article;
import com.jingxin.hibernate.model.User;
import com.jingxin.hibernate.utils.BaseHibernateDAO;

public class ArticleDAO extends BaseHibernateDAO {
	//查询指定起始对象和指定条数
	public List<Article> findAll(int start,int num){
		Session session = null;
		try{
			session = getSession();
			Query query = session.createQuery("from Article a order by a.id desc");
			query.setFirstResult(start);
			query.setMaxResults(num);
			List<Article> list = query.list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	//保存或更新
	public boolean saveOrUpdate(Article article){
		Session session = null;
		Transaction tr = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			session.saveOrUpdate(article);			
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
	//查询指定起始位置和指定返回条数及类型
	public List<Article> findAll(int start,int num,int type){
		Session session = null;
		try{
			session = getSession();
			Query query = session.createQuery("from Article a where a.type=:type order by a.id desc");
			query.setInteger("type", type);
			query.setFirstResult(start);
			query.setMaxResults(num);
			List<Article> list = query.list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//查询全部
	public List<Article> findAll(){
		Session session = null;
		try{
			session = getSession();
			Query query = session.createQuery("from Article");
			List<Article> list = query.list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//查询最新文章
	public List<Article> findNewArticle(int num){
		Session session = null;
		try{
			session = getSession();
			Query query = session.createQuery("from Article a order by a.id desc");
			query.setMaxResults(num);
			List<Article> list = query.list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//通过id查询一个对象
	public Article findById(int id){
		Session session = null;
		try{
			session = getSession();
			Article article = (Article)getSession().get(Article.class, id);
			return article;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	//查询前7条新闻
	public List<Article> findNews(int total){
		Session session = null;
		try{
			session = getSession();
			Query query = session.createQuery("from Article a where a.type=:type order by a.id desc");
			query.setString("type", "1");
			query.setMaxResults(total);
			List<Article> list = query.list();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	//查询公告前7条
	public List<Article> findNotice(int total){
		Session session = null;
		try{
			session = getSession();
			Query query = session.createQuery("from Article a where Type=:type order by a.id desc");
			query.setInteger("type", 2);
			query.setMaxResults(total);
			List<Article> list = query.list();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	//查询前7条资源下载
	public List findResource(int total){
		Session session = null;
		try{
			session = getSession();
			Query query = session.createQuery("from Article a where Type=:type order by a.id desc");
			query.setInteger("type", 3);
			query.setMaxResults(total);
			List<Article> list = query.list();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/*批量更新
	 * 返回true为修改成功  否则修改失败
	 * */
	public boolean UpdateByBatch(List<Integer> idArr, Article article) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getSession();
			tr = session.beginTransaction();
			Query query = session.createQuery("FROM Article WHERE Id IN :idarr");
			query.setParameterList("idarr", idArr);
			
			@SuppressWarnings("unchecked")
			List<Article> articleList = query.list();
			for (Article a : articleList) {
				if(article.getUser() != null) {
					a.setUser(article.getUser());
				}
				if(article.getTitle() != null){
					a.setTitle(article.getTitle());
				}
				if(article.getContent() != null){
					a.setContent(article.getContent());
				}
				if(article.getPublishDate() != null){
					a.setPublishDate(article.getPublishDate());
				}
				if(article.getType() != null){
					a.setType(article.getType());
				}
				if(article.getNote() != null){
					a.setNote(article.getNote());
				}
				if(article.getClickCount() != null){
					a.setClickCount(article.getClickCount());
				}
				if(article.getArticleOrder() != null){
					a.setArticleOrder(article.getArticleOrder());
				}
				session.update(a);
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
			query = session.createQuery("DELETE Article WHERE Id IN :idArr");
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
}