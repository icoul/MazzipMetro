package com.go.mazzipmetro.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.MazzipMetroService;

@Controller
public class MazzipMetroController {
	
	@Autowired
	MazzipMetroService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	
	@RequestMapping(value="/index.eat", method={RequestMethod.GET})
	public String index(){
		return "index2";
	}
	
	@RequestMapping(value="/dbTest.eat", method={RequestMethod.GET})
	public String dbTest(HttpServletRequest req){
		
		List<HashMap<String, String>> list = service.dbTest();
		
		req.setAttribute("list", list);
		return "dbTest";
	}
}
