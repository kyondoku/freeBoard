package ino.web.freeBoard.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ino.web.freeBoard.common.util.PagingUtil;
import ino.web.freeBoard.dao.FreeBoardDao;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	@Autowired
	private FreeBoardDao freeBoardDao;

	@Override
	public List<Map<String, Object>> freeBoardList(Map<String, Object> params) {
		return freeBoardDao.freeBoardList(params);
	}

	@Override
	public Map<String,Object> freeBoardInsertPro(FreeBoardDto dto) {
		Map<String,Object> map = new HashMap<String,Object>();
		String msg = "";

		try{
			int count = freeBoardDao.freeBoardInsertPro(dto);
			System.out.println("count : " + count);
			if(count > 0){
				map.put("newBoard", dto);
				msg = "success"; // 성공
				map.put("msg", msg);
			}else{
				msg = "fail"; // 실패
				map.put("msg", msg);
			}
			
		} catch(Exception e) {
			msg = "fail"; // 실패
			map.put("msg", msg);
		}
		
		return map;
	}

	@Override
	public FreeBoardDto getDetailByNum(int num) {
		return freeBoardDao.getDetailByNum(num); 
	}

	@Override
	public int getNewNum() {
		return freeBoardDao.getNewNum();
	}

	@Override
	public void freeBoardModify(FreeBoardDto dto) {
		freeBoardDao.freeBoardModify(dto);
	}

	@Override
	public void freeBoardDelete(int num) {
		freeBoardDao.freeBoardDelete(num);
	}

	@Override
	public Map<String,Object> selPagingCnt(Map<String, Object> params) {
		int listCnt = freeBoardDao.selPagingCnt(params);
		int curPage = Integer.parseInt(params.get("curPage").toString());
		
		PagingUtil pageUt = new PagingUtil(curPage, listCnt);
		
		params.put("start" , pageUt.getPageBegin());
		params.put("end" , pageUt.getPageEnd());
		params.put("pageUt", pageUt);
		
		return params;
	}

	@Override
	public List<Map<String, Object>> selCodeList(Map<String, Object> params) {
		return freeBoardDao.selCodeList(params);
	}
}
