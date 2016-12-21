package com.go.mazzipmetro.controller;


import java.net.InetAddress;
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

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.RestaurantService;
import com.go.mazzipmetro.service.ReviewService;
import com.go.mazzipmetro.vo.FileVO;
import com.go.mazzipmetro.vo.MenuVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;

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
		
		//List<String> metroId = service.getMetroId();
		
		req.setAttribute("name", name);
		//req.setAttribute("metroId", metroId);
		
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
		
		// 배열로 들어온 태그들 하나로 묶어서 VO에 넣기
		String[] BgTagArr = req.getParameterValues("restBgTag");
		String[] MdTagArr = req.getParameterValues("restMdTag");
		
		String restBgTag = arrayToTag(BgTagArr);
		String restMdTag = arrayToTag(MdTagArr);
		
		int result = 0;
		
		// 업장 소개이미지 파일 업로드 및 파일명 배열에 저장하기
		
		String root = session.getServletContext().getRealPath("/");
		String path = root + "files/restaurant";
		
		String newFileName = "";
		byte[] bytes = null;
	
		try{
				
			bytes = fvo.getAttach()[0].getBytes();
			newFileName = fileManager.doFileUpload(bytes, fvo.getAttach()[0].getOriginalFilename(), path);
			path += "/thumb";
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
		vo.setRestBgTag(restBgTag);
		vo.setRestMdTag(restMdTag);
		
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
	@SuppressWarnings("unchecked")// unchecked cast대비 annotation
	@RequestMapping(value = "/restaurantDetail.eat", method = RequestMethod.GET)
	public String resDetail(HttpServletRequest req, HttpServletResponse res, HttpSession ses) {
		String restSeq = req.getParameter("restSeq");
		InetAddress ip = null;
		List<String> newRestSeqList = null;
		
		// ip 주소 얻어오기
		try {           
			ip = InetAddress.getLocalHost();  
			System.out.println("Host Name = [" + ip.getHostName() + "]");
			System.out.println("Host Address = [" + ip.getHostAddress() + "]");
			System.out.println(" RemoteAddr = [" + req.getRemoteAddr() + "]");
			System.out.println(" RemoteHost = [" + req.getRemoteHost() + "]");
			System.out.println(" X-Forwarded-For: " + req.getHeader("x-forwarded-for") + "]");
			/*
			 	Host Name = [nobodjs-MacBook-Pro.local]
				Host Address = [218.38.137.28]
				 RemoteAddr = [0:0:0:0:0:0:0:1]
				 RemoteHost = [0:0:0:0:0:0:0:1]
				 X-Forwarded-For: null]
			 */
		}      
		catch (Exception e) {    
			System.out.println(e);     
		}   
		
		List<String> restSeqList = (List<String>)ses.getAttribute(ip.getHostAddress());
		boolean flag = false;
		
		// 처음 restaurantDetail 페이지 접속시
		if(restSeqList == null){
			
			System.out.println(">>>>>>처음 restaurantDetail 페이지 접속시 : 세션 생성 요청"); 
			newRestSeqList = new ArrayList<>();
			newRestSeqList.add(restSeq);
			ses.setAttribute( ip.getHostAddress(), newRestSeqList);
			
			int result = service.updateRestVisitor(restSeq);		
			System.out.println(">>>>>>>>>>>>>>> 조회수 증가 "+((result > 0 )?"성공":"실패")); 
			
		} else {// restaurantDetail 페이지에 다수번 접속시
			
			System.out.println(">>>>>>>>>>>>>>>>>restSeqList = "+restSeqList); 
			for (String str : restSeqList) {
				if (str.equals(restSeq)) {
					flag = true;
				} 
			}// end of for (String str : restSeqList)
			
			// 해당 restSeq가 없다면.
			if (!flag) {
				// 조회수 증가 요청
				System.out.println(">>>>>>조회수 증가 요청"); 
				int result = service.updateRestVisitor(restSeq);	
				
				restSeqList.add(restSeq);
				// 참조형이라, 새로 set할 필요없음.
				//ses.setAttribute( ip.getHostAddress(), newRestSeqList);
				
				System.out.println(">>>>>>>>>>>>>>> 조회수 증가 "+((result > 0 )?"성공":"실패")); 
			}
			
		} // end of if(restSeqList == null) ~ else
		
		
		HashMap<String,String> restvo = service.getRestaurant(restSeq);
		
//		List<HashMap<String,String>> reviewList = reviewService.getReviewList(restvo.get("restseq"));
		
		List<HashMap<String,String>> agelineChartList = reviewService.getAgeLineChartList(restSeq);
		List<HashMap<String,String>> genderChartList = reviewService.getGenderChartList(restSeq);
		

		List<String> restThemeList = service.getRestThemeList(restSeq); //한 음식점의 테마를 restSeq를 통해 가져온다.
		HashMap<String,String> reviewAvgScore =  reviewService.getReviewAvgScore(restSeq); //한 업장의 분위기, 가격, 서비스, 맛 , 총 평점의 평점을 가져온다.
		
		//은석 음식점상세페이지에서 음식점 사진들 
		List<String> restImageList = service.getRestImageList(restSeq);
		
		req.setAttribute("restSeq", restSeq);
		req.setAttribute("restvo", restvo);
		req.setAttribute("agelineChartList", agelineChartList);
		req.setAttribute("genderChartList", genderChartList);
		req.setAttribute("restThemeList", restThemeList);
		req.setAttribute("reviewAvgScore", reviewAvgScore);
		req.setAttribute("restImageList", restImageList);
		return "restaurant/restaurantDetail";
	}
	
	@RequestMapping(value="/restAddInfoEnd.eat", method={RequestMethod.POST})
	public String restAddInfoEnd(HttpServletRequest req, HttpServletResponse res, MenuVO mvo, FileVO fvo, HttpSession session){
		
		String restSeq = req.getParameter("restSeq"); // 해당 업장 번호
		String fileNum_Seq = req.getParameter("fileNum");
		int fileNum = Integer.parseInt(fileNum_Seq);
				
		String restContent = req.getParameter("content"); // 메뉴설명글
		
		String menuNum_Str = req.getParameter("menuNum"); // 추가한 메뉴의 갯수
		int menuNum = Integer.parseInt(menuNum_Str); // 메뉴의 갯수를 int로..
		
		ArrayList<String> menuEventArray = new ArrayList<String>(); // 메뉴이벤트를 넣어주기 위해 받아온 값을 저장할 ArrayList
		
		// 업장 소개이미지 파일 업로드 및 파일명 배열에 저장하기
		
			ArrayList<String> imageList = new ArrayList<String>();	
			
			String root = session.getServletContext().getRealPath("/");
			String path = root + "files/restaurant";
			
			String newFileName = "";
			byte[] bytes = null;
			

		if (fileNum > 0) {	
			try{
				for (int i = 0; i < fvo.getAttach().length; i++) {
					path = root + "files/restaurant";
					bytes = fvo.getAttach()[i].getBytes();
					newFileName = fileManager.doFileUpload(bytes, fvo.getAttach()[i].getOriginalFilename(), path);
					path += "/thumb";
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
				path = root + "files/menu";
				if (mvo.getMenuImgFile()[i].equals(null)) {
					bytes = mvo.getMenuImgFile()[i].getBytes();
					newFileName = fileManager.doFileUpload(bytes, mvo.getMenuImgFile()[i].getOriginalFilename(), path);
					path += "/thumb";
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
		
		int result = 0;
		
		// 업장 세부정보 등록(소개글, 이미지, 태그)
		result = service.setRestaurantInfo(map, imageList, mvo, menuNum);
		// (정보를 담은 Hashmap, 소개이미지 리스트 imageList, 메뉴VO mvo, 메뉴갯수 menuNum) 
		
		int endNum = 1 + imageList.size() + menuNum;
		
		String msg = "실패했습니다";
		
		if (result == endNum) {
			msg = "정보등록을 성공했습니다";
		}
		
		req.setAttribute("result", result);
		req.setAttribute("msg", msg);
		
		return "restaurant/restAddInfoEnd";

	}
	
	// 업장 리스트를 불러오는 메서드
	@RequestMapping(value="/restList.eat", method={RequestMethod.GET})
	public String restList(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String userSeq = loginUser.getUserSeq();
				
		List<RestaurantVO> restList = service.getRestList(userSeq);
		
		req.setAttribute("restList", restList);
		
		return "restaurant/restList";
	}
	
	// 업장 리스트를 불러오는 메서드
	@RequestMapping(value="/myPageRestList.eat", method={RequestMethod.GET})
	public String myPageRestList(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String userSeq = loginUser.getUserSeq();
				
		List<RestaurantVO> restList = service.getRestList(userSeq);
		
		req.setAttribute("restList", restList);
		
		return "restaurant/myPageRestList";
	}
	
	// 메뉴 리스트를 불러오는 메서드
	@RequestMapping(value="/restMenuList.eat", method={RequestMethod.POST})
	public String restMenuList(HttpServletRequest req, HttpServletResponse res, HttpSession session){

		String restSeq = req.getParameter("restSeq");
		
		List<HashMap<String, String>> menuList = service.getMenuList(restSeq);
		
		req.setAttribute("menuList", menuList);
		
		return "restaurant/restMenuList";
	}
	
	// 메뉴 수정 페이지로 이동하는 메서드
	@RequestMapping(value="/restMenuEdit.eat", method={RequestMethod.POST})
	public String restMenuEdit(HttpServletRequest req, HttpServletResponse res, HttpSession session){

		String restSeq = req.getParameter("restSeq");
		
		List<HashMap<String, String>> menuList = service.getMenuList(restSeq);
		
		req.setAttribute("menuList", menuList);
		req.setAttribute("restSeq", restSeq);
		
		return "restaurant/restMenuEdit";
	}
	
	// 데이터를 받아 메뉴를 수정해주는 메서드
	@RequestMapping(value="/restMenuEditEnd.eat", method={RequestMethod.POST})
	public String restMenuEditEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session, MenuVO mvo, FileVO fvo){

		String addMenuNum_str = req.getParameter("addMenuNum");
		String[] menuImg = req.getParameterValues("menuImg");
		
		for (int i = 0; i < fvo.getAttach().length; i++) {
			System.out.println(menuImg[i]);
			System.out.println(fvo.getAttach()[i]);
			System.out.println(fvo.getAttach().length);
		}
		
		int addMenuNum = Integer.parseInt(addMenuNum_str);
		
		ArrayList<String> menuEventArray = new ArrayList<String>(); // 메뉴이벤트를 넣어주기 위해 받아온 값을 저장할 ArrayList
		
		// 메뉴 이미지 업로드하기
		String root = session.getServletContext().getRealPath("/");
		String path = root + "files/menu";
		
		String newFileName = "";
		byte[] bytes = null;
		
		String[] menuImgList = new String[addMenuNum];
		
		try{
			for (int i = 0; i < fvo.getAttach().length; i++) {
				path = root + "files/menu";
				bytes = fvo.getAttach()[i].getBytes();
				newFileName = fileManager.doFileUpload(bytes, fvo.getAttach()[i].getOriginalFilename(), path);
				
				
				if (newFileName == null && menuImg[i] == null) {
					newFileName = "noImage.jpg";
				}
				
				if (newFileName == null && menuImg[i] != null) {
					newFileName = menuImg[i];
					thumbnailManager.doCreateThumbnail(newFileName, path);
				}
				
				if (newFileName != null) {
					thumbnailManager.doCreateThumbnail(newFileName, path);
				}
				
				menuImgList[i] = newFileName;
			}
		}catch (Exception e) {
			e.printStackTrace();
		} 
		
		mvo.setMenuImg(menuImgList);
		//완료
		
		for (int i = 0; i < addMenuNum; i++) {// 받아온 이벤트 값을 ArrayList에 차례대로 저장
			String menuEvent = req.getParameter("menuEvent"+i);
			menuEventArray.add(menuEvent);
		}
		
		// 저장한 ArrayList를 VO에 넣기 위해 배열로 바꾸고 VO에 입력
		String[] menuEventList = menuEventArray.toArray(new String[menuEventArray.size()]);
		mvo.setMenuEvent(menuEventList);
		
		int result = 0;
		
		// 업장 세부정보 등록(소개글, 이미지, 태그)
		result = service.editRestMenu(mvo);
		// (정보를 담은 Hashmap, 소개이미지 리스트 imageList, 중분류 배열, mdCat, 메뉴VO mvo, 메뉴갯수 menuNum) 
		
		int endNum = menuEventArray.size();
		
		String msg = "실패했습니다";
		
		if (result == endNum) {
			msg = "메뉴수정을 성공했습니다";
		}
		
		req.setAttribute("result", result);
		req.setAttribute("msg", msg);
		
		return "restaurant/restAddInfoEnd";
	}
	
	// 수정할 업장을 선택해서 해당 업장의 수정창을 띄우는 메서드
	@RequestMapping(value="/restEdit.eat", method={RequestMethod.POST})
	public String restEdit(HttpServletRequest req, HttpServletResponse res, HttpSession session){

		String restSeq = req.getParameter("restSeq");
		
		RestaurantVO vo = service.getOneRestInfo(restSeq);
		
		String bgTag = vo.getRestBgTag();
		String mdTag = vo.getRestMdTag();
		
		if (bgTag != null && mdTag != null) {
			String[] bgTagArr = tagToArray(bgTag);
			String[] mdTagArr = tagToArray(mdTag);
			
			req.setAttribute("bgTagArr", bgTagArr);
			req.setAttribute("mdTagArr", mdTagArr);
		}
		
		req.setAttribute("vo", vo);
		
		return "restaurant/restEdit";
	}
	
	// 업장 수정 메서드
	@RequestMapping(value="/restEditEnd.eat", method={RequestMethod.POST})
	public String restEditEnd(HttpServletRequest req, HttpServletResponse res, HttpSession session, RestaurantVO rvo, FileVO fvo){

		// 배열로 들어온 태그들 하나로 묶어서 VO에 넣기
		String[] BgTagArr = req.getParameterValues("restBgTag");
		String[] MdTagArr = req.getParameterValues("restMdTag");
		
		String restBgTag = arrayToTag(BgTagArr);
		String restMdTag = arrayToTag(MdTagArr);
		
		rvo.setRestBgTag(restBgTag);
		rvo.setRestMdTag(restMdTag);

		// 업장 소개이미지 파일 업로드 및 파일명 배열에 저장하기
		String root = session.getServletContext().getRealPath("/");
		String path = root + "files/restaurant";
		
		String newFileName = "";
		byte[] bytes = null;
			
		try{
				
			bytes = fvo.getAttach()[0].getBytes();
			newFileName = fileManager.doFileUpload(bytes, fvo.getAttach()[0].getOriginalFilename(), path);
			path += "/thumb";
			thumbnailManager.doCreateThumbnail(newFileName, path);
		}catch (Exception e) {
			e.printStackTrace();
		} 
		
		rvo.setRestImg(newFileName);
		
		int result = service.editRest(rvo);
		
		String msg = "수정에 실패했습니다. 알 수 없는 오류가 발생했습니다.";
		String loc = "restEdit.eat";
		
		if (result == 1) {
			msg = "해당 정보를 수정했습니다.";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";

	}
	
	// 업장 삭제 메서드
	@RequestMapping(value="/restDel.eat", method={RequestMethod.POST})
	public String restDel(HttpServletRequest req, HttpServletResponse res, HttpSession session){
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		
		String restSeq = req.getParameter("restSeq");
		String userSeq = loginUser.getUserSeq();
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("restSeq", restSeq);
		map.put("userSeq", userSeq);
		
		int result = service.delRest(map);
		
		String msg = "삭제에 실패했습니다. 알 수 없는 오류가 발생했습니다.";
		String loc = "restList.eat";
		
		if (result == 1) {
			msg = "해당 업장을 삭제했습니다.";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "msg";
	}
	
	
	// 태그 배열을 입력하면 VO에 맞는 형태로 만들어주는 메서드
	public static String arrayToTag(String[] tagArr){
		
		String tag = "";
		
		for (int i = 0; i < tagArr.length; i++) {
			
			tag += tagArr[i];
			
			if ((i+1) != tagArr.length) {
				tag += ",";
			}
		}
		
		return tag;
	}
	
	// VO로 가져온 String의 태그를 입력하면 배열로 만들어주는 메서드
	public static String[] tagToArray(String tag){
		
		String[] tagArr = tag.split(",");;
		
		return tagArr;
	}
	
	// 업장 상세 페이지에 리뷰 띄어놓기
		@RequestMapping(value="/ReviewListAjax.eat", method={RequestMethod.GET})
		public String ReviewListAjax(HttpServletRequest req, HttpServletResponse res, HttpSession session){
			
			UserVO loginUser = (UserVO)session.getAttribute("loginUser");
			String UserSeq = null;
			if(loginUser != null){
			   UserSeq = loginUser.getUserSeq();
			}
			String restSeq = req.getParameter("restSeq");
			String start = req.getParameter("StartRno");    // 1, 3, 5....
			String len = req.getParameter("EndRno");        // 2개씩   더보기.. 클릭에 보여줄 상품의 갯수 단위크기   
			List<String> likers = new ArrayList<String>();
			List<String> reviewSeq = new ArrayList<String>();
			
			
			if (start == null) {
				start = "1";
			}
			if (len == null) {
				len = "5";
			}
					
			int startRno = Integer.parseInt(start);          // 공식!! 시작 행번호   1               3               5
			int endRno   = startRno+Integer.parseInt(len)-1; // 공식!! 끝 행번호     1+2-1(==2)      3+2-1(==4)      5+2-1(==6)
			
			String StartRno = String.valueOf(startRno);
			String EndRno = String.valueOf(endRno);
			
			if(UserSeq != null){
				likers = service.getLikers(UserSeq);
			}
			else{
				req.setAttribute("msg", "로그인 후 이용해주세요");
				req.setAttribute("loc", "javascript:history.back();");
			}
			
			
			HashMap<String,String> restvo = service.getRestaurant(restSeq);
			
			
			HashMap<String, String> map = new HashMap<String, String>();
			
			map.put("restSeq", restSeq);
			map.put("StartRno", StartRno);
			map.put("EndRno", EndRno);
					
			List<HashMap<String,String>> reviewList = service.getReviewList(map);
			int TotalReviewCount = service.getTotalReview(restSeq);
			
			for(int i=0; i<reviewList.size(); i++)
			{
				reviewSeq.add(reviewList.get(i).get("reviewSeq"));
			}
			
			// 리뷰 이미지배열을 담은 배열 가져오기
			List<List<String>> reviewImageList = reviewService.getReviewImageList(reviewSeq);
			
			
			
			
			if(UserSeq != null){
			
				int reviewCount = reviewService.getMyReviewCount(restSeq, UserSeq);
				req.setAttribute("reviewCount", reviewCount);
			}
			else{
				req.setAttribute("msg", "로그인 후 이용해주세요");
				req.setAttribute("loc", "index.eat");
			}
			/*System.out.println("dddddddddddddddddddddddddddddddddd"+restSeq);*/
			
			req.setAttribute("UserSeq", UserSeq);
			req.setAttribute("likers", likers);
			req.setAttribute("TotalReviewCount", TotalReviewCount);
			req.setAttribute("reviewList",  reviewList);
			req.setAttribute("restvo", restvo);
			req.setAttribute("reviewImageList", reviewImageList);
			req.setAttribute("restSeq", restSeq);
//			req.setAttribute("UserEmail", UserEmail);
			////////////////////////////////////////////////////////////////////////////
//			System.out.println("확인용 DisplayJSONAction.java       productList size : " + ListOfReview.size()); // 확인용
			return "review/ReviewListAjax";
		}
	
	// 업장 리스트를 불러오는 메서드
		@RequestMapping(value="/restListStatistics.eat", method={RequestMethod.GET})
		public String restListStatistics(HttpServletRequest req, HttpServletResponse res, HttpSession session){
			UserVO loginUser = (UserVO)session.getAttribute("loginUser");
			String userSeq = loginUser.getUserSeq();
					
			List<RestaurantVO> restList = service.restListStatistics(userSeq);
			
			req.setAttribute("restList", restList);
			
			return "user/restListStatistics";
		}
		
		
		@RequestMapping(value="/Statistics.eat", method={RequestMethod.GET})
		public String Statistics(HttpServletRequest req, HttpServletResponse res, HttpSession session){

			String restSeq = req.getParameter("restSeq");
			System.out.println(">>>>>>>>>>>>>###################" + restSeq);
			String restName = req.getParameter("restName");
			
			System.out.println(">>>>>>>>>>>>>###################" + restName);
//			성별 차트 DB
			List<HashMap<String, String>> genderList = service.restStati_Gender(restSeq); 

//			나이별 차트 DB
			List<HashMap<String, String>> ageList = service.restStati_AgeLine(restSeq);
			
//			리뷰수 차트 DB
			List<HashMap<String, String>> reviewCount = service.restStati_ReviewCount(restSeq);
			
//			리뷰평점 차트 DB
			List<HashMap<String, String>> reviewGrade = service.restStati_ReviewGrade(restSeq);
			
			req.setAttribute("genderList", genderList);
			req.setAttribute("ageList", ageList);
			req.setAttribute("reviewCount", reviewCount);
			req.setAttribute("reviewGrade", reviewGrade);
			
			req.setAttribute("restName", restName);
			return "user/Statistics";
		}
		
		//은석 음식점상세페이지에서 음식점 사진 크게보여주는 메서드
		@RequestMapping(value="/getLargeAdImgFilename.eat", method={RequestMethod.GET})
		public String getLargeAdImgFilename(HttpServletRequest req, HttpServletResponse res, HttpSession session){
			String adImg = req.getParameter("adImg");

			System.out.println("*****************************" + adImg);
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("adImg", adImg);
			
			System.out.println("##### JSON 확인용 : " + adImg);
			
			req.setAttribute("jsonObj", jsonObj);
			
			return "restaurant/largeAdImgNameJSON";
		}
}

