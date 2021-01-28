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

	public int insCodeDetail(List<HashMap<String, Object>> insertList) {
		return sqlSessionTemplate.insert("insCodeDetail", insertList);
	}

	public int selectCommonCodeChk(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("selectCommonCodeChk", map);
	}

	public int delCodeDetail(List<HashMap<String, Object>> deleteList) {
		System.out.println("여기여깅겨ㅣㅇ겨ㅣㅇ겨ㅣㅇ겨이겨ㅣㅇㄱ");
		return sqlSessionTemplate.delete("delCodeDetail", deleteList);
	}

	public int udtCodeDetail(List<HashMap<String, Object>> updateList) {
		return sqlSessionTemplate.update("udtCodeDetail", updateList);
	}
	
}
