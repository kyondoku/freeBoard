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
	
	Map<String, Object> insCodeDetail(Map<String, Object> map);
	
	int selectCommonCodeChk(Map<String, Object> map);

	Map<String, Object> delCodeDetail(Map<String, Object> map);

	Map<String, Object> udtCodeDetail(Map<String, Object> map);
}
