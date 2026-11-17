<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">

	var pathVariable = getPathVariable();
	var pageNo = getParameterByName('pageNo');

	
	
	$j(document).ready(function() {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
		$j("#boardDelete").on("click", function(){	
			var pathVariable = getPathVariable();
=======
		$j("#boardDelete").on("click", function(){
>>>>>>> fc416f7 (fix: 수정 기능 다시 만들기)
			var param = JSON.stringify(pathVariable);
			//console.log(param);
			//console.log(pageNo);
=======
		
		$j("#boardDelete").on("click", function(){
			
=======
		$j("#boardDelete").on("click", function(){	
>>>>>>> ca3f297 (feat: board 수정 기능 추가)
			var pathVariable = getPathVariable();
			var param = JSON.stringify(pathVariable);
			var pageNo = getParameterByName('pageNo');
<<<<<<< HEAD
			console.log(pageNo);
>>>>>>> a7c3a38 (feat: board 삭제 추가)
=======
			//console.log(param);
			//console.log(pageNo);
>>>>>>> ca3f297 (feat: board 수정 기능 추가)
			
			$j.ajax({
				url: "/board/boardDeleteAction.do",
				dataType: "json",
				type: "DELETE",
				data: param,
				contentType: "application/json",
				success: function(data,textStatus, jqXHR) {
					alert("�����Ϸ�");
					alert("�޽���: " + data.success);
					location.href = "/board/boardList.do?pageNo=" + pageNo;
				},
				error: function (jqXHR, textStatus, errorThrown) {
					alert("����");
				}
			});
		});
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> ca3f297 (feat: board 수정 기능 추가)
		
		$j("#boardModifyMode").on("click", function() {
			location.href = "/board/"+pathVariable.boardType +"/" + pathVariable.boardNum + "/boardModify.do?pageNo=" + pageNo ;
		})
	});
	
<<<<<<< HEAD
	
<<<<<<< HEAD
=======
	});
	
>>>>>>> a7c3a38 (feat: board 삭제 추가)
=======
>>>>>>> ca3f297 (feat: board 수정 기능 추가)
=======
	n
>>>>>>> fc416f7 (fix: 수정 기능 다시 만들기)
	function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), 
        						results = regex.exec(location.search);
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }
	
	function getPathVariable() {
		var path = $j(location).attr('pathname');
		var pathArr = path.split('/')
		
		var pathVariable = {"boardType": pathArr[2], "boardNum": parseInt(pathArr[3])};
		
		return pathVariable
	}
	
</script>
<body>
<table align="center">

	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">Title</td>
					<td width="400">${board.boardTitle}</td>
				</tr>
				<tr>
					<td height="300" align="center">Comment</td>
					<td>${board.boardComment}</td>
				</tr>
				<tr>
					<td align="center">Writer</td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href="/board/boardList.do">List</a>
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> ca3f297 (feat: board 수정 기능 추가)
        	<input id="boardUpdateMode" type="button" value="����">
        	<input id="boardUpdate" type="button" value="����" style="display:none;">
=======
        	<input id="boardModifyMode" type="button" value="����">
>>>>>>> fc416f7 (fix: 수정 기능 다시 만들기)
        	<input id="boardDelete" type="button" value="����">
			
<<<<<<< HEAD
=======
			<input id = "boardDelete" type="button" value = "����">
>>>>>>> a7c3a38 (feat: board 삭제 추가)
=======
>>>>>>> ca3f297 (feat: board 수정 기능 추가)
		</td>
	</tr>
</table>	
</body>
</html>