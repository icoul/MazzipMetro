package com.go.mazzipmetro.controller;

import java.io.File;
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
import com.go.mazzipmetro.vo.ReviewCommentVO;
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
		int reviewCommentTotalCount = service.getReviewCommentTotalCount(reviewseq);
		
		req.setAttribute("restName", restname);
		req.setAttribute("userName", username);
		req.setAttribute("reviewProfile", reviewprofile);
		req.setAttribute("reviewContent", reviewcontent);
		req.setAttribute("reviewRegDate", reviewregdate);
		req.setAttribute("reviewImageList", reviewImageList);
		req.setAttribute("reviewseq", reviewseq);
		req.setAttribute("reviewCommentTotalCount", reviewCommentTotalCount);
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
		
		// 동현_태그 checkbox 속성 disabled를 위한 배열 생성 
		String[] restBgTagArr = RestaurantController.tagToArray(rest.get("restbgtag"));
		String[] restMdTagArr = RestaurantController.tagToArray(rest.get("restmdtag").replace("고기류", "고기").replace("어폐류", "물고기").replace("채소류", "채소").replace("밥류", "밥").replace("면류", "면"));
		req.setAttribute("restBgTagArr", restBgTagArr);
		req.setAttribute("restMdTagArr", restMdTagArr);
		
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
			String UserBirthday = (loginUser.getUserBirthDay()).substring(2);
			
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
		String newFileName = "";
		byte[] bytes = null;

		try{
			for (int i = 0; i < fvo.getAttach().length; i++) { 
				String path = root + "files"+File.separator+"review";
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
		
		// 동현 추가_추천맛집 (wantToGoStatus = 2)인 경우 대비 세션의 restRecom값 삭제.
		if (result > 0) {
			req.getSession().removeAttribute("restRecom");
		}
		
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
	
	@RequestMapping(value="/insertReviewComment.eat", method={RequestMethod.POST} ) 
	public String insertReviewComment(HttpServletRequest req, HttpSession session) {
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String reviewSeq = req.getParameter("reviewSeq");
		String comment = req.getParameter("comment");
		String commentSeq = req.getParameter("commentSeq");
		String groupNo = req.getParameter("groupNo");
		String depthNo = req.getParameter("depthNo");
		
		int result = 0;
		
		if(commentSeq == null && groupNo == null && depthNo == null){ //원 댓글일떄
			String groupNo1 = service.getReviewCommentMaxGroupNo();
			
			int groupNo2 = Integer.parseInt(groupNo1) + 1;
			
			result = service.insertReviewComment(loginUser.getUserSeq(), reviewSeq, comment, String.valueOf(groupNo2), commentSeq, depthNo);
		
			if(result == 1){
				req.setAttribute("script", "alert('댓글 등록 완료');");
			}else{
				req.setAttribute("script", "alert('댓글 등록 실패');");
			}
			
		}else if(commentSeq != null && groupNo != null && depthNo != null){ //댓글의 댓글일때
			result = service.insertCommmentComment(loginUser.getUserSeq(), reviewSeq, comment, commentSeq, groupNo, Integer.parseInt(depthNo)+1);
			
			if(result == 2){
				req.setAttribute("script", "alert('대댓글 등록 완료');");
			}else{
				req.setAttribute("script", "alert('대댓글 등록 실패');");
			}
		}
		
		int reviewCommentTotalCount = service.getReviewCommentTotalCount(reviewSeq);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("reviewCommentTotalCount", reviewCommentTotalCount);
		
		req.setAttribute("jsonObj", jsonObj);
		return "/review/reviewCommentTotalCountJSON";  
		
	}
	
	@RequestMapping(value="/getReviewComment.eat", method={RequestMethod.GET} ) 
	public String getReviewComment(HttpServletRequest req, HttpSession session) {
		String reviewSeq = req.getParameter("reviewSeq");
		String start = req.getParameter("start");    // 1, 3, 5....
		String len = req.getParameter("len");        // 2개씩   더보기.. 클릭에 보여줄 상품의 갯수 단위크기   
			
		if (start == null) {
			start = "1";
		}
		if (len == null) {
			len = "2";
		}
	
		HashMap<String,String> hashMap = new HashMap<String,String>();
		
		int startRno = Integer.parseInt(start);          // 공식!! 시작 행번호   1               3               5
		int endRno   = startRno+Integer.parseInt(len)-1;
		
		hashMap.put("reviewSeq", reviewSeq);
		hashMap.put("startRno", String.valueOf(startRno));
		hashMap.put("endRno", String.valueOf(endRno));
		List<ReviewCommentVO> reviewCommentList = service.getReviewCommentList(hashMap);
		
		List<JSONObject> reviewCommentListJSON = new ArrayList<JSONObject>();
		for(int i = 0; i < reviewCommentList.size(); ++i){
			String commentSeq = reviewCommentList.get(i).getCommentSeq();
			String userName = reviewCommentList.get(i).getUserName();
			String userProfile = reviewCommentList.get(i).getUserProfile();
			String content = reviewCommentList.get(i).getContent(); 
			String commentCount = reviewCommentList.get(i).getCommentCount(); 
			String groupNo = reviewCommentList.get(i).getGroupno(); 
			String fk_seq = reviewCommentList.get(i).getFk_seq(); 
			String depthNo = reviewCommentList.get(i).getDepthno();
			String agoDay = reviewCommentList.get(i).getAgoDay();
			String agoHour = reviewCommentList.get(i).getAgoHour();
			String agoMinute = reviewCommentList.get(i).getAgoMinute();
			
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("commentSeq", commentSeq);
			jsonObj.put("userName", userName);
			jsonObj.put("userProfile", userProfile);
			jsonObj.put("content", content);
			jsonObj.put("commentCount", commentCount);
			jsonObj.put("groupNo", groupNo);
			jsonObj.put("fk_seq", fk_seq);
			jsonObj.put("depthNo", depthNo);
			jsonObj.put("agoDay", agoDay);
			jsonObj.put("agoHour", agoHour);
			jsonObj.put("agoMinute", agoMinute);
			
			reviewCommentListJSON.add(jsonObj);
		}
		
		
		req.setAttribute("reviewCommentListJSON", reviewCommentListJSON);
		return "/review/getReviewCommentJSON";
	}
	
	@RequestMapping(value="/commentMoreView.eat", method={RequestMethod.GET} ) 
	public String commentMoreView(HttpServletRequest req, HttpSession session) {
		String commentSeq = req.getParameter("commentSeq"); //댓글 번호
		String groupNo2 =  req.getParameter("groupNo"); //댓글의 하나남은 댓글을 지울떄 화면에 삭제되는 갱신을 해주기위해서 쓰는 변수이다.
		List<ReviewCommentVO> commentCommentList = service.getCommentCommentList(commentSeq); //댓글번호를 넘겨주고 그 댓글의 댓글목록을 가져온다.
		
		List<JSONObject> commentCommentListJSON = new ArrayList<JSONObject>();
		for(int i = 0; i < commentCommentList.size(); ++i){
			String commentSeq2 = commentCommentList.get(i).getCommentSeq();
			String userName = commentCommentList.get(i).getUserName();
			String userProfile = commentCommentList.get(i).getUserProfile();
			String content = commentCommentList.get(i).getContent(); 
			String commentCount = commentCommentList.get(i).getCommentCount(); 
			String groupNo = commentCommentList.get(i).getGroupno(); 
			String fk_seq = commentCommentList.get(i).getFk_seq(); 
			String depthNo = commentCommentList.get(i).getDepthno();
			String agoDay = commentCommentList.get(i).getAgoDay();
			String agoHour = commentCommentList.get(i).getAgoHour();
			String agoMinute = commentCommentList.get(i).getAgoMinute();
			
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("commentSeq", commentSeq2);
			jsonObj.put("userName", userName);
			jsonObj.put("userProfile", userProfile);
			jsonObj.put("content", content);
			jsonObj.put("commentCount", commentCount);
			jsonObj.put("groupNo", groupNo);
			jsonObj.put("fk_seq", fk_seq);
			jsonObj.put("depthNo", depthNo);
			jsonObj.put("agoDay", agoDay);
			jsonObj.put("agoHour", agoHour);
			jsonObj.put("agoMinute", agoMinute);
			
			commentCommentListJSON.add(jsonObj);
		}
		
		req.setAttribute("commentCommentListJSON", commentCommentListJSON);
		req.setAttribute("groupNo", groupNo2); //댓글의 하나남은 댓글을 지울때만 해당한다. 
		
		return "/review/getCommentCommentJSON";
	}
	
	@RequestMapping(value="/deleteReviewComment.eat", method={RequestMethod.POST} ) 
	public String deleteReviewComment(HttpServletRequest req, HttpSession session) {
		String commentSeq = req.getParameter("commentSeq");
		String reviewSeq = req.getParameter("reviewSeq");
		String fk_seq = req.getParameter("fk_seq");
		System.out.println("=============================="+commentSeq);
		int commentCount = service.getCommentCount(commentSeq);
		
		
		if(commentCount > 0){ //원댓글에 댓글이 있는경우 : 댓글의 댓글도 지우고 원댓글을 지운다 status = 0
			int result = service.deleteReviewCommentWithComment(commentSeq);
			System.out.println();
			if(result == 2){
				System.out.println("==============================댓글 삭제 성공");
			}else{
				System.out.println("==============================댓글 삭제 실패");
			}
		}else{//원댓글에 댓글이 없는경우, 댓글의 댓글일 경우 :  status = 0
			int result = 0;
			
			if(fk_seq == null){ // 원댓글에서는 fk_seq를 아예 받아오지않는다
				 result = service.deleteReviewComment(commentSeq);
				 
				 if(result == 1){
						System.out.println("==============================댓글 삭제 성공");
					}else{
						System.out.println("==============================댓글 삭제 실패");
					}
			}else{ // 댓글의 댓글에서는 fk_seq를 받아온다
				result = service.deleteCommentComment(commentSeq, fk_seq);
				
				if(result == 2){
					System.out.println("==============================댓글의 댓글 삭제 성공");
				}else{
					System.out.println("==============================댓글의 댓글 삭제 실패");
				}
			}	
		}
		
		if(reviewSeq != null){//댓글을 지울경우, 댓글더보기 버튼의 관련된 totalNewCount를 갱신하기위해서 해준다.
			int reviewCommentTotalCount = service.getReviewCommentTotalCount(reviewSeq);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("reviewCommentTotalCount", reviewCommentTotalCount);
			
			req.setAttribute("jsonObj", jsonObj);
			
			return "/review/reviewCommentTotalCountJSON";
		}else{ //댓글의 댓글을 삭제할 경우, 이 경우에 return을 ""로 적어주면 404 GET 관련 에러가 난다. 아마도 돌아갈 jsp가 없어서 그런듯 하다.
			return "/user/msgEnd";
		}
		
	}
}

