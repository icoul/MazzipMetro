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
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.RestaurantService;

import com.go.mazzipmetro.service.ReviewService;

import com.go.mazzipmetro.vo.MenuVO;

import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.UserVO;
import com.go.mazzipmetro.vo.FileVO;

@Controller
public class RestaurantController {

	@Autowired
	private RestaurantService service; 
	@Autowired
	private ReviewService reviewService; 
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	
	// 업장을 등록하는 메서드
	@RequestMapping(value="/restAdd.eat", method={RequestMethod.GET})
	public String restAdd(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		req.setAttribute("userSeq", loginUser.getUserSeq());
		
		return "restaurant/restAdd";
	}
	
	// 입력한 업장명을 가진 곳이 DB에 존재하는지 확인하기 위해 검색하고 데이터를 가져오는 메서드
	@RequestMapping(value="/restCheck.eat", method={RequestMethod.GET})
	public String restCheck(HttpServletRequest req, HttpServletResponse res){
		
		String name = req.getParameter("name");
		
		List<RestaurantVO> nameList = service.getRestName(name); 

		req.setAttribute("name", name);
		req.setAttribute("nameList", nameList);
		
		return "restaurant/restCheck";
	}
	
	// 업장명이 존재하지 않아 자신이 직접 찾아서 등록하고자 하는 메서드
	@RequestMapping(value="/notRestRegi.eat", method={RequestMethod.GET})
	public String notRestRegi(HttpServletRequest req, HttpServletResponse res){
		
		String name = req.getParameter("name");
		
		req.setAttribute("name", name);
		
		return "restaurant/notRestRegi";
	}
	
	// 업장 정보를 받아서 insert 또는 update 시켜주는 메서드
	@RequestMapping(value="/restRegister.eat", method={RequestMethod.POST})
	public String restRegister(HttpServletRequest req, HttpServletResponse res, FileVO fvo){
		
		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		String restSeq = req.getParameter("seq");
		String restName = req.getParameter("name");
		String restAddr = req.getParameter("addr");
		String restNewAddr = req.getParameter("newAddr");
		String restPhone = req.getParameter("phone");
		String restLatitude = req.getParameter("latitude");
		String restLongitude = req.getParameter("longitude");
		String metroId = req.getParameter("metroId");
		String dongId = req.getParameter("dongId");
		String userSeq = loginUser.getUserSeq();
		
		int result = 0;
		
		// 업장 소개이미지 파일 업로드 및 파일명 배열에 저장하기
		
		String root = session.getServletContext().getRealPath("/");
		String path = root + "files";
		
		String newFileName = "";
		byte[] bytes = null;
			
	
		try{
				
				bytes = fvo.getAttach()[0].getBytes();
				newFileName = fileManager.doFileUpload(bytes, fvo.getAttach()[0].getOriginalFilename(), path);
				thumbnailManager.doCreateThumbnail(newFileName, path);
				
		}catch (Exception e) {
			e.printStackTrace();
		} 
		
		RestaurantVO vo = new RestaurantVO();
		
		vo.setRestSeq(restSeq);
		vo.setRestName(restName);
		vo.setUserSeq(userSeq);
		vo.setRestImg(newFileName);
		vo.setRestAddr(restAddr);
		vo.setRestNewAddr(restNewAddr);
		vo.setRestPhone(restPhone);
		vo.setRestLatitude(restLatitude);
		vo.setRestLongitude(restLongitude);
		vo.setMetroId(metroId);
		vo.setDongId(dongId);
		
		if (restSeq.equals("-1")) { // 새 업장 등록
			result = service.setRestRegister(vo);
			String newSeq = service.getNewRestSeq(vo.getUserSeq()); // 업장을 새로 등록했기 때문에 Seq번호를 새로 가져오기 위함.
			vo.setRestSeq(newSeq);
		}
		
		if (!restSeq.equals("-1")) { // 기존 업장 업데이트
			result = service.setRestUpdate(vo);
		}
		
		req.setAttribute("restSeq", vo.getRestSeq());
		req.setAttribute("result", result);
		
		return "restaurant/restRegister";
	}
	
