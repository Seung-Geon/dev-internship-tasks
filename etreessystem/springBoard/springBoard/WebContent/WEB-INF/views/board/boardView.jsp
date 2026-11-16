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

	$j(document).ready(function() {
<<<<<<< HEAD
		$j("#boardDelete").on("click", function(){	
			var pathVariable = getPathVariable();
			var param = JSON.stringify(pathVariable);
			var pageNo = getParameterByName('pageNo');
			//console.log(param);
			//console.log(pageNo);
=======
		
		$j("#boardDelete").on("click", function(){
			
			var pathVariable = getPathVariable();
			var param = JSON.stringify(pathVariable);
			
			console.log(param);
			
			var pageNo = getParameterByName('pageNo');
			console.log(pageNo);
>>>>>>> a7c3a38 (feat: board ì‚­ì œ ì¶”ê°€)
			
			$j.ajax({
				url: "/board/boardDeleteAction.do",
				dataType: "json",
				type: "DELETE",
				data: param,
				contentType: "application/json",
				success: function(data,textStatus, jqXHR) {
					alert("»èÁ¦¿Ï·á");
					alert("¸Þ½ÃÁö: " + data.success);
					location.href = "/board/boardList.do?pageNo=" + pageNo;
				},
				error: function (jqXHR, textStatus, errorThrown) {
					alert("½ÇÆÐ");
				}
			});
		});
<<<<<<< HEAD
		
		$j("#boardUpdateMode").on("click", function() {
		    $j("#boardTitle").prop("disabled", false).focus();
		    $j("#boardComment").prop("disabled", false);
		    $j("#boardUpdateMode").hide();
		    $j("#boardUpdate").show();
		});
		
		
		$j("#boardUpdate").on("click", function(){	
			var boardVo = getPathVariable();
			boardVo.boardTitle = $j("#boardTitle").val();
			boardVo.boardComment = $j("#boardComment").val();
			
			var param = JSON.stringify(boardVo);
			var pageNo = getParameterByName('pageNo');
			//console.log(param);
			//console.log(pageNo);
			
			$j.ajax({
				url: "/board/boardUpdateAction.do",
				dataType: "json",
				type: "PUT",
				data: param,
				contentType: "application/json",
				success: function(data,textStatus, jqXHR) {
					alert("¼öÁ¤¿Ï·á");
					alert("¸Þ½ÃÁö: " + data.success);
					
				    $j("#boardTitle").prop("disabled", true);
				    $j("#boardComment").prop("disabled", true);
				    $j("#boardUpdateMode").show();
				    $j("#boardUpdate").hide();
				},
				error: function (jqXHR, textStatus, errorThrown) {
					alert("½ÇÆÐ");
				}
			});
		});
	});
	
	
=======
	});
	
>>>>>>> a7c3a38 (feat: board ì‚­ì œ ì¶”ê°€)
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
					<td width="400">
						<input name="boardTitle" id="boardTitle" type="text" value="${board.boardTitle}" disabled style="with: 98%;">
					</td>
				</tr>
				<tr>
					<td height="300" align="center">Comment</td>
					<td>
						<textarea name="boardComment" id="boardComment"  rows="20" cols="55" disabled style="width: 98%;">${board.boardComment}</textarea>
					</td>
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
        	<input id="boardUpdateMode" type="button" value="¼öÁ¤">
        	<input id="boardUpdate" type="button" value="ÀúÀå" style="display:none;">
        	<input id="boardDelete" type="button" value="»èÁ¦">
			
=======
			<input id = "boardDelete" type="button" value = "»èÁ¦">
>>>>>>> a7c3a38 (feat: board ì‚­ì œ ì¶”ê°€)
		</td>
	</tr>
</table>	
</body>
</html>