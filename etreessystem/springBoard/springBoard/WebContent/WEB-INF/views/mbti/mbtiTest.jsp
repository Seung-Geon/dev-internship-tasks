<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>mbtiTest</title>
</head>
<script type="text/javascript">
	
	var pageNo = 1;
	var totalPage = 1;
	$j(document).ready(function(){
		
	    $j(".page-group").each(function(idx){
	        $j(this).attr("data-page", Math.floor(idx / 5) + 1);
	    });
	    totalPage = Math.ceil($j(".page-group").length / 5);
		
	    updatePage();
		
		//이전 버튼 클릭시
		$j("#prev").on("click", function() {
			if(pageNo > 1) {
				pageNo -= 1;
				updatePage();
			}
		});
		
		// 다음 버튼 클릭시
		$j("#next").on("click", function() {

			var unanswered = $j(".page-group[data-page='"+ pageNo +"']").filter(function() {
		        return $j(this).find("input[type='radio']:checked").length === 0;
		    });

		    if (unanswered.length > 0) {
		        alert("모든 문항에 답변해 주세요.");
		        return;
		    }
			
			
			
			if(pageNo < totalPage) {
				pageNo += 1;
				updatePage();
			}
		})
		
		$j("#submitBtn").on("click", function() {
			
		    var unanswered = $j(".page-group").filter(function() {
		        return $j(this).find("input[type='radio']:checked").length === 0;
		    });

		    if (unanswered.length > 0) {
		        pageNo = parseInt(unanswered.first().attr("data-page"), 10);
		        updatePage();   // 미답변 페이지로 이동
		        alert("모든 문항에 답변해 주세요.");
		        return;
		    }
			
		    console.log("제출하자!!");
		    $j(".mbtiTest").submit();
		});
	});
	
	function updatePage() {
		$j(".page-group").hide();
		
		$j(".page-group[data-page='" + pageNo + "']").show();

		if (pageNo === 1) {
			$j("#prev").prop("disabled", true);
		} else {
			$j("#prev").prop("disabled", false);
		}

		if (pageNo === totalPage) {
			$j("#next").hide();
			$j("#submitBtn").show();
		} else {
			$j("#next").show();
			$j("#submitBtn").hide();
		}
	}

</script>
<body>
	<form class="mbtiTest" action="/mbti/mbtiResult.do" method="POST">
		<table align="center">
				<tr><td><table border="1">
				<c:forEach items="${mbtiTestList}" var="list" varStatus="status">
					<tbody class="page-group" >
						<tr>
							<td align="center">Q${status.count}</td>
							<td align="center" width=600>${list.boardComment}</td>
						</tr>
						<tr>
							<td align="center">A${status.count}</td>
							<td align="center">
								<label>동의</label>
								<c:forEach begin="1" end="7" var="i">
									<label class="scale">
										<input type="radio" id="radio_${status.count}_${i}" name="${list.boardType}/${list.boardNum}" value="${i}">		
									</label>
								</c:forEach>
								<label>비동의</label>
							</td>
						</tr>			
					</tbody>
				</c:forEach>
				</table></td></tr>
			<tr>
				<td align = "right">
					<input id = "prev" type="button" value="이전">
					<input id = "next" type="button" value="다음">
					<input id = "submitBtn" type="button" value="제출" style="display: none;">
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>