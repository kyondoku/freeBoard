package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ino.web.freeBoard.dto.FreeBoardDto;

public interface FreeBoardService {
	
	List<Map<String, Object>> freeBoardList(Map<String,Object> params);
	
	Map<String,Object> freeBoardInsertPro(FreeBoardDto dto);
	
	FreeBoardDto getDetailByNum(int num);
	
	int getNewNum();
	
	void freeBoardModify(FreeBoardDto dto);
	
	void freeBoardDelete(int num);
	
	Map<String,Object> selPagingCnt(Map<String,Object> params);
	
	List<Map<String,Object>> selCodeList(Map<String, Object> params);
}
