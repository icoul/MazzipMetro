package com.go.mazzipmetro.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.MapDAO;

@Service
public class MapService  implements IService {
	 
		@Autowired
		private MapDAO dao;
		
		public void insertMetro(HashMap<String, String> map) {
			dao.insertMetro(map);
		}
		
		public void insertRestaurant(HashMap<String, String> map) {
			dao.insertRestaurant(map);
		}
		
		public String getDongId(String dongName) {
			return dao.getDongId(dongName);
		}

		public String getMetroId(String metroName) {
			return dao.getMetroId(metroName);
		}
		
	}
