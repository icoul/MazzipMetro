package com.go.mazzipmetro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
}
