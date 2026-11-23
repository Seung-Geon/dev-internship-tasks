<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>recruitMain</title>
</head>
<script type="text/javascript">

	var submit;	// 제출 여부
	var educationCnt = 1;
	var careerCnt = 1;
	var certificateCnt = 1;
	
	$j(document).ready(function(){
		
		$j.ajax({
			url: "/recruit/mainContent.do",
		    dataType: "json",
			type: "POST",
			contentType: "application/json",
			success: function(data, textStatus, jqXHR) {
				
				if (data.success === "N") {
					location.href = "/recruit/login.do";
				}
				
				// 가져온 데이터를 적용하기				
				var info = (data && data.recruit) ? data.recruit : data;

				if (!info) {
					alert("조회된 데이터가 없습니다.");
					return;
				}

				var recruitVo = info.recruitVo;
				var educationList = info.educationList;
				var	careerList = info.careerList;
				var certificateList = info.certificateList;
				
				if(recruitVo !== undefined && recruitVo !== null) {
					// 1) 개인 신상 채우기 
					if (recruitVo.name !== undefined && recruitVo.name !== null) {
						$j("#name").val(recruitVo.name);
						$j("#name").prop("readonly", true);
					}
			
					if (recruitVo.birth !== undefined && recruitVo.birth !== null) {
						$j("#birth").val(recruitVo.birth)
					}		
			
					if (recruitVo.gender !== undefined && recruitVo.gender !== null) {
						$j("#gender").val(recruitVo.gender);
					}
	
					if (recruitVo.phone !== undefined && recruitVo.phone !== null) {
						$j("#phone").val(recruitVo.phone);
						$j("#phone").prop("readonly", true);
					}
					
					if (recruitVo.email !== undefined && recruitVo.email !== null) {
						$j("#email").val(recruitVo.email);
					}
					
					if (recruitVo.addr !== undefined && recruitVo.addr !== null) {
						$j("#addr").val(recruitVo.addr);
					}
					
					if (recruitVo.location !== undefined && recruitVo.location !== null) {
						$j("#location").val(recruitVo.location);
					}
					
					if (recruitVo.workType !== undefined && recruitVo.workType !== null) {
						$j("#workType").val(recruitVo.workType);
					}
					
					submit = recruitVo.submit;
				}
				// 2) 학력 채우기
				if (Array.isArray(educationList) && educationList.length > 0) {
					
					$j("#educationList tr:gt(0)").remove();
					
					educationCnt = 0;
					
					educationList.forEach(function(item) {
						
						educationCnt += 1;
						
						var startPeriod  = item.startPeriod  || "";
						var endPeriod = item.endPeriod || "";
						var schoolName = item.schoolName || "";
						var major = item.major || "";
						var grade = item.grade || "";
						
						var newHtml = 
				            '<tr>' +
			                '<td><input type="checkbox" id="education_' + educationCnt + '"></td>' +
			                '<td>' +
			                    '<input type="text" id="eduStartPeriod_' + educationCnt + '" name="eduStartPeriod_' + educationCnt + '" value="' + startPeriod + '"><br>' +
			                    '~<br>' +
			                    '<input type="text" id="eduEndPeriod_' + educationCnt + '" name="eduEndPeriod_' + educationCnt + '" value="' + endPeriod + '">' +
			                '</td>' +
			                '<td align="center">' +
			                    '<select id="division_' + educationCnt + '" name="division_' + educationCnt + '">' +
				                    '<option value="">미선택</option>' +
			                    	'<option value="졸업"' + (item.division === '졸업' ? ' selected' : '') + '>졸업</option>' +
			                        '<option value="재학"' + (item.division === '재학' ? ' selected' : '') + '>재학</option>' +
			                        '<option value="중퇴"' + (item.division === '중퇴' ? ' selected' : '') + '>중퇴</option>' +
			                    '</select>' +
			                '</td>' +
			                '<td>' +
			                    '<input id="schoolName_' + educationCnt + '" name="schoolName_' + educationCnt + '" type="text" value="' + schoolName + '"> ' +
			                    '<select id="edulocation_' + educationCnt + '" name="edulocation_' + educationCnt + '">' +
			                        '<option value="">미선택</option>' +
			                    	'<option value="서울">서울</option>' +
			                        '<option value="경기">경기</option>' +
			                        '<option value="인천">인천</option>' +
			                        '<option value="부산">부산</option>' +
			                        '<option value="대구">대구</option>' +
			                        '<option value="광주">광주</option>' +
			                        '<option value="대전">대전</option>' +
			                        '<option value="울산">울산</option>' +
			                        '<option value="세종">세종</option>' +
			                        '<option value="강원">강원</option>' +
			                        '<option value="충북">충북</option>' +
			                        '<option value="충남">충남</option>' +
			                        '<option value="전북">전북</option>' +
			                        '<option value="전남">전남</option>' +
			                        '<option value="경북">경북</option>' +
			                        '<option value="경남">경남</option>' +
			                        '<option value="제주">제주</option>' +
			                    '</select>' +
			                '</td>' +
			                '<td><input id="major_' + educationCnt + '" name="major_' + educationCnt + '" type="text" value="' + major + '"></td>' +
			                '<td><input id="grade_' + educationCnt + '" name="grade_' + educationCnt + '" type="text" value="' + grade + '"></td>' +
			            '</tr>';
			            
			        	$j("#educationList").append(newHtml);
			        
			        	if (item.location) {
			           		$j("#edulocation_" + educationCnt).val(item.location);
			        	}
						
					});
				}
				// 3) 경력 채우기
				if (Array.isArray(careerList) && careerList.length > 0) {
					
					$j("#careerList tr:gt(0)").remove();
					
					careerCnt = 0;
					
					careerList.forEach(function(item) {
						careerCnt += 1;
						
						var carStartPeriod = item.startPeriod || "";
						var carEndPeriod = item.endPeriod || "";
						var compName = item.compName || "";
						var task = item.task || "";
						var carLocation = item.location || "";
						
						var newHtml =
				            '<tr>' +
			                '<td><input id="career_' + careerCnt + '" type="checkbox"></td>' +
			                '<td>' +
			                    '<input type="text" id="carStartPeriod_' + careerCnt + '" name="carStartPeriod_' + careerCnt + '" value="' + carStartPeriod + '"><br>' +
			                    '~<br>' +
			                    '<input type="text" id="carEndPeriod_' + careerCnt + '" name="carEndPeriod_' + careerCnt + '" value="' + carEndPeriod + '">' +
			                '</td>' +
			                '<td><input type="text" id="compName_' + careerCnt + '" name="compName_' + careerCnt + '" value="' + compName + '"></td>' +
			                '<td><input type="text" id="task_' + careerCnt + '" name="task_' + careerCnt + '" value="' + task + '"></td>' +
			                '<td><input type="text" id="carLocation_' + careerCnt + '" name="carLocation_' + careerCnt + '" value="' + carLocation + '"></td>' +
			            '</tr>';
			            
				        $j("#careerList").append(newHtml);
					});				
				}
				
				// 4) 자격증 채우기
				if (Array.isArray(certificateList) && certificateList.length > 0) {
					$j("#certificateList tr:gt(0)").remove();
					
					certificateCnt = 0;
					
					certificateList.forEach(function(item) {
						
						certificateCnt += 1;
						
						var qualifiName = item.qualifiName || "";
						var acquDate = item.acquDate || "";
						var organizeName = item.organizeName || "";
						
						var newHtml =
							
				            '<tr>' +
			                	'<td><input id="certificate_' + certificateCnt + '" type="checkbox"></td>' +
			                	'<td><input id="qualifiName_' + certificateCnt + '" name="qualifiName_' + certificateCnt + '" type="text" value="' + qualifiName + '"></td>' +
			                	'<td><input id="acquDate_' + certificateCnt + '" name="acquDate_' + certificateCnt + '" type="text" value="' + acquDate + '"></td>' +
			                	'<td><input id="organizeName_' + certificateCnt + '" name="organizeName_' + certificateCnt + '" type="text" value="' + organizeName + '"></td>' +
			            	'</tr>';
			            
			        	$j("#certificateList").append(newHtml);
						
					});	
				}
				
				
				if (submit === "Y") {
					// 모든 input 요소에 readonly 적용
					// .prop("readonly", true)
					// 드랍다운 또는 체크박스의 경우 readonly가 안먹히므로 disabled를 사용
					// .prop("disabled", true)
					
					// 1. 일반 텍스트 입력창만 읽기 전용(readonly)으로 변경
				    $j("input[type='text']").prop("readonly", true);
				    
				    // 2. 드롭다운(select), 체크박스(input[type='checkbox']), 그리고 추가/삭제/저장/제출 버튼 비활성화
				    $j("select, input[type='checkbox'], input[type='button']").prop("disabled", true);
					
				}
			},
			error: function() {
				alert("실패");
			}
			
		});

		// 학려 버튼
		$j("#addEducation").on("click", function() {
		    educationCnt += 1;
		    
		    var newHtml = 
		        '<tr>' +
		            '<td><input type="checkbox" id="education_' + educationCnt + '"></td>' +
		            '<td>' +
		                '<input type="text" id="eduStartPeriod_' + educationCnt + '" name="eduStartPeriod_' + educationCnt + '"><br>' +
		                '~<br>' +
		                '<input type="text" id="eduEndPeriod_' + educationCnt + '" name="eduEndPeriod_' + educationCnt + '">' +
		            '</td>' +
		            '<td align="center">' +
		                '<select id="division_' + educationCnt + '" name="division_' + educationCnt + '">' +
		                    '<option value="">미선택</option>' +
		                	'<option value="졸업">졸업</option>' +
		                    '<option value="재학">재학</option>' +
		                    '<option value="중퇴">중퇴</option>' +
		                '</select>' +
		            '</td>' +
		            '<td>' +
		                '<input id="schoolName_' + educationCnt + '" name="schoolName_' + educationCnt + '" type="text"> ' +
		                '<select id="edulocation_' + educationCnt + '" name="edulocation_' + educationCnt + '">' +
	                    	'<option value="">미선택</option>' +
		                	'<option value="서울">서울</option>' +
		                    '<option value="경기">경기</option>' +
		                    '<option value="인천">인천</option>' +
		                    '<option value="부산">부산</option>' +
		                    '<option value="대구">대구</option>' +
		                    '<option value="광주">광주</option>' +
		                    '<option value="대전">대전</option>' +
		                    '<option value="울산">울산</option>' +
		                    '<option value="세종">세종</option>' +
		                    '<option value="강원">강원</option>' +
		                    '<option value="충북">충북</option>' +
		                    '<option value="충남">충남</option>' +
		                    '<option value="전북">전북</option>' +
		                    '<option value="전남">전남</option>' +
		                    '<option value="경북">경북</option>' +
		                    '<option value="경남">경남</option>' +
		                    '<option value="제주">제주</option>' +
		                '</select>' +
		            '</td>' +
		            '<td><input id="major_' + educationCnt + '" name="major_' + educationCnt + '" type="text"></td>' +
		            '<td><input id="grade_' + educationCnt + '" name="grade_' + educationCnt + '" type="text"></td>' +
		        '</tr>';
		        
		    $j("#educationList").append(newHtml);
		});
		
		$j("#removeEducation").on("click", function() {
			var checkedBoxes = $j("#educationList input[type='checkbox']:checked");
			
			if(checkedBoxes.length === 0) {
				alert("삭제할 항목을 선택해 주세요.");
				return;
			}
			
			var totalRows = $j("#educationList tr").length -1;
			if(totalRows - checkedBoxes.length < 1) {
				alert("최소 1개의 학력 정보는 남겨두어야 합니다.");
				return;
			}
			
			checkedBoxes.closest("tr").remove();
			
			reindexEducation();
		});
		
		//  경력 추가 버튼
		$j("#addCareer").on("click", function() {
		    careerCnt += 1;
		    
		    var newHtml = 
		        '<tr>' +
		            '<td><input id="career_' + careerCnt + '" type="checkbox"></td>' +
		            '<td>' +
		                '<input type="text" id="carStartPeriod_' + careerCnt + '" name="carStartPeriod_' + careerCnt + '"><br>' +
		                '~<br>' +
		                '<input type="text" id="carEndPeriod_' + careerCnt + '" name="carEndPeriod_' + careerCnt + '">' +
		            '</td>' +
		            '<td><input type="text" id="compName_' + careerCnt + '" name="compName_' + careerCnt + '"></td>' +
		            '<td><input type="text" id="task_' + careerCnt + '" name="task_' + careerCnt + '"></td>' +
		            '<td><input type="text" id="carLocation_' + careerCnt + '" name="carLocation_' + careerCnt + '"></td>' +
		        '</tr>';
		        
		    $j("#careerList").append(newHtml);
		});

		// 경력 삭제 버튼
		$j("#removeCareer").on("click", function() {
		    var checkedBoxes = $j("#careerList input[type='checkbox']:checked");
		    
		    if (checkedBoxes.length === 0) {
		        alert("삭제할 경력 항목을 선택해 주세요.");
		        return;
		    }

		    checkedBoxes.closest("tr").remove();
		 	reindexCareer();
		});
		
		
		$j("#addCertificate").on("click", function() {
		    certificateCnt += 1;
		    
		    var newHtml = 
		        '<tr>' +
		            '<td><input id="certificate_' + certificateCnt + '" type="checkbox"></td>' +
		            '<td><input id="qualifiName_' + certificateCnt + '" name="qualifiName_' + certificateCnt + '" type="text"></td>' +
		            '<td><input id="acquDate_' + certificateCnt + '" name="acquDate_' + certificateCnt + '" type="text"></td>' +
		            '<td><input id="organizeName_' + certificateCnt + '" name="organizeName_' + certificateCnt + '" type="text"></td>' +
		        '</tr>';
		        
		    $j("#certificateList").append(newHtml);
		});

		$j("#removeCertificate").on("click", function() {
		    var checkedBoxes = $j("#certificateList input[type='checkbox']:checked");
		    
		    if (checkedBoxes.length === 0) {
		        alert("삭제할 자격증 항목을 선택해 주세요.");
		        return;
		    }
		    

		    checkedBoxes.closest("tr").remove();
		    reindexCertificate();
		});

		
		
		// 저장 버튼
		$j("#saveBtn").on("click", function() {
			
			submit = "N";
			sendRecruit();
		});
		
		// 제출 버튼
		$j("#submitBtn").on("click", function() {
			
			submit = "Y";
			sendRecruit();
		});
	});
	
	function reindexEducation() {
	    // 헤더(첫 번째 tr)를 제외한 모든 데이터 행을 순회
	    $j("#educationList tr:gt(0)").each(function(index) {
	        var newNum = index + 1; // 1부터 다시 시작
	        
	        // 현재 행(tr) 내부의 모든 input, select 태그의 id와 name 끝자리 숫자를 교체
	        $j(this).find("input, select").each(function() {
	            var oldId = $j(this).attr("id");
	            var oldName = $j(this).attr("name");
	            
	            if (oldId) {
	                $j(this).attr("id", oldId.replace(/_\d+$/, "_" + newNum));
	            }
	            if (oldName) {
	                $j(this).attr("name", oldName.replace(/_\d+$/, "_" + newNum));
	            }
	        });
	    });
	    
	    // 전역 카운트 변수도 현재 남은 행 개수로 동기화
	    educationCnt = $j("#educationList tr:gt(0)").length;
	}
	
	function reindexCareer() {
	    $j("#careerList tr:gt(0)").each(function(index) {
	        var newNum = index + 1;
	        
	        $j(this).find("input").each(function() {
	            var oldId = $j(this).attr("id");
	            var oldName = $j(this).attr("name");
	            
	            if (oldId) {
	                $j(this).attr("id", oldId.replace(/_\d+$/, "_" + newNum));
	            }
	            if (oldName) {
	                $j(this).attr("name", oldName.replace(/_\d+$/, "_" + newNum));
	            }
	        });
	    });
	    
	    // 카운트 변수도 현재 행 개수와 동기화
	    careerCnt = $j("#careerList tr:gt(0)").length;
	}
	
	function reindexCertificate() {
	    $j("#certificateList tr:gt(0)").each(function(index) {
	        var newNum = index + 1;
	        
	        $j(this).find("input").each(function() {
	            var oldId = $j(this).attr("id");
	            var oldName = $j(this).attr("name");
	            
	            if (oldId) {
	                $j(this).attr("id", oldId.replace(/_\d+$/, "_" + newNum));
	            }
	            if (oldName) {
	                $j(this).attr("name", oldName.replace(/_\d+$/, "_" + newNum));
	            }
	        });
	    });
	    
	    // 카운트 변수도 현재 행 개수와 동기화
	    certificateCnt = $j("#certificateList tr:gt(0)").length;
	}
	
	function sendRecruit() {
		
		if(!validationRecruitVo(recruitVo)) { return; }
		if(!validationEducationList(educationList)) { return; }
		if(!validationCareerList(careerList)) { return; }
		if(!validationCertificateList(certificateList)) { return; }
		
		// 각 데이터 가져오기
		var recruitVo = {
				name: $j("#name").val(),
				birth: $j("#birth").val(),
				gender: $j("#gender").val(),
				phone: $j("#phone").val(),
				email: $j("#email").val(),
				addr: $j("#addr").val(),
				location: $j("#location").val(),
				workType: $j("#workType").val(),
				submit: submit
		}
		var educationList = [];
		if(educationCnt !== 0) {
			$j("#educationList tr:gt(0)").each(function() {
				
				educationList.push({
					schoolName: $j(this).find("input[name^='schoolName']").val(),
					division: $j(this).find("select[name^='division']").val(),
					startPeriod: $j(this).find("input[name^='eduStartPeriod']").val(),
					endPeriod: $j(this).find("input[name^='eduEndPeriod']").val(),
					major: $j(this).find("input[name^='major']").val(),
					grade: $j(this).find("input[name^='grade']").val(),
					location: $j(this).find("select[name^='edulocation']").val()	
				});
			});
		}
		
		var careerList = [];
		if(careerCnt !== 0) {
			$j("#careerList tr:gt(0)").each(function() {
		        careerList.push({
		            compName: $j(this).find("input[name^='compName']").val(),
		            location: $j(this).find("input[name^='carLocation']").val(),
		        	startPeriod: $j(this).find("input[name^='carStartPeriod']").val(),
		            endPeriod: $j(this).find("input[name^='carEndPeriod']").val(),
		            task: $j(this).find("input[name^='task']").val()
		        });
			});
		}
		
		var certificateList = [];
		if(certificateCnt !== 0) {
			$j("#certificateList tr:gt(0)").each(function() {
		        certificateList.push({
		            qualifiName: $j(this).find("input[name^='qualifiName']").val(),
		            acquDate: $j(this).find("input[name^='acquDate']").val(),
		            organizeName: $j(this).find("input[name^='organizeName']").val()
		        });
			});
		}
		
		var sendData = {
			"recruitVo": recruitVo,
			"educationList": educationList,
			"careerList": careerList,
			"certificateList": certificateList
		};
		
		$j.ajax({
			url: "/recruit/recruitSend.do",
			type: "POST",
			dataType: "JSON",
			contentType: "application/json",
			data : JSON.stringify(sendData),
			success: function(data, textStatus, jqXHR) {			
				
				if(data.success === "Y") {
					if(submit === "Y") {
						alert("제출이 완료되었습니다.");
					} else {
						alert("임시 저장되었습니다.")
					}					
					location.reload();	
				}
				else if(data.success === "N") {
					alert(data.message);
				}
				
			},
			error: function(jqXHR, textStatus, errorThrown) {
			   	alert("실패");
			}
		})
		
		
	}
	
	function validationRecruitVo() {
		// 이름
		var nameVal = $j.trim($j("#name").val() || "");
		if (nameVal === "") {
			alert("이름을 입력해주세요");
			$j("#name").focus();
			return false;
		}

		// 생년월일
		var birthVal = $j.trim($j("#birth").val() || "");
		if (birthVal === "") {
			alert("생년월일을 입력해주세요");
			$j("#birth").focus();
			return false;
		}
		var birthRegex = /^[0-9]{6}$/;
		if (!birthRegex.test(birthVal)) {
			alert("생년월일은 주민번호 앞자리 6개로 입력해주세요.");
			$j("#birth").focus();
			return false;
		}

		// 성별
		var genderVal = $j("#gender").val();
		if (genderVal === null || genderVal === "") {
			alert("성별을 선택해주세요.");
			$j("#gender").focus();
			return false;
		}

		// 연락처
		var phoneVal = $j.trim($j("#phone").val() || "");
		if (phoneVal === "") {
			alert("연락처를 입력해주세요");
			$j("#phone").focus();
			return false;
		}
		var phoneRegex = /^[0-9]{11}$/;
		if (!phoneRegex.test(phoneVal)) {
			alert("휴대폰번호는 -없이 숫자 11자리로 입력해주세요.");
			$j("#phone").focus();
			return false;
		}

		// email
		var emailVal = $j.trim($j("#email").val() || "");
		if (emailVal === "") {
			alert("email을 입력해주세요");
			$j("#email").focus();
			return false;
		}

		// 주소
		var addrVal = $j.trim($j("#addr").val() || "");
		if (addrVal === "") {
			alert("주소를 입력해주세요");
			$j("#addr").focus();
			return false;
		}

		// 희망근무지
		var locationVal = $j("#location").val();
		if (locationVal === null || locationVal === "") {
			alert("희망근무지를 선택해주세요.");
			$j("#location").focus();
			return false;
		}

		// 근무형태
		var workTypeVal = $j("#workType").val();
		if (workTypeVal === null || workTypeVal === "") {
			alert("근무형태를 선택해주세요.");
			$j("#workType").focus();
			return false;
		}

		return true;
	}
	
	function validationEducationList() {
		
		var $rows = $j("#educationList tr:gt(0)");
		
		if($rows.length === 0) {
			alert("학력 정보를 입력해주세요.");
			return false;
		}
		
		for(var i = 0; i < $rows.length; i++) {
			var $row = $j($rows[i]);
		
		
			var schoolNameVal = $j.trim($row.find("input[name^='schoolName']").val() || "");
			var divisionVal = $row.find("select[name^='division']").val();
			var startPeriodVal = $j.trim($row.find("input[name^='eduStartPeriod']").val() || "");
			var startPeriodRegex = /^[0-9]{4}\.[0-9]{2}$/;
			var endPeriodVal = $j.trim($row.find("input[name^='eduEndPeriod']").val() || "");
			var endPeriodRegex = /^[0-9]{4}\.[0-9]{2}$/;
			var majorVal = $j.trim($row.find("input[name^='major']").val() || "");
			var gradeVal = $j.trim($row.find("input[name^='grade']").val() || "");
			var locationVal = $row.find("select[name^='edulocation']").val();
			
			// 학교 이름
			if (schoolNameVal === "") {
				alert("학교 이름을 입력해주세요");
				$row.find("input[name^='schoolName']").focus();
				return false;
			}
			
			// 구분
			if(divisionVal === null || divisionVal === "") {
				alert("구분을 선택해주세요")
				$row.find("select[name^='division']").focus();
				return false;
			}
			
			// 입학
			if(startPeriodVal === "") {
				alert("입학일을 입력해주세요.")
				$row.find("input[name^='eduStartPeriod']").focus();
				return false;
			}
			
			// 입학 형식
			if(!startPeriodRegex.test(startPeriodVal)) {
				alert("입학일은 0000.00 형식으로 입력해주세요.");
				$row.find("input[name^='eduStartPeriod']").focus();
				return false;
			}
			
			// 졸업
			if(endPeriodVal === "" && divisionVal !== "재학") {
				alert("졸업(퇴학)일을 입력해주세요.")
				$row.find("input[name^='eduEndPeriod']").focus();
				return false;
			}
			
			// 재학 & 졸업
			if(endPeriodVal !== "" && divisionVal === "재학") {
				alert("재학 중에는 졸업일을 입력할 수 없습니다.");
				$row.find("input[name^='eduEndPeriod']").focus();
				return false;
			}
			
			// 졸업 형식
			if(!endPeriodRegex.test(endPeriodVal) && divisionVal !== "재학") {
				alert("졸업(퇴학)일은 0000.00 형식으로 입력해주세요.");
				$row.find("input[name^='eduEndPeriod']").focus();
				return false;
			}
			
			// YYYY.MM -> YYYYMM 숫자로 변환 후 역전 여부 확인
			var startYm = Number(startPeriodVal.replace(".", ""));
			var endYm = Number(endPeriodVal.replace(".", ""));
			if (startYm > endYm && divisionVal !== "재학") {
				alert("졸업(퇴학)일은 입학일보다 빠를 수 없습니다.");
				$row.find("input[name^='eduEndPeriod']").focus();
				return false;
			}
			
			
			// 전공
			if(majorVal === "") {
				alert("전공을 입력해주세요.");
				$row.find("input[name^='major']").focus();
				return false;
			}
			
			// 학점
			if(gradeVal === "") {
				alert("학점을 입력해주세요.");
				$row.find("input[name^='grade']").focus();
				return false;
			}
			
			// 지역
			if(locationVal === "" || locationVal === null) {
				alert("지역을 선택해주세요.");
				$row.find("select[name^='edulocation']").focus();
				return false;
			}
		}	
		
		return true;
	}
	function validationCareerList() {
		var $rows = $j("#careerList tr:gt(0)");
		
		// 0개 허용
		if($rows.length === 0) { return true; }
		
		// 0개가 아닌 경우
		for(var i = 0; i < $rows.length; i++) {
			var $row = $j($rows[i]);
			
			
            var compNameVal = $j.trim($row.find("input[name^='compName']").val() || "");
            var locationVal = $j.trim($row.find("input[name^='carLocation']").val() || "");
        	var startPeriodVal = $j.trim($row.find("input[name^='carStartPeriod']").val() || "");
            var endPeriodVal = $j.trim($row.find("input[name^='carEndPeriod']").val() || "");
            var taskVal = $j.trim($row.find("input[name^='task']").val() || "");

            if(compNameVal === "" && 
            		locationVal === "" && 
            		startPeriodVal === "" && 
            		endPeriodVal === "" && 
            		taskVal === "") { continue; }
            
			var startPeriodRegex = /^[0-9]{4}\.[0-9]{2}$/;
			var endPeriodRegex = /^[0-9]{4}\.[0-9]{2}$/;

            // 회사 이름
            if(compNameVal === "") {
            	alert("회사이름을 입력해주세요.");
            	$row.find("input[name^='compName']").focus();
            	return false;
            }
            
            // 근무 지역
            if(locationVal === "") {
            	alert("지역을 입력해주세요.");
            	$row.find("input[name^='carLocation']").focus();
            	return false;
            }
            
            // 입사일
        	if(startPeriodVal === "") {
            	alert("입사일을 입력해주세요.");
            	$row.find("input[name^='carStartPeriod']").focus();
            	return false;
            }
        	
            // 입사일 형식
			if(!startPeriodRegex.test(startPeriodVal)) {
				alert("입사일은 0000.00 형식으로 입력해주세요.");
				$row.find("input[name^='carStartPeriod']").focus();
				return false;
			}
        	
            // 퇴사일
            if(endPeriodVal === "") {
            	alert("퇴사일을 입력해주세요.");
            	$row.find("input[name^='carEndPeriod']").focus();
            	return false;
            }
            
            // 퇴사일 형식
			if(!endPeriodRegex.test(endPeriodVal)) {
				alert("퇴사일은 0000.00 형식으로 입력해주세요.");
				$row.find("input[name^='carEndPeriod']").focus();
				return false;
			}
            
			// YYYY.MM -> YYYYMM 숫자로 변환 후 역전 여부 확인
			var startYm = Number(startPeriodVal.replace(".", ""));
			var endYm = Number(endPeriodVal.replace(".", ""));
			if (startYm > endYm) {
				alert("퇴사일은 입사일보다 빠를 수 없습니다.");
				$row.find("input[name^='carEndPeriod']").focus();
				return false;
			}
            
            // 직무
            if(taskVal === "") {
            	alert("직무를 입력해주세요.");
            	$row.find("input[name^='task']").focus();
            	return false;
            }
		}
		
		return true;
	 
	}
	function validationCertificateList() {
		var $rows = $j("#certificateList tr:gt(0)");
		
		if ($rows.length === 0) {return true;}
		
		for (var i = 0; i < $rows.length; i++) {
			var $row = $j($rows[i]);
			
            var qualifiNameVal = $j.trim($row.find("input[name^='qualifiName']").val() || "");
            var acquDateVal = $j.trim($row.find("input[name^='acquDate']").val() || "");
            var organizeNameVal = $j.trim($row.find("input[name^='organizeName']").val() || "");

            if(qualifiNameVal === "" && 
            		acquDateVal === "" && 
            		organizeNameVal === "" ) { continue; }
            
            var acquDateRegex = /^[0-9]{4}\.[0-9]{2}$/;

			// 자격증명
            if(qualifiNameVal === "") {
            	alert("자격증명을 입력해주세요.");
            	$row.find("input[name^='qualifiName']").focus();
            	return false;
            }
            
			// 취득일
            if(acquDateVal === "") {
            	alert("취득일을 입력해주세요.");
            	$row.find("input[name^='acquDate']").focus();
            	return false;
            }
            
			// 취득일 형식
            if(!acquDateRegex.test(acquDateVal)) {
            	alert("취득일은 0000.00 형식으로 입력해주세요.");
            	$row.find("input[name^='acquDate']").focus();
				return false;
            }
            
			// 발행처
            if(organizeNameVal === "") {
            	alert("발행처를 입력해주세요.");
            	$row.find("input[name^='organizeName']").focus();
            	return false;
            }
		}
		
		return true;
	}
	

