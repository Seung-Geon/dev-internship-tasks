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

		$j("#boardDelete").on("click", function(){	
			
			var param = JSON.stringify(pathVariable);
			
			//console.log(param);
			//console.log(pageNo);			
			$j.ajax({
				url: "/board/boardDeleteAction.do",
				dataType: "json",
				type: "DELETE",
				data: param,
				contentType: "application/json",
				success: function(data,textStatus, jqXHR) {
					alert("삭제완료");
					alert("메시지: " + data.success);
					location.href = "/board/boardList.do?pageNo=" + pageNo;
				},
				error: function (jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		});
		
		$j("#boardModifyMode").on("click", function() {
			location.href = "/board/"+pathVariable.boardType +"/" + pathVariable.boardNum + "/boardModify.do?pageNo=" + pageNo ;
		});
	});
	
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
        	<input id="boardModifyMode" type="button" value="수정">
			<input id="boardDelete" type="button" value="삭제">
		</td>
	</tr>
</table>	
</body>
</html>