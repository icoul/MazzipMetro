package com.go.mazzipmetro.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.AdminService;

@Controller
public class AdminController {

	@Autowired
	private AdminService service;

	@RequestMapping(value = "/qna.eat", method = RequestMethod.GET)
	public String qna(HttpServletRequest req) {
		
		
		return "admin/qna";
	}
}
