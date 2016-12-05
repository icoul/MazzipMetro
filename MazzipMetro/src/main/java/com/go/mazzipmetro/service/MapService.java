package com.go.mazzipmetro.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.MapDAO;
import com.go.mazzipmetro.vo.RestaurantAdVO;
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

		public List<HashMap<String, String>> getRestaurantList(HashMap<String, String[]> map) {
			List<HashMap<String, String>> list = dao.getRestaurantList(map);
			
			/*for (int i = 0; i < list.size(); i++) {
				String restSeq = list.get(i).get("restSeq");
				List<String> bgTagList = dao.getRestBgTag(restSeq);
				List<String> mdTagList = dao.getRestMdTag(restSeq);
				String restBgTag = "";
				String restMdTag = "";
				
				for (int j = 0; j < bgTagList.size(); j++) {
					restBgTag += bgTagList.get(j);
					if(j < bgTagList.size()-1){
						restBgTag += ", ";
					}		
				}// end of for (int j = 0; j < bgTagList.size(); j++) 
				
				
				for (int k = 0; k< mdTagList.size(); k++) {
					restMdTag += mdTagList.get(k);
					if(k < mdTagList.size()-1){
						restMdTag += ", ";
					}		
				}// end of for (int j = 0; j < mdTagList.size(); j++) 
				
				list.get(i).put("restBgTag", restBgTag);
				list.get(i).put("restMdTag", restMdTag);
			}*/
			
			return list;
					
		}

		// 지하철역별 등록된 음식점 보여주기
		public List<RestaurantVO> searchByMetro(HashMap<String, String> map) {
			List<RestaurantVO> list = dao.searchByMetro(map);
			return list;
		}
		
		// 지하철역별 등록된 음식점 보여주기(음식점 태그 가져오기)
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
		

		// 지하철역별 등록된 음식점 보여주기(해당역 총 음식점 개수)
		public int getTotalCount(HashMap<String, String> map) {
			return dao.getTotalCount(map);
		}

		// 업장 상세페이지용 RestaurantVO 얻기 
		public RestaurantVO selectOneRestaurant(String restSeq) {
			return dao.selectOneRestaurant(restSeq);
		}

		// 자동글완성
		public List<String> autoComplete(HashMap<String, String> map) {
			return dao.autoComplete(map);
		}
		
		// 자동글완성(카테고리)
		public List<HashMap<String, String>> catAutoComplete(String keyword) {
			//카테고리화된 autoComplete
			List<String> restList = dao.r_catAutoComplete(keyword);
			List<String> metroList = dao.m_catAutoComplete(keyword);
			List<String> dongList = dao.d_catAutoComplete(keyword);
			List<String> guList = dao.g_catAutoComplete(keyword);
			
			List<HashMap<String, String>> catList = new ArrayList<HashMap<String,String>>();
			
			
			for (String metroName : metroList) {
				HashMap<String, String> elemMap = new HashMap<String, String>();
				elemMap.put("label", metroName);
				elemMap.put("category", "지하철역이름");
				catList.add(elemMap);
			}
			
			for (String dongName : dongList) {
				HashMap<String, String> elemMap = new HashMap<String, String>();
				elemMap.put("label", dongName);
				elemMap.put("category", "동이름");
				catList.add(elemMap);
			}
			
			for (String guName : guList) {
				HashMap<String, String> elemMap = new HashMap<String, String>();
				elemMap.put("label", guName);
				elemMap.put("category", "구이름");
				catList.add(elemMap);
			}
			
			for (String restName : restList) {
				HashMap<String, String> elemMap = new HashMap<String, String>();
				elemMap.put("label", restName);
				elemMap.put("category", "음식점이름");
				catList.add(elemMap);
			}
			return catList;
		}

		// 지하철 역이름 얻기 (지도페이지로 넘길 때 사용함)
		public String getMetroName(String metroId) {
			return dao.getMetroName(metroId);
		}

		//지하철 역명 가져오기(업장 직접 등록시 사용)
		public List<HashMap<String,String>> getMetroNameList(String metroNum) {
			return dao.getMetroNameList(metroNum);
		}

		// metroMap tooltip정보 가져오기
		public List<RestaurantVO> getBest5RestInMetroMap(String metroId) {
			return dao.getBest5RestInMetroMap(metroId);
		}

		// 업장 추가이미지(restaurantAdVO)가져오기
		public List<RestaurantAdVO> getAdImg(List<String> restSeqList) {
			
			List<RestaurantAdVO> list = new ArrayList<RestaurantAdVO>();
			for (String restSeq : restSeqList) {
				
				RestaurantAdVO vo = new RestaurantAdVO();
				vo.setRestSeq(restSeq);
				vo.setAdImg(dao.getAdImg(restSeq));
				
				//System.out.println(">>> service단 vo.getAdImg().length = "+vo.getAdImg().length); 
				list.add(vo);
			}
			return list;
		}


		
		
	}
