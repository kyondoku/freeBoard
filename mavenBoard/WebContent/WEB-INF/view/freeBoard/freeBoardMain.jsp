<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	/*
 $.ajax({
	 url: "", // ajax 호출하고자 하는 mapping주소 (EX: "./main.ino") >> form action
	 type: "", form mothod (GET , POST)
	 dataType: "", json 
	 data: "{"key" : value ,"key" : value ..... }", 실질적으로 파라미터를 선언하는 부분이라고 생각하면 됩니다. 
	 success: function(data){
		 // ajax가 controller 와 정상적으로 소통이 되었을때 
		 function(data) >> controller 에서 넘겨준 데이터가 존재합니다 
		 data.list;
		 
		 
	 },
	 error: function (request, status, error){
		 // ajax가 controller와 정상적으로 소통하지 못했을대
		 console.log(status) , alert(error);
		 
	 }
});
 */
 
/* 					var innerText = '';
					switch (data[i].code_type){
				   case "01" :
				 	  innerText = '자유';
				       break;
				   case "02" :
				 	  innerText = '익명';
				       break;
				   case "03" :
				 	  innerText = 'QnA';
				       break;
					}
					
					tbody.innerHTML += 	
					`<tr>
						<td id="codeType" style="width: 55px; padding-left: 30px;" align="center">`+ innerText + `</td>
						<td style="width: 50px; padding-left: 10px;" align="center">` + data[i].num + `</td>
						<td style="width: 125px;" align="center"><a href="./freeBoardDetail.ino?num=` + data[i].num + `">` + data[i].title + `</a></td>
						<td style="width: 48px; padding-left: 50px;" align="center">` + data[i].name + `</td>
						<td style="width: 100px; padding-left: 95px;" align="center">` + data[i].regdate + `</td>
					</tr>` */
 
 	function searchList(curPage, searchType, searchText, startDate, endDate) {
		$.ajax({
			url: "./mainSearchAjax.ino",
			type: "POST",
			data: {
				searchType : frm.searchType.value,
				searchText : frm.searchText.value,
				startDate : startDate,
				endDate : endDate,
				curPage : curPage
			},
			success: function(data){
				
				//리스트 생성
				tbody.innerText = '';
				for(var i=0; i<data.searchList.length; i++) {
 					var tr = document.createElement('tr');
					var td_codeType = document.createElement('td');
					switch (data.searchList[i].code_type){
				      case "01" :
				    	  td_codeType.innerText = '자유';
				          break;
				      case "02" :
				    	  td_codeType.innerText = '익명';
				          break;
				      case "03" :
				    	  td_codeType.innerText = 'QnA';
				          break;
				    }
					td_codeType.setAttribute("style", "width: 55px; padding-left: 30px; text-align:center");
			
					var td_num = document.createElement('td');
					td_num.innerText = data.searchList[i].num;
					td_num.setAttribute("style", "width: 50px; padding-left: 10px; text-align:center");
					
					var td_title = document.createElement('td');
					td_title.setAttribute("style", "width: 125px; text-align:center");
					
					var td_title_a = document.createElement('a');
					td_title_a.innerText = data.searchList[i].title;
					td_title_a.setAttribute("href", "./freeBoardDetail.ino?"
							+ "num=" +data.searchList[i].num);
	
					var td_name = document.createElement('td');
					td_name.innerText = data.searchList[i].name;
					td_name.setAttribute("style", "width: 48px; padding-left: 50px; text-align:center");	
					
					var td_regdate = document.createElement('td');
					td_regdate.innerText = data.searchList[i].regdate;
					td_regdate.setAttribute("style", "width: 100px; padding-left: 95px; text-align:center");	
					
					tr.append(td_codeType);
					tr.append(td_num);
					td_title.append(td_title_a);
					tr.append(td_title);
					tr.append(td_name);
					tr.append(td_regdate);
					tbody.append(tr);
					}
				
				//페이징 생성
				pagingContainer.innerText = '';
				
				if(data.pageUt.curPage != 1) {
					var a_first = document.createElement('a');
					a_first.innerText = '처음';
					a_first.setAttribute("onclick", "searchList(1)");
					a_first.setAttribute("value", 1);
					a_first.setAttribute("style", "cursor:pointer");
					a_first.setAttribute("id", "page");
					pagingContainer.append(a_first);
					
					var a_prev = document.createElement('a');
					a_prev.innerText = '이전';
					a_prev.setAttribute('onclick', 'searchList('
							+ data.pageUt.prevPage + ',' 
							+ "'" + data.searchType + "',"
							+ "'" + data.searchText + "'," 
							+ "'" + startDate + "',"
							+ "'" + endDate + "'"
							+ ")");
					a_prev.setAttribute("value", data.pageUt.prevPage);
					a_prev.setAttribute("style", "cursor:pointer");
					a_prev.setAttribute("id", "page");
					pagingContainer.append(a_prev);
				}
				
				for(var i=data.pageUt.blockBegin; i<=data.pageUt.blockEnd; i++) {
					if(i == data.pageUt.curPage){
						var span_page = document.createElement('span');
						span_page.setAttribute("style", "color:red");
						span_page.innerText =  i;
						pagingContainer.append(span_page);
					} else {
						var a_page = document.createElement('a');
						a_page.setAttribute('onclick', 'searchList('
								+ i + ',' 
								+ "'" + data.searchType + "',"
								+ "'" + data.searchText + "'," 
								+ "'" + startDate + "',"
								+ "'" + endDate + "'"
								+ ")");
						a_page.setAttribute("style", "cursor:pointer");
						a_page.setAttribute("value", i);
						a_page.setAttribute("id", "page");
						a_page.innerText =  i;
						pagingContainer.append(a_page);
					}
				}
				
				if(data.pageUt.curPage != data.pageUt.totPage) {
					var a_next = document.createElement('a');
					a_next.innerText = '다음';
					a_next.setAttribute('onclick', 'searchList('
							+ data.pageUt.nextPage + ',' 
							+ "'" + data.searchType + "',"
							+ "'" + data.searchText + "'," 
							+ "'" + startDate + "',"
							+ "'" + endDate + "'"
							+ ")");
					a_next.setAttribute("style", "cursor:pointer");
					a_next.setAttribute("value", data.pageUt.nextPage);
					a_next.setAttribute("id", "page");
					pagingContainer.append(a_next);
					
					var a_last = document.createElement('a');
					a_last.innerText = '끝';
					a_last.setAttribute("onclick", "searchList(" + data.pageUt.totPage +")");
					a_last.setAttribute("style", "cursor:pointer");
					a_last.setAttribute("value", data.pageUt.totPage);
					a_last.setAttribute("id", "page");
					pagingContainer.append(a_last);	
				}		

 				history.pushState(null, null
				, "./main.ino?curPage="+curPage
				+"&searchType="+searchType
				+"&searchText="+searchText
				+"&startDate="+startDate
				+"&endDate="+endDate)
			}
		})
	}

	function searchChk(curPage, searchType, searchText, startDate, endDate) {					
		if(frm.searchType.value == 0 && frm.startDate.value == null) {
			alert('검색방식을 선택해주세요.')
			return false
		}
		
		// 날짜검색 유효성 검사하기
		startDate = startDate.replaceAll('-','');
		endDate = endDate.replaceAll('-','');
		
		console.log(startDate)
		console.log(endDate)
		
		/* 오늘날짜 구하기  */
		var date = new Date(); 
		var year = date.getFullYear()
		var month = new String(date.getMonth() + 1)
		var day = new String(date.getDate())

		// 한자리수일 경우 0 채우기
		if(month.length == 1){ 
		  month = "0" + month; 
		} 
		if(day.length == 1){ 
		  day = "0" + day; 
		} 
		var today = year + "" + month + "" + day;
		console.log(today)
		
		/* 공백제거 */
		startDate = startDate.replaceAll(" ", "")
		endDate = endDate.replaceAll(" ", "")
		
		/* 선택월 마지막 일자 */
		var start_lastDate = new Date(startDate.substring(0,3), startDate.substring(4,6), 0).getDate();
		var end_lastDate = new Date(endDate.substring(0,3), endDate.substring(4,6), 0).getDate();

		/* 시작일과 종료일 중 하나만 입력했을 경우 */
		if(startDate.length == 0 && endDate.length != 0) {
			alert('시작일과 종료일 모두 입력해주세요.')
			return false
		} else if(startDate.length != 0 && endDate.length == 0) {
			alert('시작일과 종료일 모두 입력해주세요.')
			return false
		}
		
		/* 자릿수가 8자리가 아닐경우 */
		if(startDate.length != 0 && endDate.length != 0) {
			if(startDate.length != 8 || endDate.length != 8) {
				alert('기준연도 4자리, 기준월 2자리, 기준일 2자리.\n총 8자리의 숫자로 입력해주세요')
				return false
			}
		}

		// 숫자 아닐경우
		if(isNaN(startDate)) {
			alert('숫자만 입력해주세요.')
			return false
 		} else if(isNaN(endDate)) {
			alert('숫자만 입력해주세요.') 
			return false
		}

		/* 0000-00-00 금지, 월 13이상 금지, 일 32이상 금지? */
		if(startDate.substring(0,4) == '0000' || endDate.substring(0,4) == '0000') {
			alert('0001년 이상의 연도를 입력해주세요')
			return false
		} else if(startDate.substring(4,6) == '00' || startDate.substring(4,6) > 12) {
			alert('월은 1-12사이의 값을 입력해주세요.')
			return false
		} else if(startDate.substring(6,8) == '00' || endDate.substring(6,8) == '00') {
			alert('1이상의 일자를 입력해주세요 ')
			return false
		} else if(startDate.substring(6,8) > start_lastDate) {
			alert('입력하신 시작월은 ' + start_lastDate +'일이 마지막 일입니다.' )
			return false
		} else if(endDate.substring(6,8) > end_lastDate) {
			alert('입력하신 종료월은 ' + end_lastDate +'일이 마지막 일입니다.' )
			return false
		} 
		
		/* 조회기간 32일 이상일 경우 */
		console.log(endDate)
		console.log(startDate)
		
		const searchLimit = 31;
		
		const date_startDate = new Date(startDate.substring(0,4), startDate.substring(4,6)-1, startDate.substring(6,8));
		const date_endDate = new Date(endDate.substring(0,4), endDate.substring(4,6)-1, endDate.substring(6,8));

		
 		const elapsedMSec = date_endDate.getTime() - date_startDate.getTime();
		const elapsedDay = (elapsedMSec/1000/60/60/24)+1;
		
		console.log('조회기간일수 : ' + elapsedDay);
		
		if((searchLimit - elapsedDay) < 0) {
			alert('최대 31일까지의 기간만 조회가 가능합니다.')
			return false
		}
		
		/* 시작일과 종료일이 미래일경우 */
		if(startDate > today) {
			alert('미래일자를 입력하실 수 없습니다.')
			return false
		}
		
		/* 종료일이 시작일보다 빠를 경우 */
		if((endDate - startDate) < 0) {
			alert('종료일은 시작일을 지난 날짜를 입력해주세요.')
			return false
		}
		
		/* 글번호 검색으로 문자 입력할 경우 */
		if(frm.searchType.value == 'DCODE001') {
			if(isNaN(frm.searchText.value)) {
				alert('숫자만 입력해주세요.')
				return false
			}
		}
		console.log(startDate)
		searchList(curPage, searchType, searchText, startDate, endDate);
	}
	
	function autoHypenDate(obj) {
		var date = obj.value.replace(/[^0-9]/g, '');
		var tmp = '';
	
	      if(date.length < 5){
	          tmp = date;
	      }else if(date.length < 7){
	          tmp += date.substring(0, 4);
	          tmp += '-';
	          tmp += date.substring(4);
	      }else{              
	          tmp += date.substring(0, 4);
	          tmp += '-';
	          tmp += date.substring(4, 6);
	          tmp += '-';
	          tmp += date.substring(6);
	      }
	      obj.value = tmp;
	}
