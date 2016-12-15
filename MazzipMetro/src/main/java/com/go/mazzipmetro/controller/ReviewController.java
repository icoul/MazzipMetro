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
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.ThemeVO;
import com.go.mazzipmetro.vo.UserAliasVO;
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
		HashMap<String, String> rest= service.getRestaurant(restSeq);
		
		req.setAttribute("rest", rest);
		req.setAttribute("restSeq", restSeq);
		return "/review/reviewAdd";  
		
	}
	
	@RequestMapping(value="/reviewAddEnd.eat", method={RequestMethod.POST})
	public String addRestaurantInfoEnd(ThemeVO tvo, ReviewVO rvo, FileVO fvo, HttpServletRequest req, HttpSession session){
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String[] reviewBgTagArr = req.getParameterValues("reviewBgTag");
		String[] reviewMdTagArr = req.getParameterValues("reviewMdTag");
		String[] themeArr = req.getParameterValues("theme");
		String restSeq = rvo.getRestSeq();
		HashMap<String, String> visitor = new HashMap<String, String>();
		
		if(loginUser != null)
		{
			String UserGender = loginUser.getUserGender();
			String UserBirthday = loginUser.getUserBirthDay();
			
			visitor.put("UserGender", UserGender);
			visitor.put("UserBirthday", UserBirthday);					
		}
		
		if(reviewBgTagArr!=null)
		{
			String reviewBgTag = RestaurantController.arrayToTag(reviewBgTagArr);
			rvo.setReviewBTag(reviewBgTag);
		}
		if(reviewMdTagArr!=null)
		{
			String reviewMdTag = RestaurantController.arrayToTag(reviewMdTagArr);
			rvo.setReviewMTag(reviewMdTag);
		}
		
			
		
		
		
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
				
		// review insert작업 및 alias관련 작업을 trasactional 처리한다.
		List<String> list = service.addReview(rvo, imageList, themeArr, visitor);
		String freeScript = "";
		int result = Integer.parseInt(list.get(list.size()-1));
		
		System.out.println(">>>>>>>>>>>>>>> list.size() ="+ list.size()); 
		System.out.println(">>>>>>>>>>>>>>> result ="+ result);
				
		if(result == 1 && list.size() > 1){
			System.out.println(">>>>>> 글쓰기 성공 & 칭호 갱신!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); 
			result = 1;
			freeScript += "alert('축하합니다.\\n"; // alert개행 문자는 \n 인데, 여기서는 \\n이라 써야 에러가 나지 않는다. 차이는 모르겠다.
			for (int i = 0; i < list.size()-1; i++) {
				freeScript += "\\n"+(i+1)+" : ";
				freeScript += list.get(i);
			}
			freeScript += "\\n\\n"+(list.size()-1)+"가지 칭호를 획득하셨습니다.');";
			//freeScript += " location.href='userReviewAddAfter.eat?restSeq=" + rvo.getRestSeq() + "&userSeq=" + rvo.getUserSeq() + "'; "; //리뷰쓰기를 성공한 후 15포인트와 15EXP를 주고 등급체크를 해서 등급업을 시킨다. self.close();를 하면 안된다
			req.setAttribute("script", "alert('글쓰기 성공');" + freeScript + " location.href='userReviewAddAfter.eat?restSeq=" + rvo.getRestSeq() + "&userSeq=" + rvo.getUserSeq() + "'; opener.location.reload(true); ");
		}else if (result == 1  && list.size() == 1) {
			//freeScript += " location.href='userReviewAddAfter.eat';"; //리뷰쓰기를 성공한 후 15포인트와 15EXP를 주고 등급체크를 해서 등급업을 시킨다.
			System.out.println(">>>>>> 글쓰기 성공 & 갱신할 칭호 없음!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); 
			result = 1;
			
			if(result == 1){
				req.setAttribute("script", "alert('글쓰기 성공 '); location.href='userReviewAddAfter.eat?restSeq=" + rvo.getRestSeq() + "&userSeq=" + rvo.getUserSeq() + "';   opener.location.reload(true); ");
			}
			
		} else if ("0".equals(list.get(list.size()-1))){
			System.out.println(">>>>>> 글쓰기 실패!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); 
			result  = 0;
		} else {
			System.out.println("예외상황 발생!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); 
		}
		
		System.out.println(freeScript); 
		
		/*req.setAttribute("result", result);
		req.setAttribute("freeScript", freeScript);*/	
		return "/user/msgEnd";
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
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("likers", likers);
		
		req.setAttribute("jsonObj", jsonObj);
		return "/review/plusHit";  
		
	}
	
	
}

