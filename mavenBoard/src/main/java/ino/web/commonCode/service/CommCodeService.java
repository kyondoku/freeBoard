package ino.web.commonCode.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

public interface CommCodeService {

	List<HashMap<String, Object>> selectCommonCodeList();
	
	List<Map<String, Object>> selectCommonCodeDetail(Map<String, Object> map);
	
	Map<String, Object> insCodeDetail(List<HashMap<String, Object>> insertList);
	
	int selectCommonCodeChk(Map<String, Object> map);

	Map<String, Object> delCodeDetail(List<HashMap<String, Object>> deleteList);

	Map<String, Object> udtCodeDetail(List<HashMap<String, Object>> updateList);
}
