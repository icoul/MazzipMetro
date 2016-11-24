package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.MazzipMetroDAO;

@Service
public class MazzipMetroService implements IService {

	@Autowired
	MazzipMetroDAO dao;

	public List<HashMap<String, String>> dbTest() {
		return dao.dbTest();
	}
}
