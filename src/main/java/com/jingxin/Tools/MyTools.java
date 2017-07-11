/**   
 * 文件名：MyTools.java
 *   
 * 版本信息：TODO
 * 日期：2015年9月12日
 * Copyright QiHang Corporation 2015 
 *   
 */
package com.jingxin.Tools;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class MyTools {

	public static String subTextString(String str, int len, String sufix){  
	    if(str == null || str.length()<len/2)return str;  
	    int count = 0;  
	    StringBuffer sb = new StringBuffer();  
	    String[] ss = str.split("");  
	    for(int i=1;i<ss.length;i++){  
	        count+=ss[i].getBytes().length>1?2:1;  
	        sb.append(ss[i]);
	        if(count>=len)break;
	    }  
	    String newStr = sb.toString();
	    return newStr.length() < str.length() ? newStr + sufix : newStr;
	}
	
	
	public static String getHost() {
		InetAddress addr;
		try {
			addr = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		String ip=addr.getHostAddress().toString();//获得本机IP
		return "http://"+ip+":"+Const.PORT+Const.WEB_PATH;
	}

	
	public static String convertStreamToString(InputStream is) {      

		BufferedReader reader = new BufferedReader(new InputStreamReader(is));      
		StringBuilder sb = new StringBuilder();      

		String line = null;      
		try {      
			while ((line = reader.readLine()) != null) {      
				sb.append(line);
			}      
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {      
				e.printStackTrace();
			}
		}
		return sb.toString();
	}

	public static String convertStreamToString(InputStream is, String charsetName) throws UnsupportedEncodingException {      

		BufferedReader reader = new BufferedReader(new InputStreamReader(is, charsetName));
		StringBuilder sb = new StringBuilder();      

		String line = null;      
		try {      
			while ((line = reader.readLine()) != null) {      
				sb.append(line);
			}      
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {      
				e.printStackTrace();
			}
		}
		return sb.toString();
	}
	
	
}
