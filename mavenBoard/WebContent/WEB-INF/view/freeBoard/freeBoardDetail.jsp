<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>	 	 
	function chk() {	
		var name = frm.name.value;
		var title = frm.title.value;
 		var title_length = frm.title.value.length;
		
		for(var i=0; i<title_length; i++){ 
			name = name.replace(' ','');
			title = title.replace(' ','');
		}
		
		if(name.length > 10) {
			alert('이름은 10자 미만으로 작성해주세요.')
			return false
		} else if(title.length > 20) {
			alert('제목은 20자 미만으로 작성해주세요.')
			return false
		} 
	
		if(name != '' && title != ''){
			frm.name.value = name;
			modBoard();
		} else {
			alert("이름과 제목을 입력해주세요.");
			return false;
		}
	}
	
	function modBoard() {
		$.ajax({
			url: "./modBoardAjax.ino",
			type: "POST",
			data: $("#frm").serialize(),
			success: function(data){
				alert('글이 수정되었습니다.');
			}
		})
	}
	
	function delBoard() {
		if(confirm('삭제하시겠습니까?')) {
			$.ajax({
				url: "./delBoardAjax.ino",
				type: "POST",
				data: $("#frm").serialize(),
				success: function(data){
					alert('글이 삭제되었습니다.');
					location.href='./main.ino';
				}
			})
		}
	}
		
</script>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form id="frm" name="insertForm" onsubmit="return false">
		<input type="hidden" name="num" value="${map.freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="code_type">
							<option value="01" ${map.freeBoardDto.code_type == '01'?"selected":""}>자유</option>
							<option value="02" ${map.freeBoardDto.code_type == '02'?"selected":""}>익명</option>
							<option value="03" ${map.freeBoardDto.code_type == '03'?"selected":""}>QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" value="${map.freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"  value="${map.freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65"  >${map.freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" onclick="chk()">
					<input type="button" value="삭제" onclick="delBoard()">
					<input type="hidden" name="num" value="${map.freeBoardDto.num}">
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>


<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="수정" onclick="modify()">
		<input type="button" value="삭제" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div> --%>

</body>
</html>