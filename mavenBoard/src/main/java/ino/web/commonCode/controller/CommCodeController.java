package ino.web.commonCode.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.DynaBeanMapDecorator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.commonCode.service.CommCodeService;


@Controller
public class CommCodeController {
   
   @Autowired
   private PlatformTransactionManager transactionManager;
   
   @Autowired 
   private CommCodeService commCodeService;
   
   @RequestMapping("/commonCode.ino")
   public ModelAndView commonCode(HttpServletRequest req){
      
      ModelAndView mav = new ModelAndView();
      
      List<HashMap<String,Object>> list = commCodeService.selectCommonCodeList();
      
      mav.addObject("list" , list);
      mav.setViewName("commonCodeMain");
      
      return mav;
   }
   
   @RequestMapping("/commonCodeDetail.ino")
   public ModelAndView commonCodeDetail(HttpServletRequest request
         , @RequestParam(defaultValue = "", value="num") String num) {
      
      ModelAndView mav = new ModelAndView();
      
      Map<String, Object> map = new HashMap<String, Object>();
      
      System.out.println("num : " + num);
      map.put("CODE", num);
      
      List<Map<String, Object>> list = commCodeService.selectCommonCodeDetail(map);
      
      mav.addObject("CODE", num);
      mav.addObject("list", list);
      mav.setViewName("commonCodeDetail");
      
      return mav;
   }
   
   @RequestMapping("/commonCodeChk.ino")
   @ResponseBody
   public int commonCodeChk(HttpServletRequest request
     , @RequestParam(defaultValue = "", value="add_decode") List<String> decode) {
      
      Map<String, Object> map = new HashMap<String, Object>();
      
      for(int i=0; i<decode.size(); i++) {
         System.out.println(decode.get(i));
         map.put("DECODE"+(i+1), decode.get(i));
      }
      
      if(decode.size() < 3){
         for(int i=decode.size(); i<3; i++){
            map.put("DECODE"+(i+1), "");
         }
      }
      
      int result = commCodeService.selectCommonCodeChk(map);
      
      return result;
   }
   
   @RequestMapping("/regCodeDetail.ino")
   @ResponseBody
   public Map<String, Object> insCodeDetail(HttpServletRequest request
         , @RequestBody List<HashMap<String,Object>> ParamMap) {
	   
	  TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition()); 
	   
      List<HashMap<String,Object>> insertList = new ArrayList<>();
      List<HashMap<String,Object>> updateList = new ArrayList<>();
      List<HashMap<String,Object>> deleteList = new ArrayList<>();
      
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("regMsg", "성공");
      
      for (HashMap<String,Object> resultMap : ParamMap) {
    	  if(resultMap.get("flag").equals("I")){
    		  insertList.add(resultMap); 
    	  }
    	  if(resultMap.get("flag").equals("U")){
    		  updateList.add(resultMap);
    	  }
    	  if(resultMap.get("flag").equals("D")){
    		  deleteList.add(resultMap);
    	  }  
      }
      
      try {
    	  commCodeService.insCodeDetail(insertList);
    	  commCodeService.udtCodeDetail(updateList);
    	  commCodeService.delCodeDetail(deleteList);
      } catch(RuntimeException e) {
          transactionManager.rollback(status);
          map.put("regMsg", "실패");
          e.printStackTrace();
      }
      
      return map; 
   }
}