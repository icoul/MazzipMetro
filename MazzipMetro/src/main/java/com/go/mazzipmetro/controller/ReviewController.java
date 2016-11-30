package com.go.mazzipmetro.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.ReviewService;
import com.go.mazzipmetro.vo.AttachFileVO;
import com.go.mazzipmetro.vo.ReviewVO;


@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	@RequestMapping(value="/add.eat", method={RequestMethod.GET} ) 
	public String reviewAdd() {
		
		System.out.println("ghghh");
		return "add";  
		// /DoubleFileAttachTest/src/main/webapp/WEB-INF/views/add.jsp 파일을 생성한다.
	}
	
	@RequestMapping(value="/addEnd.action", method={RequestMethod.POST} ) 
    public String addEnd(ReviewVO vo, MultipartHttpServletRequest req, HttpSession session) {
	   
	    List<AttachFileVO> attachFileVoList = new ArrayList<AttachFileVO>();
	   
	    // 사용자가 쓴 글에 파일이 첨부가 된것인지
	    // 아니면 파일첨부가 안된것인지 구분을 지어주어야 한다.
	   	
	    // **** 첨부파일이 있는지 ? ****
	    if(vo.getAttach() != null ) { // attach가 비어있지 않다면
		   // 1. 사용자가 보낸 파일을 WAS의 특정 폴더에 저장해주어야 한다.
		   // >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		   //      우리는 WAS 의 webapp/files 라는 폴더로 지정해준다.
					
		   // WAS의 webapp 의 절대경로를 알아와야 한다.
		   String root = session.getServletContext().getRealPath("/");
		   String path = root + "files"; 
		   // path가 첨부파일들을 저장할 WAS의 폴더가 된다.
		   
		   System.out.println(">>> 확인용 path <<< " + path);
		   // >>>>> 확인용 첨부파일들을 저장할 WAS의 폴더명 => C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\DoubleFileAttachTest\files 
		   
			
		   // 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기
		   String reviewImg = ""; 
		   // WAS 디스크에 저장될 파일명 
		   
		   byte[] bytes = null;
		   // 첨부파일을 WAS 디스크에 저장할때 사용되는 용도
		   
		   long fileSize = 0;
		   // 파일크기를 읽어오기 위한 용도
		   
		  
		   // === >>>> thumbnail 파일 생성을 위한 작업관련 용도 <<<< ====//
		   String thumbnailFileName = ""; 
		   // WAS 디스크에 저장될 thumbnail 파일명 
		   //===================================================//
		   
		   try {
			  for(int i=0; i<vo.getAttach().length; i++) {
				  bytes = vo.getAttach()[i].getBytes();
				   // getBytes()메소드는 첨부된 파일을 바이트단위로 파일을 다 읽어오는것이다.
				   // 2-1. 	첨부된 파일을 읽어 오는 것
				   //		첨부한 파일이 강아지.png 이라면
				   // 		이파일을 WAS 디스크에 저장시키기 위해 
				   //		byte[] 타입으로 변경해서 받아들인다.
				  
			      reviewImg = fileManager.doFileUpload(bytes, vo.getAttach()[i].getOriginalFilename(), path);  
				    // 2-2. 첨부한 파일의 확장자명을 알려고 아래와 같이 한다.
					//      vo.getAttach()[i].getOriginalFilename() 은 첨부파일의 파일이름을 말한다.
					//      예를들어, 강아지.png 를 첨부파일로 올리면
					//      vo.getAttach()[i].getOriginalFilename() 이 
					//      String 타입으로 "강아지.png" 를 얻어오는 것이다.
					//      그리고 fileManager.doFileUpload() 메소드에서 
					//      마지막 . 을 기준으로 그 나머지 글자만 취해오도록 되어있다.
					//      즉, .png 라는 확장자만 얻어온다.
					
					// 2-3. 세번째 파라미터인 path 값에 대한 경로명에 파일을 올린다.
					
					// 2-4. 마지막으로 업로드 한 이후에 시간(나노초)으로 설정된 
					//      새로운 파일명을 리턴받아온다. 
					//      그 리턴된 파일명이 reviewImg 이다.
				   
				   System.out.println(">>>> 확인용 reviewImg <<< : " + reviewImg);
				   // >>>> 확인용 reviewImg <<< : 2016100719592316420706146795.png
				   
				   // === >>>> thumbnail 파일 생성을 위한 작업 <<<<    =========  //
				   thumbnailFileName = thumbnailManager.doCreateThumbnail(reviewImg, path); 
				   // ===================================================  //
				   
				   
				// 3. AttachFileVO avo에 디스크에 저장된 진짜파일명(fileName)과 orgFileName 값과 fileSize 값을 넣어주기.
				   AttachFileVO avo = new AttachFileVO();
				   
				   avo.setReviewImg(reviewImg);
				   // WAS에 저장될 파일명(2016081293879218371928379.png)
				   
				   avo.setReviewThumbImg(vo.getAttach()[i].getReviewThumbImg());
				   // 진짜 파일명(강아지.png) // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
				   
				   fileSize = vo.getAttach()[i].getSize(); 
				   // 첨부한 파일의 파일크기인데 리턴타입이 long 타입이다.
				   avo.setFileSize(String.valueOf(fileSize)); 
				   // 첨부한 파일의 크기를 String 타입으로 변경해서 저장함.
				   
				   // ==== >>>> 위에서 생성된 thumbnail 파일의 이름을 avo 에 저장하기 <<<< ====
				   avo.setThumbnailFileName(thumbnailFileName);
				   
				   attachFileVoList.add(avo);
				   
			   }// end of for----------------------
			   
		    }catch(Exception e) {
				   e.printStackTrace();
			}

	   } // end of if -----------------
	   
	   
  // **** 폼에서 입력받은 name, subject, content 및 attachFileVoList 값을 
  //      Service 단으로 넘겨서 테이블에 insert 하기로 한다.
	   
	   // 파일첨부가 없는 경우 또는 파일첨부가 있는 경우로 나누어서
	   // Service 단으로 호출하기
	   int seqcontent = 0;
	   int n = 0;
	   int m = 0;
	   int count = 0;
	   
	   
	   if(vo.getAttach() != null) { // 파일 첨부된것이 있다면
		   seqcontent = service.add(vo);
		   
		   for(int i=0; i<attachFileVoList.size(); i++) {
			   m = service.add_file(attachFileVoList.get(i));
			   if(m==1) count++;
		   }
		   
		   if(attachFileVoList.size() == count) {
			   n=1;
		   }
		   else {
			   n=0;
		   }
	   }
	   

	   if(vo.getAttach() == null) {       // 파일 첨부된것이 없다면
		   req.setAttribute("seqcontent", seqcontent); 
		   // tblDoublefileContent 테이블에 insert 되어진 글번호 seqcontent 컬럼의 값을 얻어와서 view 단 페이지로 넘겨주려고 한다.
	   }
	   else if(vo.getAttach() != null) {    // 파일 첨부된것이 있다면
		   req.setAttribute("seqcontent", seqcontent); 
		   // tblDoublefileContent 테이블에 insert 되어진 글번호 seqcontent 컬럼의 값을 얻어와서 view 단 페이지로 넘겨주려고 한다.		   
		   
		   req.setAttribute("result", n);  
		   // 키값 result 정의   
	   }

	   return "addEnd";  
	   // /DoubleFileAttachTest/src/main/webapp/WEB-INF/views/addEnd.jsp 파일을 생성한다. 

    } // end of addEnd(BoardVO vo, MultipartHttpServletRequest req, HttpSession session)--------------

}
