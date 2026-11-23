<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>recruitLogin</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		$j("#submitBtn").on("click",function() {
			// 폼을 모두 채웠는지 확인하는 로직 추가 필요!!
			
			var unanswered = $j(".loginForm :input").filter(function() {
				return $j.trim($j(this).val()) === "";
			});
		
			if(unanswered.length > 0) {
				alert("모든 항목을 입력해주세요.");
				unanswered.first().focus();
				return false;
			}
			
			var nameVal = $j("#name").val();
			var phoneVal = $j("#phone").val();
			var phoneRegex = /^[0-9]{11}$/;
			
			if (!phoneRegex.test(phoneVal)) {
				alert("휴대폰번호는 -없이 숫자 11자리로 입력해주세요.");
				$j("#phone").focus();
				return false;
			}
			
			
			$j.ajax({
				url: "/recruit/recruitSession.do",
			    dataType: "json",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify({
					"name": nameVal,
					"phone": phoneVal
				}),
				success: function(data, textStatus, jqXHR) {
					
					console.log("이름, 전화번호 세션 저장")
					location.href="/recruit/main.do"
				},
				error: function(jqXHR, textStatus, errorThrown) {
			    	alert("실패");
				}
			});
		});
	});
	

</script>
<body>
	<table align="center" border="1">
		<tr><td>
			<table class="loginForm" border="1">
				<tr>
					<td>이름</td>
					<td><input id="name" name="name" type="text"></td>
				</tr>
				<tr>
					<td>휴대폰번호</td>
					<td><input 	id="phone" name="phone" type="text" placeholder="-없이 입력해주세요"></td>
				</tr>
			</table>
		</td></tr>
		<tr>
			<td align="center"><input id="submitBtn" type="button" value="입사지원"></td>
		</tr>
	</table>
</body>
</html>