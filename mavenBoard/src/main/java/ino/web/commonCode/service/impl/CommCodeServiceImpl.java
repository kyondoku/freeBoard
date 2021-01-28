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
	public int selectCommonCodeChk(Map<String, Object> map) {
		return CommCodeDao.selectCommonCodeChk(map);
	}

	@Override
	public Map<String, Object> insCodeDetail(List<HashMap<String, Object>> insertList) {
		int result = CommCodeDao.insCodeDetail(insertList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("success", result);
		return map;
	}

	@Override
	public Map<String, Object> delCodeDetail(List<HashMap<String, Object>> deleteList) {
		int result = CommCodeDao.delCodeDetail(deleteList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("success", result);
		return map;
	}

	@Override
	public Map<String, Object> udtCodeDetail(List<HashMap<String, Object>> updateList) {
		int result = CommCodeDao.udtCodeDetail(updateList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("success", result);
		return map;
	}
}
