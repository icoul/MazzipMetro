package com.go.mazzipmetro.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.service.MapService;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.TagVO;


@Controller
public class MapController {
	
	@Autowired
	MapService service;
	
	//클러스터러 (clickable) & 커스텀 overlay 테스트
	@RequestMapping(value="/clustererTest2.eat",method={RequestMethod.GET}) 
	public String clustererTest2(){
		return "/maps/clustererCustomOverlay";
	}
	
	//클러스터러 (clickable) 테스트 : 음식점 목록 가져오기
		@RequestMapping(value="/getRestaurantList.eat",method={RequestMethod.GET}) 
		public String getRestaurantList(HttpServletRequest req){
			
			String[] srchType = req.getParameterValues("srchType");
			String[] keyword = req.getParameterValues("keyword");
			String[] restTagArr = req.getParameterValues("restTag");
			String[] userSeq = req.getParameterValues("restManager");
			String[] restStatus = req.getParameterValues("restStatus");
			
			System.out.println("---------------------------------------"); 
			System.out.println(srchType[0]);
			System.out.println(keyword[0]);
			if (restTagArr != null) {
				System.out.println(restTagArr[0]);
			}
			System.out.println(userSeq[0]);
			System.out.println(restStatus[0]);
			System.out.println("---------------------------------------");
			
			HashMap<String, String[]> map = new HashMap<String, String[]>();
			map.put("srchType", srchType);
			map.put("keyword", keyword);
			map.put("restTagArr", restTagArr);
			map.put("userSeq", userSeq);
			map.put("restStatus", restStatus);
			
			List<HashMap<String, String>> list = service.getRestaurantList(map);
			
			JSONObject jObj = new JSONObject();
			jObj.put("positions", list);
			
			req.setAttribute("jObj", jObj);
			
			return "/maps/json/getRestaurantList";
		}
	
	//업장상세페이지에 쓰일 지도, 로드뷰 
	@RequestMapping(value="/restaurantMapRoadView.eat",method={RequestMethod.GET}) 
	public String restaurantMapRoadView(HttpServletRequest req){
		String restSeq = req.getParameter("restSeq");
		RestaurantVO vo = service.selectOneRestaurant(restSeq);
		
		req.setAttribute("mapVO", vo);
		return "/maps/restaurantMapRoadView";
	}
	
	//지하철역별 등록된 음식점 보여주기
	@RequestMapping(value="/restaurantInMetro.eat",method={RequestMethod.GET}) 
	public String restaurantInMetro(){
		return "/maps/restaurantInMetro";
	}
	
