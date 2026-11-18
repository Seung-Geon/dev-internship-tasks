<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>mbtiResult</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){

	});

</script>
<body>
	<table align="center">
		<tr>
			<td align="center">당신의 성격 유형은: </td>
		</tr>
		<tr>
			<td align="center"><h1>${mbtiType}</h1></td>
		</tr>
	</table>
</body>
</html>