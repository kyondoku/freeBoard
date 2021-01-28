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

// 추가, 수정, 삭제 count, list

let addCount = 0;
let modCount = 1;
var dataList = new Array();
var addModList = new Array(); //배열선언
var delList = new Array();

$(document).ready(function(){
	
	/*
		
		배열 = [];
	   list : [{"code" : code , "decode" : decode, "decode_name" :decode_name , "useYn"  : useYn , "flag" : "A"},
		   		{"code" : code , "decode" : decode, "decode_name" :decode_name , "useYn"  : useYn , "flag" : "U"},
		   		{"code" : code , "decode" : decode, "decode_name" :decode_name , "useYn"  : useYn , "flag" : "D"}]
	*/
	
	
	$("#btnUpdate").click(function(){
		
		// form 부모창에서 자식의 노드로 접근을 한다.
		// this 라는 애로 먼저 속성을 제어하기전에 3개일수도 있고 전체가 될수도 있기에 
		// 체크된 애들만큼만 반복을 시킨다 . 1건이라면 1번만 반복하면되죠? 2개라면 2번만 반복하면 되죠??
		// 아무것도 없는데서 this foreach안에서의 this는 다르다 .
		// 노드로 접근을 할떄 this
		// 체크된 input 박스 foreach 안에의 디스는 체크된 애들을 가르킨다. 
		
		var checkbox = $("input[name='chkCode']:checked");
		
		checkbox.each(function(i) {
			var td_code = $(this).parent().next();
		
			$(this).attr("onclick", "return(false)");
			$(this).prop("name", "mod_chkCode");
 			$(this).prop("class", "chkCode");
			
			td_code.children().prop("disabled", false);
			td_code.children().prop("readonly", true);
			
			td_code.next().children().prop("disabled", false);
			td_code.next().children().prop("readonly", true);
			
			td_code.next().next().children().prop("disabled", false);
			
			td_code.next().next().next().children().eq(0).prop("name", "mod_useYn_"+(modCount))
			td_code.next().next().next().children().eq(0).prop("disabled", false);
			td_code.next().next().next().children().eq(2).prop("name", "mod_useYn_"+(modCount))
			td_code.next().next().next().children().eq(2).prop("disabled", false);	

			modCount++;
		})
 		$('input:checkbox[id="chkCode"]').prop("checked",false);
	})
	
	$("#delCode").click(function(){
		$("input[name='add_chkCode']:checked").prop('disabled', true);
		$("input[name='mod_chkCode']:checked").prop('disabled', true);
		
		var checkbox = $("input[name='chkCode']:checked");
		
		for(var i=0; i<checkbox.length; i++){
			delList.push({"flag" : "D", DECODE : checkbox[i].value});		
		}
		
		if(checkbox.length > 0) {
			checkbox.each(function(i) {		
				var tr = $(this).parent().parent();
				var td_chkCode = $(this).parent();

				tr.prop("style", "background: red;")
				
				$(this).prop("id", "chkCode");
				td_chkCode.next().children().prop("disabled", true);
				td_chkCode.next().next().children().prop("disabled", true);
				td_chkCode.next().next().next().children().prop("disabled", true);
				td_chkCode.next().next().next().next().children().eq(0).prop("disabled", true);
				td_chkCode.next().next().next().next().children().eq(2).prop("disabled", true);			

				$('input:checkbox[name="chkCode"]').prop("checked",false);
			})
		  	console.log('delList : ' + delList);
		} else {
			if(confirm('삭제리스트를 초기화 하시겠습니까?')) {
				$('input:checkbox[name="chkCode"]').parent().parent().prop("style", "background: none;");
				delList = [];
			  	console.log('delList : ' + delList);
			}
		}
		$("input[name='add_chkCode']:checked").prop('disabled', false);
		$("input[name='mod_chkCode']:checked").prop('disabled', false);	
	})
});
		
 	function checkCode() {
 		// 값없이 완료 누를 경우
 		if(addCount == 0 && modCount == 1 && delList.length == 0) {
 			alert('처리할 항목이 존재하지 않습니다.');
 			return false;
 		}

		// 유효성 검사
 		var decode = document.getElementsByName('decode');
		var decode_name = document.getElementsByName('decode_name');
		
		console.log(decode.length)
		console.log(decode_name.length)
		
		// 공백만 보낼 경우
	 	for(var i=0; i<decode.length; i++){
	 		if(decode[i].value.replace(' ','').length < 1 || decode_name[i].value.replace(' ','').length < 1){
	 			alert('1자 이상의 값을 입력해주세요');
	 			return false;
	 		}
	 	}
		
 		// input값 사이에 중복코드가 존재하는지 체크
		for(var i=1; i<decode.length; i++) {
			for(var j=0; j<i; j++){
				if(decode[i].value == decode[j].value){
					alert('중복된 코드가 존재합니다.');
					return false;
				}
			}
		}	
		
		// DB에 이미 코드가 존재하는지 체크
  		$.ajax({
			url: "./commonCodeChk.ino",
			type: "POST",
			data: $("#frm").serialize(),
			success: function(data){
				if(data != 0) {
					alert('중복코드가 ' + data + '개 존재합니다.');
					return false;
				} else {
					alert('중복코드가 존재하지 않습니다.');
					$('input:text[name="add_decode"]').prop("name", "decode");	
					regCode();
				}
			}
		})
	}
 	
 	function regCode() {
 		
		// addList
		var addCheckbox = $("input[name='add_chkCode']:checked");

		console.log(addCheckbox.length);
		
		if(addCheckbox.length > 0) {
			addCheckbox.each(function(i) {	
				var code = $(this).parent().next().children().val();
				var	decode = $(this).parent().next().next().children().val();
				var decode_name = $(this).parent().next().next().next().children().val();
				var td_useYn = $(this).parent().next().next().next().next();
				
				if(td_useYn.children().eq(0).prop('checked')){
					var useYn = 'Y';
				} else {
					var useYn = 'N';
				}

				addModList.push({"flag" : "I" , CODE : code, DECODE : decode, DECODE_NAME : decode_name, USE_YN : useYn});
			})
		}
		
		//modList 
		var modCheckbox = $("input[name='mod_chkCode']:checked");
		
		if(modCheckbox.length > 0) {
			modCheckbox.each(function(i) {	
				var	decode = $(this).parent().next().next().children().val();
				var decode_name = $(this).parent().next().next().next().children().val();
				var td_useYn = $(this).parent().next().next().next().next();
				
				if(td_useYn.children().eq(0).prop('checked')){
					var useYn = 'Y';
				} else {
					var useYn = 'N';
				}
				addModList.push({"flag" : "U" , DECODE : decode, DECODE_NAME : decode_name, USE_YN : useYn});
			})
		}
		
		//dataList에 합치기
		for(var i=0; i<addModList.length; i++) {
			dataList.push(addModList[i])
		}
		
		for(var i=0; i<delList.length; i++) {
			dataList.push(delList[i]);
		}
		
		dataList = JSON.stringify(dataList);
		
		console.log(dataList)
 			
		$.ajax({
			url: "./regCodeDetail.ino",
			type: "POST",
			async: false,
			data: dataList,
			contentType : "application/json; charset=utf-8",
			success: function(data){
				addCount = 0;
				modCount = 1;
				alert(data.regMsg);
				location.href='./commonCodeDetail.ino?num='+`${CODE}`
			}
		})
 	}
 	
	function createInsCode() {
		if(addCount >= 3) {
			alert('한번에 최대 3개의 코드를 등록할 수 있습니다.')
			return false;
		}
		
		var tr = document.createElement('tr');
		
		var td_chkCode = document.createElement('td');
		var chkCode = document.createElement('input');
		chkCode.setAttribute('name', 'add_chkCode');
 		chkCode.setAttribute('class', 'chkCode');
		chkCode.setAttribute('type', 'checkbox');
		chkCode.setAttribute('checked', 'true');
		chkCode.setAttribute('onclick', 'return(false)');
		td_chkCode.append(chkCode);
		
		var td_code = document.createElement('td');
		var input_code = document.createElement('input');
		input_code.setAttribute("type", "text");
		input_code.setAttribute("name", "code");
		input_code.setAttribute("value", `${CODE}`);
		input_code.setAttribute("readonly", "true");
		td_code.append(input_code);
		
		var td_decode = document.createElement('td');
		var input_decode = document.createElement('input');
		input_decode.setAttribute("type", "text");
		input_decode.setAttribute("name", "add_decode");
		input_decode.setAttribute("required", "true");
		td_decode.append(input_decode);
		
		var td_decode_name = document.createElement('td');
		var input_decode_name = document.createElement('input');
		input_decode_name.setAttribute("type", "text");
		input_decode_name.setAttribute("required", "true");
		input_decode_name.setAttribute("name", "decode_name");
		td_decode_name.append(input_decode_name);
		
		var td_useYn = document.createElement('td');
		
		var input_use = document.createElement('input');
		input_use.setAttribute("type", "radio");
		input_use.setAttribute("id", "Y");
		input_use.setAttribute("name", "useYn_"+(addCount+1));
		input_use.setAttribute("checked", "true");
		input_use.setAttribute("value", "Y");
		var label_use = document.createElement('label');
		label_use.setAttribute("for", "Y");
		label_use.innerText = 'Y';
		
		var input_notUse = document.createElement('input');
		input_notUse.setAttribute("type", "radio");
		input_notUse.setAttribute("id", "N");
		input_notUse.setAttribute("name", "useYn_"+(addCount+1));
		input_notUse.setAttribute("value", "N");
		var label_notUse = document.createElement('label');
		label_notUse.setAttribute("for", "N");
		label_notUse.innerText = 'N';
	
		td_useYn.append(input_use);
		td_useYn.append(label_use);
		td_useYn.append(input_notUse);
		td_useYn.append(label_notUse);
			
		tr.append(td_chkCode);
		tr.append(td_code);
		tr.append(td_decode);
		tr.append(td_decode_name);
		tr.append(td_useYn);
		tbody.append(tr);
		
		addCount++;
	}
