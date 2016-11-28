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
import com.go.mazzipmetro.dao.RestaurantVO;
import com.go.mazzipmetro.service.RestaurantService;

@Controller
public class RestaurantController {

	@Autowired
	private RestaurantService service; 
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	@RequestMapping(value="/addRestaurant.eat", method={RequestMethod.GET})
	public String addRestaurant(){
		
		return "addRestaurant";
	}
	
	@RequestMapping(value="/restCheck.eat", method={RequestMethod.GET})
	public String restCheck(HttpServletRequest req){
		
		String name = req.getParameter("name");
		
		List<RestaurantVO> nameList = service.getRestName(name); 
		
		req.setAttribute("name", name);
		req.setAttribute("nameList", nameList);
		
		return "restCheck";
	}
}
