package ino.web.commonCode.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ino.web.commonCode.service.CommCodeService;

@Service
public class CommCodeServiceImpl implements CommCodeService {
	@Autowired
	private CommCodeDao CommCodeDao;

	@Override
	public List<HashMap<String, Object>> selectCommonCodeList() {
		return CommCodeDao.selectCommonCodeList();
	}

	@Override
	public List<Map<String, Object>> selectCommonCodeDetail(Map<String, Object> map) {
		return CommCodeDao.selectCommonCodeDetail(map);
	}

	@Override
	public Map<String, Object> insCodeDetail(Map<String, Object> map) {
		int result = CommCodeDao.insCodeDetail(map);
		
		if(result > 0) {
			map.put("msg", "success : " + result);
		} else {
			map.put("msg", "failed");
		}
		
		return map;
	}

	@Override
	public int selectCommonCodeChk(Map<String, Object> map) {
		return CommCodeDao.selectCommonCodeChk(map);
	}

	@Override
	public Map<String, Object> delCodeDetail(Map<String, Object> map) {
		int result = CommCodeDao.delCodeDetail(map);
		
		if(result > 0) {
			map.put("msg", "success : " + result);
		} else {
			map.put("msg", "failed");
		}
		
		return map;
	}

	@Override
	public Map<String, Object> udtCodeDetail(Map<String, Object> map) {
		int result = CommCodeDao.udtCodeDetail(map);
		
		if(result > 0) {
			map.put("msg", "success : " + result);
		} else {
			map.put("msg", "failed");
		}
		
		return map;
	}
}
