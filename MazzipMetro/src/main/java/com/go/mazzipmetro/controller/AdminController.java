package com.go.mazzipmetro.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.AdminService;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class AdminController {

	@Autowired
	private AdminService service;
	
	//회원리스트
	@RequestMapping(value="/adminUserList.eat", method={RequestMethod.GET})
	public String adminUserList(HttpServletRequest req, HttpSession session) {
		
		String pageNo = req.getParameter("pageNo");
		
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
		
		String colName = req.getParameter("colname");
	    String search = req.getParameter("search");
	    
	    HashMap<String, String> map = new HashMap<String, String>();
	    map.put("colName", colName);
	    map.put("search", search);
	    
	    
	    map.put("start", String.valueOf(start) );  // 키값 start, 해쉬맵이 String 타입인데 start 는 int 타입이어서 String 타입으로 변경함.  
	    map.put("end", String.valueOf(end) );      // 키값 end,   해쉬맵이 String 타입인데 end 는 int 타입이어서 String 타입으로 변경함.  

		
		List<UserVO> list = service.list(map); 
		
		totalCount = service.getTotalCount(map);
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);  

	    String pagebar = "";
	    pagebar += "<ul>";
	    
	    
	    loop = 1;
	    
	    // **** !!! 페이지바의 시작 페이지 번호(startPageNo)값 만들기 -- 공식임!!!!
	    startPageNo = ( (currentShowPageNo - 1)/blocksize)*blocksize + 1; 
	    
	    while( !(loop > blocksize || 
	    		 startPageNo > totalPage) ) {
	    	
	    	if(startPageNo == currentShowPageNo) {
	    		pagebar += String.format("&nbsp;<span style='color:red; font-weight:bold; text-decoration:underline;'>%d</span>&nbsp;", startPageNo);
	    	}
	    	else{
	    		pagebar += String.format("&nbsp;<a href=''>%d</a>&nbsp;", startPageNo);
	    	}
	    	
	    	loop++;
	    	startPageNo++;
	    }
	    
	    
	    pagebar += "</ul>";
	    
		
	    req.setAttribute("list", list);
		req.setAttribute("colName", colName);
		req.setAttribute("search", search);
		req.setAttribute("pagebar", pagebar);
		
		return "/admin/adminUserList";
		
		
		
	}

	@RequestMapping(value = "/adminQna.eat", method = RequestMethod.GET)
	public String qna(HttpServletRequest req) {
		
		
		return "admin/adminQna";
	}
}
