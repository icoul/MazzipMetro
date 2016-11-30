package com.go.mazzipmetro.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.ReviewService;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;

	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	// 동현 imgCrop test
	@RequestMapping(value="/imgCrop.eat",method={RequestMethod.GET}) 
	public String imgCrop(){
		return "/img/imgCrop";
	}

	// restSeq로 하나의 업장을 가져오기
	@RequestMapping(value = "/restaurantDetail.eat", method = RequestMethod.GET)
	public String restaurantDetail(HttpServletRequest req) {
		String restSeq = req.getParameter("restSeq");
		
		if(restSeq == null){
			restSeq = "220";
		}
		HashMap<String,String> restvo = service.getRestaurant(restSeq);
			
		List<HashMap<String,String>> reviewList = service.getReviewList(restvo.get("restseq"));
		
		List<HashMap<String,String>> reviewImageList = service.getReviewImageList();
		
		List<HashMap<String,String>> agelineChartList = service.getAgeLineChartList(restSeq);
		List<HashMap<String,String>> genderChartList = service.getGenderChartList(restSeq);
		
		req.setAttribute("restvo", restvo);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("reviewImageList", reviewImageList);
		req.setAttribute("agelineChartList", agelineChartList);
		req.setAttribute("genderChartList", genderChartList);
		return "restaurantDetail";
	}
	
	@RequestMapping(value = "/reviewModal.eat", method = RequestMethod.GET)
	public String reviewModal(HttpServletRequest req) {
		String reviewseq = req.getParameter("reviewseq");
		String restname = req.getParameter("restname");
		String username = req.getParameter("username");
		String reviewprofile = req.getParameter("reviewprofile");
		String reviewcontent = req.getParameter("reviewcontent");
		String reviewregdate = req.getParameter("reviewregdate");

		List<HashMap<String,String>> reviewImageList = service.getReviewImageList(reviewseq);
		
		
		req.setAttribute("restname", restname);
		req.setAttribute("username", username);
		req.setAttribute("reviewprofile", reviewprofile);
		req.setAttribute("reviewcontent", reviewcontent);
		req.setAttribute("reviewregdate", reviewregdate);
		req.setAttribute("reviewImageList", reviewImageList);
		
		return "reviewModal";
	}
	
	
	@RequestMapping(value = "/getLargeReviewImageName.eat", method = RequestMethod.GET)
	public String getLargeReviewImageName(HttpServletRequest req) {
		String revimgseq = req.getParameter("revimgseq");
		
		String reviewImageName = service.getLargeReviewImageName(revimgseq);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("reviewImageName", reviewImageName);
		
		req.setAttribute("jsonObj", jsonObj);
		return "largeReviewImgNameJSON";
	}
}
