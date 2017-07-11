package com.jingxin.spring.springmvc.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class FileDownloadController {
	
	 @RequestMapping("down.do")    
	    public ResponseEntity<byte[]> download(HttpServletRequest request) throws IOException { 
	    	String path = request.getParameter("path");
	    	String filename = request.getParameter("filename");
	    	
	    	if(path==null || filename==null){
	    		return null;
	    	}
	    	
	    	String s = request.getRealPath("/").toString();
	        File file=new File(s+"/"+path);  
	        if(!file.exists()){
	        	return null;
	        }
	        HttpHeaders headers = new HttpHeaders();    
	        headers.setContentDispositionFormData("attachment", filename);   
	        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
	        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
	                                          headers, HttpStatus.CREATED);    
	    }    
}