</script>
</head>
<body>
	<form id="frm" onsubmit="return false">
		<div style="text-align:right">
			<input type="button" value="완료" onclick="checkCode()"/>
			<input type="button" value="추가" onclick="createInsCode()">
			<input type="button" id="btnUpdate" name="btnUpdate" value="수정"><!--  onclick="createModCode() -->
			<input type="button" id="delCode" name="delCode" value="삭제">
		</div>
		<div>
			<table id="table">
				<thead>
					<tr>
						<td>선택</td>
						<td>코드</td>
						<td>코드값</td>
						<td>코드명</td>
						<td>사용여부</td>
						<td></td>
					</tr>
				</thead>
				<tbody id="tbody">
					<c:forEach var="nRow" items="${list}" varStatus="status">
						<tr>
							<td><input type="checkbox" name="chkCode" class="chkCode" value="${nRow.DECODE }"></td>
							<td><input type="text" name="code" value="${nRow.CODE }" disabled="disabled"></td>
							<td><input type="text" name="decode" value="${nRow.DECODE }" disabled="disabled"></td>	
							<td><input type="text" name="decode_name" value="${nRow.DECODE_NAME }" disabled="disabled"></td>
<%-- 							<td><input type="text" name="useYn" value="${nRow.USE_YN }" disabled="disabled"></td> --%>
	 						<td>
							<c:if test="${nRow.USE_YN == 'Y'}">
								<input type="radio" name="useYn_${status.count}" id="Y" value="Y" checked disabled>
								<label for="Y">Y</label>
								<input type="radio" name="useYn_${status.count}" id="N" value="N" disabled>
								<label for="N">N</label>
							</c:if>
							<c:if test="${nRow.USE_YN == 'N'}">
								<input type="radio" name="useYn_${status.count}" id="Y" value="Y" disabled=>
								<label for="Y">Y</label>
								<input type="radio" name="useYn_${status.count}" id="N" value="N" checked disabled>
								<label for="N">N</label>
							</c:if>
							</td>
						</tr>
					</c:forEach>			
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>