	@RequestMapping(value="/restAddInfo.eat", method={RequestMethod.GET})
	public String restAddInfo(HttpServletRequest req, HttpServletResponse res){
		
		String restSeq = req.getParameter("restSeq");
		
		req.setAttribute("restSeq", restSeq);
		
		return "restaurant/restAddInfo";
	}
	

	//음식점의 상세페이지 보여주기 no
	@RequestMapping(value = "/restaurantDetail.eat", method = RequestMethod.GET)
	public String restaurantDetail(HttpServletRequest req, HttpServletResponse res) {
		String restSeq = req.getParameter("restSeq");
		
		HashMap<String,String> restvo = service.getRestaurant(restSeq);
			
		List<HashMap<String,String>> reviewList = reviewService.getReviewList(restvo.get("restseq"));
		
		List<HashMap<String,String>> reviewImageList = reviewService.getReviewImageList();
		
		List<HashMap<String,String>> agelineChartList = reviewService.getAgeLineChartList(restSeq);
		List<HashMap<String,String>> genderChartList = reviewService.getGenderChartList(restSeq);
		
		String start = req.getParameter("start");    // 1, 3, 5....
		String len = req.getParameter("len");        // 2개씩   더보기.. 클릭에 보여줄 상품의 갯수 단위크기   
		String pspec = req.getParameter("pspec");    // 
		
		if (start == null) {
			start = "1";
		}
		if (len == null) {
			len = "5";
		}
		if (pspec == null) {
			pspec = "NEW";
		}
		
		int startRno = Integer.parseInt(start);          // 공식!! 시작 행번호   1               3               5
		int endRno   = startRno+Integer.parseInt(len)-1; // 공식!! 끝 행번호     1+2-1(==2)      3+2-1(==4)      5+2-1(==6)
		
		String StartRno = String.valueOf(startRno);
		String EndRno = String.valueOf(endRno);
		
		System.out.println("확인용 DisplayJSONAction.java       start : " + start);   // 확인용
		System.out.println("확인용 DisplayJSONAction.java       len : " + len);       // 확인용
		System.out.println("확인용 DisplayJSONAction.java       pspec : " + pspec);   // 확인용

		
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("restSeq", restSeq);
		map.put("pspec", pspec);
		map.put("StartRno", StartRno);
		map.put("EndRno", EndRno);
				
		//List<JSONObject> ListOfReview = service.getReviewList(map);
		
		//req.setAttribute("ListOfReview",  ListOfReview);
		
		////////////////////////////////////////////////////////////////////////////
		//System.out.println("확인용 DisplayJSONAction.java       productList size : " + ListOfReview.size()); // 확인용				
				
		
		req.setAttribute("restvo", restvo);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("reviewImageList", reviewImageList);
		req.setAttribute("agelineChartList", agelineChartList);
		req.setAttribute("genderChartList", genderChartList);
		return "restaurant/restaurantDetail";
	}
	