</script>
<body>
	<div align="center">
		<h1>입사 지원서</h1>
	</div>
	
	<table align="center" border="1" width="98%"> <tr><td>	
		<table align="center" border="1" id="recruitVo">
			<tr>
				<td align="center">이름</td>
				<td><input id="name" name="name" type="text" value="${recruit.recruitVo.name}"></td>
				<td align="center">생년월일</td>
				<td><input id="birth" name="birth" type="text" value="${recruit.recruitVo.birth}"></td>
			</tr>
			<tr>
				<td align="center">성별</td>
				<td>
					<select id="gender" name="gender">
						<option value="" selected>미선택</option>
						<option value="남성">남성</option>
						<option value="여성">여성</option>
					</select>
				</td>
				<td align="center">연락처</td>
				<td><input id="phone" name="phone" type="text" value="${recruit.recruitVo.phone}"></td>
			</tr>
			<tr>
				<td align="center">email</td>
				<td><input id="email" name="email" type="text"></td>
				<td align="center">주소</td>
				<td><input id="addr" name="addr" type="text"></td>
			</tr>
			<tr>
				<td align="center">희망근무지</td>
				<td>
					<select id="location" name="location">
						<option value="">미선택</option>
						<option value="전국">전국</option>
						<option value="서울">서울</option>
						<option value="경기">경기</option>
						<option value="인천">인천</option>
						<option value="부산">부산</option>
						<option value="대구">대구</option>
						<option value="광주">광주</option>
						<option value="대전">대전</option>
						<option value="울산">울산</option>
						<option value="세종">세종</option>
						<option value="강원">강원</option>
						<option value="충북">충북</option>
						<option value="충남">충남</option>
						<option value="전북">전북</option>
						<option value="전남">전남</option>
						<option value="경북">경북</option>
						<option value="경남">경남</option>
						<option value="제주">제주</option>
					</select>
				</td>
				<td align="center">근무형태</td>
				<td>
					<select id="workType" name="workType">
						<option value="">미선택</option>
						<option value="정규직">정규직</option>
						<option value="계약직">계약직</option>
					</select>
				</td>
			</tr>
		</table>
		
		<div class="education">
			<h2>학력</h2>
			<div align="right">
				<input id="addEducation" type="button" value="추가">
				<input id="removeEducation" type="button" value="삭제">	
			</div>
			
			<table align='center' border="1" id="educationList">
				<tr>
					<td width="24"></td>
					<td align="center" width="181">재학기간</td>
					<td align="center" width="53">구분</td>
					<td align="center" width="181">학교명(소재지)</td>
					<td align="center" width="181">전공</td>
					<td align="center" width="181">학점</td>
				</tr>
				<tr>
					<td><input type="checkbox" id="education_1"></td>
					<td>
						<input type="text" id="eduStartPeriod_1" name="eduStartPeriod_1"><br>
						~<br>
						<input type="text" id="eduEndPeriod_1" name="eduEndPeriod_1">
						
					</td>
					<td align="center">
						<select id="division_1" name="division_1">
							<option value="">미선택</option>
							<option value="졸업">졸업</option>
							<option value="재학">재학</option>
							<option value="중퇴">중퇴</option>
						</select>
					</td>
					<td>
						<input id="schoolName_1" name="schoolName_1" type="text">
						<select id="edulocation_1" name="edulocation_1">
							<option value="">미선택</option>
							<option value="서울">서울</option>
							<option value="경기">경기</option>
							<option value="인천">인천</option>
							<option value="부산">부산</option>
							<option value="대구">대구</option>
							<option value="광주">광주</option>
							<option value="대전">대전</option>
							<option value="울산">울산</option>
							<option value="세종">세종</option>
							<option value="강원">강원</option>
							<option value="충북">충북</option>
							<option value="충남">충남</option>
							<option value="전북">전북</option>
							<option value="전남">전남</option>
							<option value="경북">경북</option>
							<option value="경남">경남</option>
							<option value="제주">제주</option>
						</select>
					</td>
					<td><input id="major_1" name="major_1" type="text"></td>
					<td><input id="grade_1" name="grade_1" type="text"></td>
				</tr>
			</table>
		</div>
	
		<div class="career">
			<h2>경력</h2>
			<div align="right">
				<input id="addCareer" type="button" value="추가">
				<input id="removeCareer" type="button" value="삭제">	
			</div>
			
			<table align='center' border="1" id="careerList">
				<tr>
					<td width="24"></td>
					<td align="center" width="181">근무기간</td>
					<td align="center" width="181">회사명</td>
					<td align="center" width="181">부서/직급/직책</td>
					<td align="center" width="181">지역</td>
				</tr>
				<tr>
		            <td><input id="career_1" type="checkbox"></td>
		            <td>
		                <input type="text" id="carStartPeriod_1" name="carStartPeriod_1"><br>
		                ~<br>
		                <input type="text" id="carEndPeriod_1" name="carEndPeriod_1">
		            </td>
		            <td><input type="text" id="compName_1" name="compName_1"></td>
		            <td><input type="text" id="task_1" name="task_1"></td>
		            <td><input type="text" id="carLocation_1" name="carLocation_1"></td>
		        </tr>
			</table>
		</div>
	
		<div class="cetificate">
			<h2>자격증</h2>
			<div align="right">
				<input id="addCertificate" type="button" value="추가">
				<input id="removeCertificate" type="button" value="삭제">	
			</div>
			
			<table align='center' border="1" id="certificateList">
				<tr>
					<td width="24"></td>
					<td align="center" width="181">자격증명</td>
					<td align="center" width="181">취득일</td>
					<td align="center" width="181">발행처</td>
				</tr>
				<tr>
		        	<td><input id="certificate_1" type="checkbox"></td>
		            <td><input id="qualifiName_1" name="qualifiName_1" type="text"></td>
		            <td><input id="acquDate_1" name="acquDate_1" type="text"></td>
		            <td><input id="organizeName_1" name="organizeName_1" type="text"></td>
		        </tr>
			</table>
		</div>
	</td></tr></table>
	<div align="center">
		<input id="saveBtn" name="saveBtn" type="button" value="저장">
		<input id="submitBtn" name="submitBtn" type="button" value="제출">
	</div>
</body>
</html>