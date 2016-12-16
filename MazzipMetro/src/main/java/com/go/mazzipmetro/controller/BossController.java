package com.go.mazzipmetro.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.BossService;
import com.go.mazzipmetro.service.UserService;
import com.go.mazzipmetro.vo.ContentVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class BossController {
	
	@Autowired
	private BossService service;
	@Autowired
	private UserService userService;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	
	//사업주가 코인을 충전할시 or 광고 구매시
	@RequestMapping(value="/bossCoinResi.eat", method={RequestMethod.GET})
	public String busiCoinResi(HttpServletRequest req) {
		HttpSession ses = req.getSession();
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		
		System.out.println(">>>> 확인용 : loginUser.getUserSeq() ==> " + loginUser.getUserSeq());
		
		List<HashMap<String, String>> list = service.getRestSeq(loginUser.getUserSeq());
		
		req.setAttribute("list", list);
		
		return "boss/bossCoinResi";
		
	}
	
	
	//코인충전 팝업창
	@RequestMapping(value="/bossCoinChar.eat", method={RequestMethod.GET})
	public String coinChar() {
		
		return "boss/bossCoinChar";
		
	}
	
	//코인충전 완료시
	@RequestMapping(value="/bossCoinResiEnd.eat", method={RequestMethod.POST})
	public String bossCoinResiEnd(HttpServletRequest req, HttpSession ses){
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		String str_userPoint = req.getParameter("userPoint");
		
		int userPoint = Integer.parseInt(str_userPoint); 
		
		String userSeq = req.getParameter("userSeq");
		
		map.put("userSeq", userSeq);
		map.put("userPoint", userPoint);
		
		int result = service.coinUpdate(map); 
		
		String msg = "";
		String loc ="javascript:history.back();";
		
		if (result < 0) {
			msg ="코인이 충전되지 않았습니다.";
			loc ="javascript:history.back();";
		}
		
		else if (result > 0) {
			msg ="충전되셨습니다.";
			loc ="javascript:history.back();";
			loginUser = userService.getLoginUser(loginUser.getUserEmail());
			loginUser.setUserPoint(loginUser.getUserPoint());
			ses.setAttribute("loginUser", loginUser);
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "/boss/bossCoinResiEnd";
	}
	
	// 컨텐츠 결제 
	@RequestMapping(value="/bossBannBuy.eat", method={RequestMethod.POST})
	public String bossBannBuy(HttpServletRequest req, HttpSession ses) throws Throwable{
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		
		HashMap<String, String> map = new HashMap<String, String>();
		String userSeq = req.getParameter("userSeq");
		String restSeq = req.getParameter("restSeq");
		String str_userPoint = req.getParameter("userPoint");
		String contentType1 = req.getParameter("contentType1");
		String contentType2 = req.getParameter("contentType2");
		String contentType3 = req.getParameter("contentType3");
		String selectContentType = req.getParameter("selectContentType");
		String contentType = "";
		
		System.out.println("===================="+contentType1);
		System.out.println("===================="+contentType2);
		System.out.println("===================="+contentType3);
		
		map.put("userSeq", userSeq);
		map.put("restSeq", restSeq);
		map.put("userPoint", str_userPoint);
		
		if(contentType1.equals(selectContentType)){
			contentType = contentType1;
			map.put("contentType", contentType);
		}else if(contentType2.equals(selectContentType)){
			contentType = contentType2;
			map.put("contentType", contentType);
		}else if(contentType3.equals(selectContentType)){
			contentType = contentType3;
			map.put("contentType", contentType);
		}
		System.out.println("===================="+contentType);
	
		
		int result=0;
		int userPoint = Integer.parseInt(str_userPoint); 
		int contentPrice = 0;
		
		String msg = "없음";
		String loc ="javascript:history.back();";
		
			if	(contentType.equals("banner")){
				contentPrice=1000000;
			}
			else if (contentType.equals("link")) {
				contentPrice=500000;
			} 
			else if (contentType.equals("rcom"))  {
				contentPrice=300000;
			} 
			
		//포인트잔액이 부족했을시
		if (userPoint < contentPrice) {
			msg ="포인트 잔액이 부족합니다. 코인을 충전하세요.";
			loc ="javascript:history.back();";
		}
		
		else if (userPoint >= contentPrice) {
			result = service.bannBuyUpdate(map);
			result = service.bannInsert(map);
		}
		
		
		if (result < 0) {
			msg ="결제되지 않았습니다.";
			loc ="javascript:history.back();";
		}
		
		else if (result > 0) {
			msg ="결제 되셨습니다.";
			loc ="javascript:location.href='bossCoinResi.eat';";
			
			loginUser = userService.getLoginUser(loginUser.getUserEmail());
			loginUser.setUserPoint(loginUser.getUserPoint());
			ses.setAttribute("loginUser", loginUser);
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		req.setAttribute("restSeq", restSeq);
		
		
		return "boss/bossContentBuy";
		
	}//end of bossBannBuy(HttpServletRequest req) throws Throwable-------------------
	
	
	
	
	
	//컨텐츠 구매목록
	@RequestMapping(value="/bossContentList.eat", method={RequestMethod.GET})
	public String coinList(HttpServletRequest req, HttpSession session) {
		String pageNo = req.getParameter("pageNo");
		
		UserVO loginUser =  (UserVO)session.getAttribute("loginUser");
		String userSeq = loginUser.getUserSeq();
		System.out.println("확인용"+userSeq);
		
		int totalCount = 0;         // 총게시물 건수
		int sizePerPage = 5;        // 한 페이지당 보여줄 게시물 수
		int currentShowPageNo = 1;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함. 
		int totalPage = 0;          // 총 페이지 수(웹브라우저상에 보여줄 총 페이지 갯수) 
		
		int start = 0;              // 시작 행 번호
		int end   = 0;              // 끝 행 번호
		int startPageNo = 0;        // 페이지바에서 시작될 페이지 번호
		
		
		int loop = 0;      // startPageNo 값이 증가할때 마다 1씩 증가하는 용도.
		int blocksize = 5; // "페이지바" 에 보여줄 페이지의 갯수
		
		if(pageNo == null) {
			// 게시판 초기화면에 보여지는 것은
			// req.getParameter("pageNo"); 값이 없으므로
			// pageNo 는 null 이 된다.
			
			currentShowPageNo = 1;
			// 즉, 초기화면은 /list.eat?pageNo=1 로 하겠다는 말이다.
		}
		else{
			currentShowPageNo = Integer.parseInt(pageNo);
			// GET 방식으로 파라미터 pageNo 에 넘어온 값을 
			// 현재 보여주고자 하는 페이지로 설정한다.
		}
		
		start = ((currentShowPageNo - 1) * sizePerPage) + 1;
		end = start + sizePerPage - 1;
		
		session.setAttribute("readCountCheck", "no");
		
		String colName = req.getParameter("colName");
	    String search = req.getParameter("search");
	    
	    HashMap<String, String> map = new HashMap<String, String>();
	    map.put("userSeq", userSeq);
	    
	    map.put("start", String.valueOf(start) );  // 키값 start, 해쉬맵이 String 타입인데 start 는 int 타입이어서 String 타입으로 변경함.  
	    map.put("end", String.valueOf(end) );      // 키값 end,   해쉬맵이 String 타입인데 end 는 int 타입이어서 String 타입으로 변경함.  

		
		List<HashMap<String,String>> list = service.bossConList(map); 
		
		
		for (int i = 0; i < list.size(); i++) {			
			ContentVO contVO = new ContentVO();
			RestaurantVO rvo = new RestaurantVO();
			rvo.setRestName(list.get(i).get("restName"));
			rvo.setGradeName(list.get(i).get("gradeName"));
			rvo.setRestPhone(list.get(i).get("restPhone"));
			rvo.setRestAddr(list.get(i).get("restAddr"));
			
			System.out.println(list.get(i).get("gradeName"));
			System.out.println(list.get(i).get("restPhone"));
			contVO.setItem(rvo);
		}
		
			
		
		
		totalCount = service.getBossConTotal(map);
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);  

	    String pagebar = "";
	    pagebar += "<ul>";
	    
	    
	    loop = 1;
	    
	    // **** !!! 페이지바의 시작 페이지 번호(startPageNo)값 만들기 -- 공식임!!!!
	    startPageNo = ( (currentShowPageNo - 1)/blocksize)*blocksize + 1; 
	    
	 // **** 이전5페이지 만들기 ****
	    if(startPageNo == 1) {
	    	// 첫 페이지바에 도달한 경우
	    	pagebar += String.format("&nbsp;[이전%d페이지]", blocksize);  
	    }
	    else {
	    	// 첫 페이지바가 아닌 두번째 이상 페이지바에 온 경우 
	    	
	    	if(colName == null || search == null) {
				// 검색어가 없는 경우
				pagebar += String.format("&nbsp;<a href='/mazzipmetro/bossContentList.eat?pageNo=%d'>[이전%d페이지]</a>&nbsp;", startPageNo-1, blocksize); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 블럭크기의값 이다.	
			}
	    }
	    
	    
	    // *** 이전5페이지 와 다음5페이지 사이에 들어가는 것을 만드는 것 
	    while( !(loop > blocksize || 
	    		 startPageNo > totalPage) ) {
	    	
	    	if(startPageNo == currentShowPageNo) {
	    		pagebar += String.format("&nbsp;<span style='color:red; font-weight:bold; text-decoration:underline;'>%d</span>&nbsp;", startPageNo);
	    	}
	    	else{
	    		if(colName == null || search == null) {
	    			// 검색어가 없는 경우
	    			pagebar += String.format("&nbsp;<a href='/mazzipmetro/bossContentList.eat?pageNo=%d'>%d</a>&nbsp;", startPageNo, startPageNo); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 페이지바에 나타낼 startPageNo값 이다.	
	    		}
	    	}
	    	
	    	loop++;
	    	startPageNo++;
	    	
	    }// end of while------------------
	    
	    
	    // **** 다음5페이지 만들기 ****
	    if(startPageNo > totalPage) {
	    	// 마지막 페이지바에 도달한 경우
	    	pagebar += String.format("&nbsp;[다음%d페이지]", blocksize); 
	    }
	    else {
	    	// 마지막 페이지바가 아닌 경우 
	    	
	    	if(colName == null || search == null) {
				// 검색어가 없는 경우
				pagebar += String.format("&nbsp;<a href='/mazzipmetro/bossContentList.eat?pageNo=%d'>[다음%d페이지]</a>&nbsp;", startPageNo, blocksize); // 처음 %d 에는 startPageNo값 , 두번째 %d 에는 블럭크기의값 이다.	
			}
	    }
	    
	    
	    
	    pagebar += "</ul>";
	    
		
	    req.setAttribute("list", list);
		req.setAttribute("pagebar", pagebar);
		
		System.out.println("확인용"+pageNo);
		
		return "boss/bossContentList";
		
	}
}