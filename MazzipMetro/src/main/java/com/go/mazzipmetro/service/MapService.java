package com.go.mazzipmetro.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.MapDAO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.TagVO;

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

		public List<HashMap<String, String>> getRestaurantList() {
			return dao.getRestaurantList();
		}

		//지하철역별 등록된 음식점 보여주기
		public List<RestaurantVO> searchByMetro(HashMap<String, String> map) {
			List<RestaurantVO> list = dao.searchByMetro(map);
			return list;
		}
		
		//지하철역별 등록된 음식점 보여주기(음식점 태그 가져오기)
		public List<TagVO> getRestTag(List<String> restSeqList) {
			List<TagVO>  list = new ArrayList<TagVO>();
			int i = 0;
			for (String restSeq : restSeqList) {
				System.out.println(i+" : "+restSeq); 
				
				TagVO vo = new TagVO();
				vo.setRestSeq(restSeq);
				vo.setBgCat(dao.getRestBgTag(restSeq));
				vo.setMdCat(dao.getRestMdTag(restSeq));
				list.add(vo);
				i++;
			}
			
			return list;
		}
		

		//지하철역별 등록된 음식점 보여주기(해당역 총 음식점 개수)
		public int getTotalCount(HashMap<String, String> map) {
			return dao.getTotalCount(map);
		}

		// 업장 상세페이지용 RestaurantVO 얻기 
		public RestaurantVO selectOneRestaurant(String restSeq) {
			return dao.selectOneRestaurant(restSeq);
		}


		
		
	}