	//지하철역별 등록된 음식점 보여주기(페이징)
	@RequestMapping(value="/searchByMetro.eat",method={RequestMethod.GET}) 
	public String searchByMetro(HttpServletRequest req){
		String keyword = req.getParameter("keyword");
		String pageNo = req.getParameter("pageNo");
		
		System.out.println("/"+keyword+" &"+pageNo+" /");
		int totalRest = 0; 			//총 음식 건수
		int totalPage = 0;			// 전체 페이지수
		int sizePerPage = 15; 	// 한페이지당 보여줄 음식점수
		int currPage = 0;			// 요청 페이지 req객체 파라미터에 담긴 요청페이지 pageNo 
		
		int start = 0; 					// 시작행번호
		int end = 0; 						// 끝 행번호
		
		//페이지바용 변수
		int sPage = 0; 			// 페이지바에서 시작될 페이지 번호
		int loop = 0; 			//	sPage값이 증가할 때마다 1씩 증가
		int blockSize = 5; 		// 페이지바에 표시될 pageNo의 개수
		

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		
		// 페이징 작업 (총 게시물 수, 총 페이지수)
		// 먼저 총 음식점 수를 구하기
		totalRest = service.getTotalCount(map);
		
		// 페이지바 작업 시작!
		totalPage = (int)Math.ceil( (double) totalRest/sizePerPage );
       //(double)totalCount/sizePerPage 값이 1.1 이면  Math.ceil()은 2.0   Math.ceil()은 double이라서 형변환을 해야한다.
       // 63/5 = 12.xx -> 13.0  이 값이 totalPage 가 된다.
		
		if (pageNo == null) {
			// 게시판 최초로딩시 pageNo은 null이다.
			currPage = 1;
			// 초기화면은 /list.action?pageNo = 1 과 같다.
		} else {
			try {
				currPage = Integer.parseInt(pageNo);
				//get방식으로 넘어온 pageNo을 currPage에 int 캐스팅후 대입한다.
				
				if(currPage < 1 || currPage > totalPage){
					currPage = 1;
				}
				
			} catch (NumberFormatException exeption) {
				currPage = 1;
			}
		}
		
			/* 
		 	## 게시글 페이징 공식
		 	
		 			currPage				start(s)				end(e)
		 	----------------------------------------------------------------
		 			pageNo=1					1						5
		 			pageNo=2					6						10
		 			pageNo=3					11						15
		 			pageNo=4					16						20
		 			pageNo=5					21						25
		 			pageNo=6					26						30
		 	----------------------------------------------------------------	 			
		 */
	
		start = ((currPage - 1) * sizePerPage) +1; //sRowNum
		end= start+ sizePerPage -1 ;//sRowNum : currPage*sizePerPage
		
		
		
		//페이징처리를 위해 start , end 를 map에 담는다.
		map.put("start", String.valueOf(start)); // HashMap 데이터타입에 맞게 int s를 String으로 변경해서 담는다.
		map.put("end", String.valueOf(end));  // HashMap 데이터타입에 맞게 int e를 String으로 변경해서 담는다.
		
		
		List<RestaurantVO> list = service.searchByMetro(map);
		
		//음식점 태그 가져오기
		List<String> restSeqList = new ArrayList<String>();
		
		for (RestaurantVO vo : list) {
			String restSeq = vo.getRestSeq();
			restSeqList.add(restSeq);
		}
		
		List<TagVO> tagList = service.getRestTag(restSeqList);
		
		String pageBar = "";
		pageBar += "<ul>";
		
		/*
		     우리는 위에서 blockSize 를 5로 설정했으므로 
		     아래와 같은 페이지바가 생성되어록 해야 한다.
		     
		     이전 5페이지 [1][2][3][4][5] 다음5페이지
		     이전 5페이지 [6][7][8][9][10] 다음5페이지
		     이전 5페이지 [11][12][13] 다음5페이지  
		     
		      페이지 번호는 1씩 증가하므로 페이지번호를 증가시켜주는 반복변수가 필요하다.
		      이것은 위에서 선언한 loop를 사용한다.
		      이때 loop 는 blockSize 의 크기보다 크면 안된다. 		     
		 */
		loop = 1;
		
		// ## 페이지바의 시작 페이지 번호(sPage)값 만들기(공식) 
		sPage = ( ( currPage - 1 )/blockSize )*blockSize + 1 ;
		/*
		     현재 우리는 blockSize 를 위에서 5로 설정했다.
		     
		     만약에 조회하고자 하는 currPage 가 3페이지 이라면    -- 1페이지부터 5페이지까지는 첫페이지번호가 1
		     sPage = ( ( 3 - 1 )/5 )*5 + 1 ;  ==> 1
		     
		     만약에 조회하고자 하는 currPage 가 5페이지 이라면
		     sPage = ( ( 5 - 1 )/5 )*5 + 1 ;  ==> 1
		     
		     만약에 조회하고자 하는 currPage 가 7페이지 이라면
		     sPage = ( ( 7 - 1 )/5 )*5 + 1 ;  ==> 6
		     
		     만약에 조회하고자 하는 currPage 가 10페이지 이라면
		     sPage = ( ( 10 - 1 )/5 )*5 + 1 ; ==> 6
		     
		     만약에 조회하고자 하는 currPage 가 12페이지 이라면
		     sPage = ( ( 12 - 1 )/5 )*5 + 1 ; ==> 11
		 */
		
		// 이전 5페이지 만들기
		if(!(sPage == 1)) {
				pageBar += String.format("&nbsp;<a href='javascript:searchByMetro(%d)'>pre</a>&nbsp;", sPage-blockSize);
		}
		
		while( !(loop >  blockSize || sPage > totalPage ) ) {
			
			if(sPage == currPage){	// 시작페이지 중에 현재페이지 하나만 <span>		
				pageBar += String.format("&nbsp;<span class='on'> %d </span>&nbsp;", sPage);
			} else{
				
					pageBar += String.format("&nbsp;<a href='javascript:searchByMetro(%d)'>%d</a>&nbsp;", sPage, sPage);
			}
			loop++;
			sPage++;
		}
		
		// 다음 5페이지 만들기
		if(!(sPage > totalPage)) {
				pageBar += String.format("&nbsp;<a href='javascript:searchByMetro(%d)'>next</a>&nbsp;", sPage);		
		}
		
		
		pageBar += ""
				+ "</ul>";
		
		JSONObject jObj = new JSONObject();
		jObj.put("places", list);
		jObj.put("tagList", tagList);
		jObj.put("pageBar", pageBar);
		
		req.setAttribute("jObj", jObj);
		
		return "/maps/json/searchByMetro";
	}
	
	
	//음식점 등록 장소 검색 : 주소 검색 / 클릭으로 주소 얻기
	@RequestMapping(value="/regRestaurant.eat",method={RequestMethod.GET}) 
	public String regRestaurant(){
		return "/maps/regRestaurant";
	}
	
	
	//클러스터러 (clickable) 마우스 이벤트 테스트
	@RequestMapping(value="/clustererTest1.eat",method={RequestMethod.GET}) 
	public String clustererTest1(){
		return "/maps/clustererInfoWindow";
	}
	
	//클러스터러 (clickable) 테스트 : 음식점 목록 가져오기
	@RequestMapping(value="/clusterer.eat",method={RequestMethod.GET}) 
	public String clusterer(){
		return "/maps/clusterer";
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
		return "/maps/addRstr";
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
