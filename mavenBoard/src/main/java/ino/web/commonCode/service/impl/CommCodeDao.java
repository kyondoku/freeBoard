package ino.web.commonCode.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommCodeDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<HashMap<String, Object>> selectCommonCodeList() {
		return sqlSessionTemplate.selectList("selectCommonCodeList");
	}
	
	public List<Map<String, Object>> selectCommonCodeDetail(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("selectCommonCodeDetail", map);
	}

	public int insCodeDetail(Map<String, Object> map) {
		return sqlSessionTemplate.insert("insCodeDetail", map);
	}

	public int selectCommonCodeChk(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("selectCommonCodeChk", map);
	}

	public int delCodeDetail(Map<String, Object> map) {
		return sqlSessionTemplate.delete("delCodeDetail", map);
	}

	public int udtCodeDetail(Map<String, Object> map) {
		return sqlSessionTemplate.update("udtCodeDetail", map);
	}
	
}
