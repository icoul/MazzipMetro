package com.go.mazzipmetro.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.service.MapService;

@Controller
public class MapController {
	
	@Autowired
	MapService service;
	
	//클러스터러 (clickable) 테스트 : 음식점 목록 가져오기
	@RequestMapping(value="/clusterer.eat",method={RequestMethod.GET}) 
	public String clusterer(){
		return "/maps/clusterer";
	}
	
	//클러스터러 (clickable) 테스트 : 음식점 목록 가져오기
	@RequestMapping(value="/getRestaurantList.eat",method={RequestMethod.GET}) 
	public String getRestaurantList(HttpServletRequest req){
		List<HashMap<String, Double>> list = service.getRestaurantList();
		
		JSONObject jObj = new JSONObject();
		jObj.put("positions", list);
		
		req.setAttribute("jObj", jObj);
		
		return "/maps/json/getRestaurantList";
	}
	
	//지하철역 위경도 가져오기
	@RequestMapping(value="/addMetro.eat",method={RequestMethod.GET}) 
	public String addMetro(){
		return "/maps/addMetro";
	}
	
	@RequestMapping(value="/addMetroEnd.eat",method={RequestMethod.POST}) 
	public String insertMetro(HttpServletRequest req){
		String metroNum = req.getParameter("metroNum");
		String metroName = req.getParameter("metroName");
		String latitude = req.getParameter("latitude");
		String longitude = req.getParameter("longitude");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("metroNum", metroNum);
		map.put("metroName", metroName);
		map.put("latitude", latitude);
		map.put("longitude", longitude);
		
		service.insertMetro(map);
		
		return "redirect:/addMetro.eat";
		
	}
	
	@RequestMapping(value="/addRstr.eat",method={RequestMethod.GET}) 
	public String addRstr(){
		return "addRstr";
	}
	
	@RequestMapping(value="/addRstrEnd.eat",method={RequestMethod.POST}) 
	public void insertRestaurant(HttpServletRequest req){
		
		String restaurantTitle = req.getParameter("restaurantTitle");
		String addr= req.getParameter("addr");
		String newAddr= req.getParameter("newAddr");
		String phone = req.getParameter("phone");
		String latitude = req.getParameter("latitude");
		String longitude = req.getParameter("longitude");
		String metroId = req.getParameter("metroId");
		String dongId = req.getParameter("dongId");
		
//		System.out.println(restaurantTitle);
//		System.out.println(addr);
//		System.out.println(newAddr);
//		System.out.println(phone);
//		System.out.println(latitude);
//		System.out.println(longitude);
//		System.out.println(metroId);
//		System.out.println(dongId);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("restaurantTitle", restaurantTitle);
		map.put("addr", addr);
		map.put("newAddr", newAddr);
		map.put("phone", phone);
		map.put("latitude", latitude);
		map.put("longitude", longitude);
		map.put("metroId", metroId);
		map.put("dongId", dongId);
		
		service.insertRestaurant(map);
		System.out.println("data inserted successfully!"); 
		
	}
	
	//주소로 dongId알아내기
	@RequestMapping(value="/getDongId.eat",method={RequestMethod.POST}) 
	public String getDongId(HttpServletRequest req){
		String dongName = req.getParameter("dongName");
		
		//System.out.println(dongName); 
		String dongId = service.getDongId(dongName);
		
		JSONObject jObj = new JSONObject();
		jObj.put("dongId", dongId);
		
		req.setAttribute("jObj", jObj);
		return "/maps/json/dongId";
	}
	
	//지하철역 Id 얻기
	@RequestMapping(value="/getMetroId.eat",method={RequestMethod.POST}) 
	public String getMetroId(HttpServletRequest req){
		String metroName = req.getParameter("metroName");
		
		//System.out.println(dongName); 
		String metroId = service.getMetroId(metroName);
		
		//System.out.println(metroId); 
		
		JSONObject jObj = new JSONObject();
		jObj.put("metroId", metroId);
		
		req.setAttribute("jObj", jObj);
		return "/maps/json/metroId";
	}
		

}