</script>

</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div>
		<form id="frm" onsubmit="return false">
			<select name="searchType" id="COM060">
				<c:forEach var="nRow" items="${codeList}">
					<option value="${nRow.DECODE}">${nRow.DECODE_NAME}</option>
				</c:forEach>
			</select>
<!-- 			<select>
				<option>2020</option>
				<option>2019</option>
				<option>2018</option>
			</select> -->
			<!-- 날짜검색 -->
			<input name="searchText" type="text" value="${searchInfo.searchText}" required/>
			<div>
				<!-- datePieker(class) -->
				시작일 : <input name="startDate" id="date" type="text" placeholder="YYYY-MM-DD" onkeyup="autoHypenDate(this)" maxlength="10"/>
				~ 종료일 : <input name="endDate" id="date" type="text" placeholder="YYYY-MM-DD" onkeyup="autoHypenDate(this)" maxlength="10"/>
			</div>
			<button type="button" id="btnSearch"
			onclick="searchChk(${searchInfo.pageUt.curPage}, frm.searchType.value, frm.searchText.value, frm.startDate.value, frm.endDate.value)">검색</button>
		</form>
	</div>
	
	
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td style="width: 55px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">

	<div>
		<form name="listFrm" id="listFrm">
			<table border="1">
				<tbody id="tbody">
    					<c:forEach var="dto" items="${freeBoardList }">
						<tr>
							<td style="width: 55px; padding-left: 30px;" align="center">
								<c:if test="${dto.code_type == '01'}">자유</c:if>
								<c:if test="${dto.code_type == '02'}">익명</c:if>
								<c:if test="${dto.code_type == '03'}">Q&A</c:if>
							</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px;" align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title}</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
	<div id="pagingContainer">
  		<c:if test="${searchInfo.pageUt.curPage != 1 }">
 			<a href="./main.ino?curPage=1">처음</a>
			<a href="./main.ino?curPage=${searchInfo.pageUt.prevPage}">이전</a>
		</c:if>
		<c:forEach var="page" begin="${searchInfo.pageUt.blockBegin}" end="${searchInfo.pageUt.blockEnd}">
			<c:choose>
				<c:when test="${page ==  searchInfo.pageUt.curPage}">
					<span style="color: red;">${page}</span>
				</c:when>
				<c:otherwise>
					<a href="./main.ino?curPage=${page}">${page}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${searchInfo.pageUt.curPage != searchInfo.pageUt.totPage }">
			<a href="./main.ino?curPage=${searchInfo.pageUt.nextPage}">다음</a>
			<a href="./main.ino?curPage=${searchInfo.pageUt.totPage}">끝</a>
		</c:if> 
	</div>
	<script>
/*  		searchList(`${pageUt.curPage}`);   */
	</script>
</body>
</html>