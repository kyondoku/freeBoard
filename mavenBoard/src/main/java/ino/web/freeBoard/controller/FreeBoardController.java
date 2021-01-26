package ino.web.freeBoard.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.freeBoard.common.util.PagingUtil;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request
			, @RequestParam(defaultValue = "", value="searchType") String searchType
			, @RequestParam(defaultValue = "", value="searchText") String searchText
			, @RequestParam(defaultValue = "", value="startDate") String startDate
	        , @RequestParam(defaultValue = "", value="endDate") String endDate
			, @RequestParam(defaultValue = "1") int curPage){

		ModelAndView mav = new ModelAndView();

		Map<String,Object> params = new HashMap<String,Object>();
		params.put("searchType", searchType);
		params.put("searchText", searchText);
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		params.put("curPage", curPage);
		
		params = freeBoardService.selPagingCnt(params);

		params.put("code", "COM060");
		params.put("useYn", "Y");

		List<Map<String,Object>> codeList = freeBoardService.selCodeList(params);
		mav.addObject("codeList", codeList);

		List<Map<String,Object>> list = freeBoardService.freeBoardList(params);

		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		mav.addObject("searchInfo", params);

		return mav;
	}
	
	@RequestMapping("/mainSearchAjax.ino")
	@ResponseBody
	public Map<String,Object> mainSearchAjax(@RequestParam(defaultValue = "", value="searchType") String searchType
										   , @RequestParam(defaultValue = "", value="searchText") String searchText 
										   , @RequestParam(defaultValue = "", value="startDate") String startDate
										   , @RequestParam(defaultValue = "", value="endDate") String endDate
										   , @RequestParam(defaultValue = "1", value="curPage") int curPage) {

		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("searchType", searchType);
		map.put("searchText", searchText);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("curPage", curPage);
			
		map = freeBoardService.selPagingCnt(map);
		
		List<Map<String,Object>> list = freeBoardService.freeBoardList(map);
		map.put("searchList", list);
		
		return map;
	} 

	@RequestMapping("/freeBoardInsert.ino")
	public ModelAndView freeBoardInsert(){
		
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> params = new HashMap<String,Object>();
		
		// CODE정보 불러오기
		params.put("code", "COM071");
		params.put("useYn", "Y");
		List<Map<String,Object>> codeList = freeBoardService.selCodeList(params);
		
		mav.setViewName("freeBoardInsert");
		mav.addObject("codeList", codeList);

		return mav;
	}

	@RequestMapping("/freeBoardInsertPro.ino")
	public String freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto){
		freeBoardService.freeBoardInsertPro(dto);
		int newNum = freeBoardService.getNewNum();
		System.out.println("newNum : " + newNum);
		return "redirect:/freeBoardDetail.ino?num=" + newNum;		
	}
	
	@RequestMapping("/insBoardAjax.ino")
	@ResponseBody
	public Map<String,Object> insBoardAjax(FreeBoardDto dto) {
		Map<String,Object> map = freeBoardService.freeBoardInsertPro(dto);
		return map;
	} 

	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request
		   , @RequestParam(defaultValue = "", value="searchType") String searchType
		   , @RequestParam(defaultValue = "", value="searchText") String searchText 
		   , @RequestParam(defaultValue = "1", value="curPage") int curPage){
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("searchType", searchType);
		map.put("searchText", searchText);
		map.put("curPage", curPage);
		
		FreeBoardDto dto = freeBoardService.getDetailByNum(num);
		map.put("freeBoardDto", dto);
		
		return new ModelAndView("freeBoardDetail", "map", map);
	}

	@RequestMapping("/freeBoardModify.ino")
	public String freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		freeBoardService.freeBoardModify(dto);
		return "redirect:/freeBoardDetail.ino?num=" + dto.getNum();
	}
	
	@RequestMapping("/modBoardAjax.ino")
	@ResponseBody
	public void modBoardAjax(FreeBoardDto dto) {
		freeBoardService.freeBoardModify(dto);
	}

	@RequestMapping("/freeBoardDelete.ino")
	public String FreeBoardDelete(int num){
		freeBoardService.freeBoardDelete(num);
		return "redirect:/main.ino";
	}
	
	@RequestMapping("/delBoardAjax.ino")
	@ResponseBody
	public void delBoardAjax(int num) {
		freeBoardService.freeBoardDelete(num);
	}
}