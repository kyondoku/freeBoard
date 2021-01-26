package ino.web.commonCode.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
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
         , @RequestParam(defaultValue = "", value="decode") List<String> decode) {
      
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
         , @RequestParam(defaultValue = "", value="code") List<String> code
         , @RequestParam(defaultValue = "", value="decode") List<String> decode
         , @RequestParam(defaultValue = "", value="decode_name") List<String> decodeName
         , @RequestParam(defaultValue = "", value="mod_code") List<String> modCode
         , @RequestParam(defaultValue = "", value="mod_decode") List<String> modDecode
         , @RequestParam(defaultValue = "", value="mod_decode_name") List<String> modDecodeName
         , @RequestParam(defaultValue = "", value="delList") String[] delList) {
      
      List<String> useYnList = new ArrayList<String>();
      List<String> mod_useYnList = new ArrayList<String>();
      
      Enumeration<String> useYns = request.getParameterNames();
      
      Map<String,Object> map = new HashMap<String, Object>();
      map.put("regMsg", "성공");
      
      TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
      
      try {
      
         do {
           String useYn = useYns.nextElement();
           String value = request.getParameter(useYn);  
   
           if(useYn.startsWith("useYn_")) {
              useYnList.add(value);
           } else if(useYn.startsWith("mod_useYn_")) {
              mod_useYnList.add(value);
           }
         } while (useYns.hasMoreElements());
         
         for(int i=0; i<code.size(); i++) {
            map.put("CODE", code.get(i));
            map.put("DECODE", decode.get(i));
            map.put("DECODE_NAME", decodeName.get(i));
            map.put("USE_YN", useYnList.get(i));
            
            map = commCodeService.insCodeDetail(map);
         }
         
         if(modCode.size() > 0) {      
            for(int i=0; i<modCode.size(); i++){
               map.put("CODE", modCode.get(i));
               map.put("DECODE", modDecode.get(i));
               map.put("DECODE_NAME", modDecodeName.get(i));
               map.put("USE_YN", mod_useYnList.get(i));
               
               map = commCodeService.udtCodeDetail(map);
            }
         }
         
         if(delList.length > 0) {
            System.out.println("delListLength : " + delList.length);
          
            for(int i=0; i<delList.length; i++) {
               System.out.println("delList : " + delList[i]);         
               map.put("DECODE", delList[i]);
               
               map = commCodeService.delCodeDetail(map);
            }
         }

         transactionManager.commit(status);
         
      } catch(RuntimeException e) {
         transactionManager.rollback(status);
         map.put("regMsg", "실패");
         e.printStackTrace();
      } 
      
      System.out.println("before return");
      return map; 
   }
}