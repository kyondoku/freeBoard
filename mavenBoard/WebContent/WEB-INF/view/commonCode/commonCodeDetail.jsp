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

$(document).ready(function(){
	
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
		
/* 			$(this).parent("#frm").find() */
		
			$(this).prop("id", "mod_chkCode");
			
			td_code.children().prop("name", "mod_code");
			td_code.children().prop("disabled", false);
			td_code.children().prop("readonly", true);
			
			td_code.next().children().prop("name", "mod_decode");
			td_code.next().children().prop("disabled", false);
			td_code.next().children().prop("readonly", true);
			
			td_code.next().next().children().prop("name", "mod_decode_name");
			td_code.next().next().children().prop("disabled", false);
			
			td_code.next().next().next().children().eq(0).prop("name", "mod_useYn_"+(modCount))
			td_code.next().next().next().children().eq(0).prop("disabled", false);
			td_code.next().next().next().children().eq(2).prop("name", "mod_useYn_"+(modCount))
			td_code.next().next().next().children().eq(2).prop("disabled", false);

			modCount++;
		})
 		$('input:checkbox[id="mod_chkCode"]').prop("checked",false);
/* 		$('input:checkbox[id="mod_chkCode"]').each(function() {
			$(this).prop("checked", false);
		}) */
	})
	
	$("#delCode").click(function(){	
		var checkbox = $("input[name='chkCode']:checked");
		
		console.log(checkbox.length)
		console.log(checkbox)
		
		if(checkbox.length > 0) {
			checkbox.each(function(i) {
				delList.push($(this).val())
				console.log('delListLength : ' + delList.length)
				
				var tr = $(this).parent().parent();
				var td_chkCode = $(this).parent();
				tr.prop("style", "background: red;")
				
				$(this).prop("name", "del_chkCode");
				
				td_chkCode.next().children().prop("disabled", true);
				td_chkCode.next().next().children().prop("disabled", true);
				td_chkCode.next().next().next().children().prop("disabled", true);
				td_chkCode.next().next().next().next().children().eq(0).prop("disabled", true);
				td_chkCode.next().next().next().next().children().eq(2).prop("disabled", true);
				
				$('input:checkbox[name="del_chkCode"]').prop("checked",false);
			})
		} else {
			if(confirm('삭제리스트를 초기화 하시겠습니까?')) {
				$('input:checkbox[name="del_chkCode"]').parent().parent().prop("style", "background: none;");
				delList = [];
				console.log('delListLength : ' + delList.length)
			}
		}
	})
	
	
/* 	$("#delCancel").click(function(){
		var checkbox = $("input[name='del_chkCode']:checked");
		console.log('ddddddddddddddddddd')
		
	}); */
	
	
	
});
	
	// 추가, 수정, 삭제 count, list
	let addCount = 0;
	let modCount = 1;
	var delList = [];
	
	function delCancel(obj){
		
		console.log(obj.value);
		console.log(obj.parent())
		
 		var td_decode = $(this).parent().prev().prev().prev();
		
 		td_decode.children().prop("disabled", false)
 		console.log(td_decode.children().val());
 		console.log(td_decode.children().value)

 		
 		
/*  		checkbox.each(function(){
			var decode = $(this).parent().prev().prev().prev().children();
			console.log(decode.value)
 		}) */
		
/* 			console.log(delList.length)
			var tr = $(this).parent().parent();
			var td_chkCode = $(this).parent();
			tr.prop("style", "background: red;")
			
			$(this).prop("disabled", true);
			$(this).prop("name", "del_chkCode");
			
			td_chkCode.next().children().prop("disabled", true);
			td_chkCode.next().next().children().prop("disabled", true);
			td_chkCode.next().next().next().children().prop("disabled", true);
			td_chkCode.next().next().next().next().children().eq(0).prop("disabled", true);
			td_chkCode.next().next().next().next().children().eq(2).prop("disabled", true);
			
			var btn_cancel = document.createElement('button');
			btn_cancel.innerText = '취소';
			btn_cancel.setAttribute('onclick', 'delCancel()');
			td_chkCode.next().next().next().next().next().append(btn_cancel); */
		
		
	}
		
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
					regCode();
				}
			}
		})
	}
 	
 	function regCode() {
		
 		var SerializeData = $("#frm").serialize();
	 	SerializeData += '&delList=' + delList;  			

   		$.ajax({
			url: "./regCodeDetail.ino",
			type: "POST",
			data: SerializeData,
			async: false,
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
		
		var td_code = document.createElement('td');
		var td_code = document.createElement('input');
		td_code.setAttribute("type", "text");
		td_code.setAttribute("name", "code");
		td_code.setAttribute("value", `${CODE}`);
		td_code.setAttribute("readonly", "true");
		
		var td_decode = document.createElement('td');
		var input_decode = document.createElement('input');
		input_decode.setAttribute("type", "text");
		input_decode.setAttribute("name", "decode");
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
 	
  	function delCode() {
  		var chkList = document.getElementsByName('chkCode')
  		for(var i=0; i<chkList.length; i++) {
  			chkList[i].parent().style.backgroundColor = 'red';
  		}
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
							<td><input type="checkbox" name="chkCode" value="${nRow.DECODE }"></td>
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