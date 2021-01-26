<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
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
			insBoard();
		} else {
			alert("이름과 제목을 입력해주세요.");
			return false;
		}
	}
	
 	function insBoard() {
		$.ajax({
			url: "./insBoardAjax.ino",
			type: "POST",
			data: $("#frm").serialize(),
			success: function(data){
				console.log(data)
				switch(data.msg){
				case 'success' :
					frm.code_type.value = '01';
					frm.name.value = '';
					frm.title.value = '';
					frm.content.value = '';
					alert('글 작성에 성공하였습니다.')
					break;
				case 'fail' :
					location.href='./main.ino';
					alert('글 작성에 실패하였습니다.')
					break;
				}
			}
		})
 	}
</script>
</head>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form id="frm" onsubmit="return false">

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="code_type">
							<c:forEach var="nRow" items="${codeList}">
								<option value="${nRow.DECODE}">${nRow.DECODE_NAME}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" onclick="chk()" value="글쓰기">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>
</body>
</html>