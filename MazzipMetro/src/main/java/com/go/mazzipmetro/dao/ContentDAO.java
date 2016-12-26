package com.go.mazzipmetro.dao;


import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.go.mazzipmetro.vo.RestaurantAdVO;
import com.go.mazzipmetro.vo.RestaurantVO;

@Controller
public class ContentDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 메인배너 컨텐츠에 등록된 데이터 중 하나를 랜덤으로 가져오는 메서드
	public RestaurantVO getMainContents() {
		
		Random rnd = new Random();
		
		int count = sqlSession.selectOne("content.contentCount");
		int result = rnd.nextInt(count)+1;
		
		RestaurantVO rvo = sqlSession.selectOne("content.getMainRestaurant", result);

		return rvo;
	}

	// 가져온 데이터에서 해당 업장의 소개이미지를 가져오는 메서드
	public List<String> getMainContentsAdImage(String restSeq) {
		
		List<String> adImage = sqlSession.selectList("content.getMainContentsAdImage", restSeq);
		return adImage;
	}

	// 측면배너 컨텐츠에 들어갈 데이터	
	public List<RestaurantVO> getRightContents() {
		String seq = "3";
		List<String> countList = sqlSession.selectList("content.contentListCount", seq);
		List<RestaurantVO> rvoList = new ArrayList<RestaurantVO>();
		
		Collections.shuffle(countList);
		
		for (int i = 0; i < countList.size(); i++) {
			RestaurantVO vo = sqlSession.selectOne("content.getRightRestaurant", countList.get(i));
			rvoList.add(vo);
			
			if (i == 4) {
				break;
			}
		}
		
		return rvoList;
	}

	// 검색 파워링크 컨텐츠에 들어갈 데이터
	public List<RestaurantVO> getPowerLinkContents() {
		String seq = "2";
		List<String> countList = sqlSession.selectList("content.contentListCount", seq);
		List<RestaurantVO> rvoList = new ArrayList<RestaurantVO>();
		
		Collections.shuffle(countList);
		
		for (int i = 0; i < countList.size(); i++) {
			RestaurantVO vo = sqlSession.selectOne("content.getRightRestaurant", countList.get(i));
			rvoList.add(vo);
			
			if (i == 1) {
				break;
			}
		}
		
		return rvoList;
	}
	
	// 측면배너 컨텐츠에 들어갈 데이터	
	public RestaurantVO getWantGoContents() {
		String seq = "3";
		List<String> countList = sqlSession.selectList("content.contentListCount", seq);
		
		Collections.shuffle(countList);
		
		RestaurantVO vo = sqlSession.selectOne("content.getRightRestaurant", countList.get(0));
		
		String restContent = vo.getRestContent();
		restContent = restContent.substring(0, 30);
		vo.setRestContent(restContent+"...");
		
		return vo;
	}
	
	//동현_업장상세페이지 요청시 사용자의 가고싶다의 담겨있는 경우만, req객체에 담는다.
	public int checkWantToGo(HashMap<String, String> map) {
		return sqlSession.selectOne("mazzipMetro.checkWantToGo", map);
	}
}
