package com.go.mazzipmetro.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.ReviewService;
import com.go.mazzipmetro.vo.AttachFileVO;
import com.go.mazzipmetro.vo.FileVO;
import com.go.mazzipmetro.vo.MenuVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	
	@RequestMapping(value = "/reviewModal.eat", method = RequestMethod.GET)
	public String reviewModal(HttpServletRequest req) {
		String reviewseq = req.getParameter("reviewseq");
		String restname = req.getParameter("restname");
		String username = req.getParameter("username");
		String reviewprofile = req.getParameter("reviewprofile");
		String reviewcontent = req.getParameter("reviewcontent");
		String reviewregdate = req.getParameter("reviewregdate");

		List<HashMap<String,String>> reviewImageList = service.getReviewImageList(reviewseq);
		
		
		req.setAttribute("restName", restname);
		req.setAttribute("userName", username);
		req.setAttribute("reviewProfile", reviewprofile);
		req.setAttribute("reviewContent", reviewcontent);
		req.setAttribute("reviewRegDate", reviewregdate);
		req.setAttribute("reviewImageList", reviewImageList);
		
		return "review/reviewModal";
	}
	
	
	@RequestMapping(value = "/getLargeReviewImageName.eat", method = RequestMethod.GET)
	public String getLargeReviewImageName(HttpServletRequest req) {
		String revimgseq = req.getParameter("revimgseq");
		
		String reviewImageName = service.getLargeReviewImageName(revimgseq);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("reviewImageName", reviewImageName);
		
		req.setAttribute("jsonObj", jsonObj);
		return "review/largeReviewImgNameJSON";
	}
	
	@RequestMapping(value="/reviewAdd.eat", method={RequestMethod.GET} ) 
	public String reviewAdd(HttpServletRequest req, HttpSession ses) {
		String restSeq = req.getParameter("restSeq");
			
		
		
		req.setAttribute("restSeq", restSeq);
		return "/review/reviewAdd";  
		
	}
	
	@RequestMapping(value="/reviewAddEnd.eat", method={RequestMethod.POST})
	public String addRestaurantInfoEnd(ReviewVO rvo, FileVO fvo, HttpServletRequest req, HttpSession session){
		
		System.out.println(">>> score @ reviewController : "+rvo.getReviewAvgScore());
		// 이미지 파일 업로드 및 파일명 배열에 저장하기
		ArrayList<String> imageList = new ArrayList<String>();	
		
		String root = session.getServletContext().getRealPath("/");
		String path = root + "files";
		
		String newFileName = "";
		byte[] bytes = null;

		try{
			for (int i = 0; i < fvo.getAttach().length; i++) {
				
				bytes = fvo.getAttach()[i].getBytes();
				newFileName = fileManager.doFileUpload(bytes, fvo.getAttach()[i].getOriginalFilename(), path);
				thumbnailManager.doCreateThumbnail(newFileName, path);
				
				imageList.add(newFileName);
			}
		}catch (Exception e) {
			e.printStackTrace();
		} // 완료
		
		int result = service.addReview(rvo,imageList);
		
		req.setAttribute("result", result);
				
		return "/review/reviewAddEnd";
	}
	
	@RequestMapping(value="/plusHit.eat", method={RequestMethod.GET} ) 
	public String plusHit(HttpServletRequest req) {
		String reviewSeq = req.getParameter("reviewSeq");
		
		int reviewHit = service.plusHit(reviewSeq);
		
		if(reviewHit == 1)
		{
			reviewHit = service.getHitScore(reviewSeq);
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("reviewHit", reviewHit);
		
		req.setAttribute("jsonObj", jsonObj);
		return "/review/plusHit";  
		
	}
	
	@RequestMapping(value="/DownHit.eat", method={RequestMethod.GET} ) 
	public String DownHit(HttpServletRequest req, HttpSession ses) {
		String reviewSeq = req.getParameter("reviewSeq");
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		String UserSeq = loginUser.getUserSeq();
		
		int delLiker = service.delLiker(reviewSeq, UserSeq);
		
		if(delLiker == 2)
		{
			delLiker = service.getHitScore(reviewSeq);
			
			System.out.println(delLiker);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("delLiker", delLiker);
			
			req.setAttribute("jsonObj", jsonObj);
			return "/review/plusHit";
		}
		else
		{	
			String msg = "실패했습니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			return "msg";
		}
		
	}
	
	@RequestMapping(value="/insertLiker.eat", method={RequestMethod.GET} ) 
	public String insertLiker(HttpServletRequest req, HttpSession ses) {
		
		UserVO loginUser = (UserVO)ses.getAttribute("loginUser");
		String UserSeq = loginUser.getUserSeq();
		String reviewSeq = req.getParameter("reviewSeq");
		List<String> likers = new ArrayList<String>();
		
		HashMap<String, String> map = new HashMap<String,String>();
		
		map.put("UserSeq", UserSeq);
		map.put("reviewSeq", reviewSeq);
		
		
		int reviewHit = service.insertLiker(map);
		
		if(reviewHit == 1)
		{
			likers = service.getLikers(UserSeq);	
		}
		
		System.out.println("UserSeq"+UserSeq);
		System.out.println("dddddddddddddddddddddddddd"+likers+"dddddddddddddddddddddddddddd");
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("likers", likers);
		
		req.setAttribute("jsonObj", jsonObj);
		return "/review/plusHit";  
		
	}
	
	
}