	@RequestMapping(value="/restAddInfoEnd.eat", method={RequestMethod.POST})
	public String restAddInfoEnd(HttpServletRequest req, HttpServletResponse res, MenuVO mvo, FileVO fvo, HttpSession session){
		
		String restSeq = req.getParameter("restSeq"); // 해당 업장 번호
		String fileNum_Seq = req.getParameter("fileNum");
		int fileNum = Integer.parseInt(fileNum_Seq);
				
		String restContent = req.getParameter("content"); // 메뉴설명글
		String bgCat = req.getParameter("bgCat");	  // 대분류
		String[] mdCat = req.getParameterValues("mdCat"); // 중분류
		
		String menuNum_Str = req.getParameter("menuNum"); // 추가한 메뉴의 갯수
		int menuNum = Integer.parseInt(menuNum_Str); // 메뉴의 갯수를 int로..
		
		ArrayList<String> menuEventArray = new ArrayList<String>(); // 메뉴이벤트를 넣어주기 위해 받아온 값을 저장할 ArrayList
		
		// 업장 소개이미지 파일 업로드 및 파일명 배열에 저장하기
		
			ArrayList<String> imageList = new ArrayList<String>();	
			
			String root = session.getServletContext().getRealPath("/");
			String path = root + "files";
			
			String newFileName = "";
			byte[] bytes = null;
			

		if (fileNum > 0) {	
			try{
				for (int i = 0; i < fvo.getAttach().length; i++) {
					
					bytes = fvo.getAttach()[i].getBytes();
					newFileName = fileManager.doFileUpload(bytes, fvo.getAttach()[i].getOriginalFilename(), path);
					thumbnailManager.doCreateThumbnail(newFileName, path);
					
					imageList.add(newFileName);
				}
			}catch (Exception e) {
				e.printStackTrace();
			} 
		}// 완료
		
		
		// 메뉴 이미지 업로드하기
		String[] menuImgList = new String[menuNum];
		
		try{
			for (int i = 0; i < mvo.getMenuImgFile().length; i++) {
				
				if (mvo.getMenuImgFile()[i].equals(null)) {
					bytes = mvo.getMenuImgFile()[i].getBytes();
					newFileName = fileManager.doFileUpload(bytes, mvo.getMenuImgFile()[i].getOriginalFilename(), path);
					thumbnailManager.doCreateThumbnail(newFileName, path);
				}
				
				menuImgList[i] = newFileName;
			}
		}catch (Exception e) {
			e.printStackTrace();
		} 
		
		mvo.setMenuImg(menuImgList);
		// 완료
		
		for (int i = 0; i < menuNum; i++) {// 받아온 이벤트 값을 ArrayList에 차례대로 저장
			String menuEvent = req.getParameter("menuEvent"+i);
			menuEventArray.add(menuEvent);
		}
		
		// 저장한 ArrayList를 VO에 넣기 위해 배열로 바꾸고 VO에 입력
		String[] menuEventList = menuEventArray.toArray(new String[menuEventArray.size()]);
		mvo.setMenuEvent(menuEventList);
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("restSeq", restSeq);
		map.put("restContent", restContent);
		map.put("bgCat", bgCat);
		
		int result = 0;
		
		// 업장 세부정보 등록(소개글, 이미지, 태그)
		result = service.setRestaurantInfo(map, imageList, mdCat, mvo, menuNum);
		// (정보를 담은 Hashmap, 소개이미지 리스트 imageList, 중분류 배열, mdCat, 메뉴VO mvo, 메뉴갯수 menuNum) 
		
		int endNum = 2 + imageList.size() + mdCat.length + menuNum;
		
		String msg = "실패했습니다";
		
		if (result == endNum) {
			msg = "정보등록을 성공했습니다";
		}
		
		req.setAttribute("result", result);
		req.setAttribute("msg", msg);
		
		return "restaurant/restAddInfoEnd";

	}
	
	// 업장 정보를 수정하기 위해 업장 리스트를 불러오는 메서드
	@RequestMapping(value="/restEdit.eat", method={RequestMethod.GET})
	public String restEdit(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String userSeq = loginUser.getUserSeq();
				
		List<RestaurantVO> restList = service.getRestList(userSeq);
		
		req.setAttribute("restList", restList);
		
		return "restaurant/restEdit";
	}
	
	// 수정할 업장을 선택해서 해당 업장의 수정창을 띄우는 메서드
	@RequestMapping(value="/restEditEnd.eat", method={RequestMethod.GET})
	public String restEditEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session){

		String restSeq = req.getParameter("restSeq");
		
		req.setAttribute("restSeq", restSeq);
		
		return "restaurant/restEditEnd";
	}
	
	// 업장 정보를 수정하기 위해 업장 리스트를 불러오는 메서드
	@RequestMapping(value="/restDel.eat", method={RequestMethod.POST})
	public String restDel(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		String restSeq = req.getParameter("restSeq");
		
		req.setAttribute("restSeq", restSeq);
		
		return "restaurant/restDel";
	}
}

