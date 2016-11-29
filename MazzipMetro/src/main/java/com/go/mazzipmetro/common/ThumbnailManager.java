package com.go.mazzipmetro.common;

import java.io.File;
import java.util.Calendar;

import org.springframework.stereotype.Repository;

import net.coobird.thumbnailator.Thumbnails;

@Repository
public class ThumbnailManager {

	public String doCreateThumbnail(String filename, String path) 
		throws Exception {
		
		String thumbnailFileName = null;
		
		// 업로드한 파일의 이름 ==> 2016100719592316420706146795.png
		if(filename.equals(""))
			return null;
		 
		
		// 확장자(.png)								 // lastIndexOf 맨마지막에나오는 .
		String fileExt = filename.substring(filename.lastIndexOf("."));
		// 문자열.lastIndexOf("검색어", 검색을 시작할 위치 인덱스)
		// 문자열.lastIndexOf("검색어", 0)
		// 문자열.lastIndexOf("검색어") -- 검색을 시작할 위치 인덱스를 생략하면 기본적으로 0 이 된다.
		// ==> 문자열에서 탐색(검색)하는 문자열이 마지막으로 등장하는 위치에 대한 index를 반환.
		// 
		// 문자열.indexOf("검색어", 검색을 시작할 위치 인덱스)는  
		// 문자열.indexOf("검색어", 0)
		// 문자열.indexOf("검색어") -- 검색을 시작할 위치 인덱스를 생략하면 기본적으로 0 이 된다.
		// ==> 문자열에서 탐색(검색)하는 문자열이 처음 발견되는 문자열에 대한 index를 반환.
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 thumbnailFileName 파일명을 만든다.
		thumbnailFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				                          Calendar.getInstance());
		thumbnailFileName += System.nanoTime();
		thumbnailFileName += fileExt;//확장자 추가
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path);
		if(!dir.exists())
			dir.mkdirs();
		
		String pathFilename = path + File.separator + filename;//원본 파일 경로명
		String pathThumbnailFileName = path + File.separator + thumbnailFileName;
		
		File image = new File(pathFilename);
		File thumbnail = new File(pathThumbnailFileName);//썸네일 이미지 경로를 가지고, 파일객체 생성!
		
		//thumnail 이미지 생성!
		if (image.exists()) {
		    Thumbnails.of(image).size(100, 100).outputFormat(fileExt.substring(1)).toFile(thumbnail);
		}
		
		return thumbnailFileName;
	}
	
}
