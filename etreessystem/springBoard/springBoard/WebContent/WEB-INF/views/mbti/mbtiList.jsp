<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>mbtiList</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		$j("#mbtiTest").on("click", function(){
			location.href = "/mbti/mbtiTest.do";
		});
	});

</script>
<body>
<table  align="center">
	<tr>
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="mbtiTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Comment
					</td>
				</tr>
				<c:forEach items="${mbtiList}" var="list">
					<tr>
						<td align="center">
							${list.boardType}
						</td>
						<td align="center">
							${list.boardNum}
						</td>
						<td>
							${list.boardComment}
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/mbti/mbtiWrite.do">글쓰기</a>
			<input id = "mbtiTest" type="button" value="테스트">
		</td>
	</tr>
</table>	
</body>
</html>