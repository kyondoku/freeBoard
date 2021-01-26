package ino.web.freeBoard.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ino.web.freeBoard.dto.FreeBoardDto;

@Repository
public class FreeBoardDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Map<String,Object>> freeBoardList(Map<String,Object> params){
		return sqlSessionTemplate.selectList("freeBoardGetList", params);
	}

	public int freeBoardInsertPro(FreeBoardDto dto){
		return sqlSessionTemplate.insert("freeBoardInsertPro",dto);
	}

	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	public void freeBoardModify(FreeBoardDto dto){
		sqlSessionTemplate.update("freeBoardModify", dto);
	}

	public void freeBoardDelete (int num) {
		sqlSessionTemplate.delete("freeBoardDelete", num);
	}

	public int selPagingCnt(Map<String, Object> params) {
		return sqlSessionTemplate.selectOne("selPagingCnt", params);
	}
	
	public List<Map<String,Object>> selCodeList(Map<String, Object> params) {
		return sqlSessionTemplate.selectList("selCodeList", params);
	}

}
