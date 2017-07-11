package com.jingxin.Filter;


import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.jingxin.hibernate.utils.HibernateSessionFactory;




/**
 * hibernate查询时,session不会自动关闭.
 * 此过滤器用来关闭session.
 */
public class CloseSessionFilter implements Filter {

    public void destroy() {
        
    }

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException,
            ServletException {
            chain.doFilter(req, res);
            HibernateSessionFactory.closeSession();
    }

    public void init(FilterConfig arg0) throws ServletException {
        
    }
}