package com.go.mazzipmetro.controller;

import java.util.ArrayList;
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
import com.go.mazzipmetro.service.RestaurantService;
import com.go.mazzipmetro.vo.MenuVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.FileVO;

@Controller
public class RestaurantController {

	@Autowired
	private RestaurantService service; 
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	// 업장을 등록하는 메서드
	@RequestMapping(value="/addRestaurant.eat", method={RequestMethod.GET})
	public String addRestaurant(){
		
		return "restaurant/addRestaurant";
	}
	
	// 입력한 업장명을 가진 곳이 DB에 존재하는지 확인하기 위해 검색하고 데이터를 가져오는 메서드
	@RequestMapping(value="/restCheck.eat", method={RequestMethod.GET})
	public String restCheck(HttpServletRequest req){
		
		String name = req.getParameter("name");
		
		List<RestaurantVO> nameList = service.getRestName(name); 

		req.setAttribute("name", name);
		req.setAttribute("nameList", nameList);
		
		return "restaurant/restCheck";
	}
	
	// 업장명이 존재하지 않아 자신이 직접 찾아서 등록하고자 하는 메서드
	@RequestMapping(value="/notRestRegi.eat", method={RequestMethod.GET})
	public String notRestRegi(HttpServletRequest req){
		
		String name = req.getParameter("name");
		
		req.setAttribute("name", name);
		
		return "restaurant/notRestRegi";
	}
	
	// 업장 정보를 받아서 insert 또는 update 시켜주는 메서드
	@RequestMapping(value="/restRegister.eat", method={RequestMethod.POST})
	public String restRegister(HttpServletRequest req){
		
		String restSeq = req.getParameter("seq");
		String restName = req.getParameter("name");
		String restImg = req.getParameter("image");
		String restAddr = req.getParameter("addr");
		String restNewAddr = req.getParameter("newAddr");
		String restPhone = req.getParameter("phone");
		String restLatitude = req.getParameter("latitude");
		String restLongitude = req.getParameter("longitude");
		String metroId = req.getParameter("metroId");
		String dongId = req.getParameter("dongId");
		
		String userSeq = "1"; // 임시. 나중에는 session으로 대체
		int result = 0;
		
		RestaurantVO vo = new RestaurantVO();
		
		vo.setRestSeq(restSeq);
		vo.setRestName(restName);
		vo.setUserSeq(userSeq);
		vo.setRestImg(restImg);
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
	
	@RequestMapping(value="/addRestaurantInfo.eat", method={RequestMethod.GET})
	public String addRestaurantInfo(HttpServletRequest req){
		
		String restSeq = req.getParameter("restSeq");
		
		req.setAttribute("restSeq", restSeq);
		
		return "restaurant/addRestaurantInfo";
	}
	
	@RequestMapping(value="/addRestaurantInfoEnd.eat", method={RequestMethod.POST})
	public String addRestaurantInfoEnd(MenuVO mvo, FileVO fvo, HttpServletRequest req, HttpSession session){
		
		String content = req.getParameter("content");
		String bgCat = req.getParameter("bgCat");
		String[] mgCat = req.getParameterValues("mgCat");
		
		// 이미지 파일 업로드 및 파일명 배열에 저장하기
		ArrayList<String> imageList = new ArrayList<String>();	
		
		String root = session.getServletContext().getRealPath("/");
		String path = root + "files";
		
		String newFileName = "";
		byte[] bytes = null;
		System.out.println(content);
		System.out.println(bgCat);
		
		for (int i = 0; i < mgCat.length; i++) {
			System.out.println(mgCat[i]);
		}
		
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
		
		for (int i = 0; i < imageList.size(); i++) {
			System.out.println(imageList.get(i));
		}
		
		for (int i = 0; i < mvo.getMenuName().length; i++) {
			System.out.println(mvo.getMenuName()[i]);
			System.out.println(mvo.getMenuImg()[i]);
			System.out.println(mvo.getMenuContent()[i]);
			System.out.println(mvo.getMenuPrice()[i]);
			System.out.println(mvo.getMenuSalePrice()[i]);
			System.out.println(mvo.getMenuSort()[i]);
			System.out.println(mvo.getMenuEvent()[i]);
		}
		
		return "restaurant/addRestaurantInfoEnd";
	}
}

