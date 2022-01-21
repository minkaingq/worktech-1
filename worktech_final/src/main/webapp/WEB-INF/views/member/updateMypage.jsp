<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<style>
 	table { text-align : center; width : 100%;} 
 	#titleImgArea{width:100px; height: 100px;}
 	#titleImg:hover {cursor: pointer;}
</style>

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- daum 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>나의 정보 수정</title>
</head>

<body>
	<c:import url="../common/headerUser.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>마이페이지</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="${ myPage.me }">마이페이지</a>
					</div>
					<div class="breadcrumb-item">나의 정보 수정</div>
				</div>
			</div>
			
			<div class="section-body">
				<h2 class="section-title">나의 정보 수정</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-body">
							
							<form action="mUpdate.me" method="post" encType="multipart/form-data" id="updateMypageForm">
			                    <div class="form-group">
			                    	<label>프로필 사진</label>
			                    </div>
								
								<!-- Basic avatar examples : https://picturepan2.github.io/spectre/components/avatars.html-->
						             <figure class="avatar avatar-xl" id="titleImgArea">
										<c:choose>									
		   									<c:when test="${ loginUser.profile.pReName eq null }" >
		   										<img id="titleImg" src="resources/dist/assets/img/avatar/avatar-3.png" >
		   									</c:when>
		   									<c:otherwise>
		   										<img id="titleImg" src="resources/profileUploadFiles/${ loginUser.profile.pReName }" >
		   									</c:otherwise>
										</c:choose>
									</figure>
									<br><br><br>
			                    
			                    <!-- 파일 업로드 -->
			                    <div id="fileArea">
			                    	<input type="file" class="form-control" id="proImg" multiple="multiple" name="proImg" onchange="LoadImg(this,1)"> 
			                    </div>
			                    
			         
			                    <div class="form-group">
			                    	<label>사번</label>
			                     	<input type="text" id="mNo" name="mNo"  class="form-control" readonly style="background : white;" value="${ loginUser.mNo }">
			                    </div>
			                    
			                    <div class="form-group">
			                    	<label>이름</label>
			                     	<input type="text" id="name" name="name" class="form-control" readonly style="background : white;" value="${ loginUser.name }">
			                    </div>
			                    
			                    <div class="form-group">
			                    	<label>회사</label>
			                     	<input type="text" id="company" name="company" class="form-control" value="KH" readonly style="background : white;">
			                    </div>
			                    
			                    <div class="form-group">
			                      <label>부서</label>
			                      <input type="text" id="dName" name="dName" class="form-control" readonly style="background : white;" value="${ loginUser.dName }">
			                    </div>
			                    
			                    <div class="form-group">
			                      <label>직급</label>
			                      <input type="text" id="jobGrade" name="jobGrade" class="form-control" readonly style="background : white;" value="${ loginUser.jobGrade }">
			                    </div>
			                    
			                    <div class="form-group">
			                      <label>사내 Email</label>
			                      <input type="email" class="form-control" id="email" name="email" readonly style="background : white;" value="${ loginUser.email }">
			                    </div>
			                    
			                     <div class="form-group">
			                      <label>개인 Email</label>
			                      <input type="email" class="form-control" id="mEmail" name="mEmail"  style="background : white;" value="${ loginUser.mEmail }">
			                    </div>
			                       
			                    
			                    <div class="form-group">
			                      <label>전화번호</label>
			                      <input type="tel" class="form-control" id="phone" name="phone" placeholder="'-'을 제외하고 입력해주세요" value="${ loginUser.phone }">
			                    </div>
			                    
			                    <div class="form-group">
			                      <label>생년월일</label>
			                      <table>
			                      	<tr>
			                      		<td>
			                      			<select name="year" class="form-control">
<!-- 												option을 원하는 개수만큼 돌리기 : for문 사용 -->
												<c:forEach begin="<%= new GregorianCalendar().get(Calendar.YEAR) - 100 %>" 
 															end="<%= new GregorianCalendar().get(Calendar.YEAR) %>" var="i"> 
															
 													<c:if test="${ fn:substring(loginUser.birthDay, 0, 4) == i }"> 
 														<option value="${ i }" selected >${ i }</option>
 													</c:if>
<!-- 													선택한 값이 i와 같지 않다면 : i만 출력 -->
 													<c:if test="${ fn:substring(loginUser.birthDay, 0, 4) != i }"> 
 														<option value="${ i }" >${ i }</option> 
 													</c:if> 
 												</c:forEach> 
											</select>
			                      		</td>
			                      		<td>
			                      			<select name="month" class="form-control">
												<c:forEach begin="1" end="12" var="i">
													<c:if test="${ fn:substring(loginUser.birthDay, 5, 7) == i }">
														<option value="${ i }" selected >${ i }</option>
													</c:if>
													<c:if test="${ fn:substring(loginUser.birthDay, 5, 7) != i }">
														<option value="${ i }" >${ i }</option>
													</c:if>
												</c:forEach>
											</select>
			                      		</td>
			                      		<td>
			                      			<select name="date" class="form-control">
												
												<c:forEach begin="1" end="31" var="i"> 
													<c:if test="${ fn:substring(loginUser.birthDay, 8, 10) == i }">
														<option value="${ i }" selected >${ i }</option>
													</c:if>
													<c:if test="${ fn:substring(loginUser.birthDay, 8, 10) != i }">
														<option value="${ i }" >${ i }</option>
													</c:if>
												</c:forEach>
											</select>
			                      		</td>
			                      	</tr>
			                      </table>
			                    </div>
			                    
			                    <!-- 주소 -->
			                    <c:forTokens var="addr" items="${ loginUser.address }" delims="/" varStatus="status">
									<c:if test="${ status.index eq 0 && addr >= '0' && addr <= '99999' }">
										<c:set var="post" value="${ addr }"/>
									</c:if>
									<c:if test="${ status.index eq 0 && !(addr >= '0' && addr <= '99999') }">
										<c:set var="address1" value="${ addr }"/>
									</c:if>
									<c:if test="${ status.index eq 1 }">
										<c:set var="address1" value="${ addr }"/>
									</c:if>
									<c:if test="${ status.index eq 2 }">
										<c:set var="address2" value="${ addr }"/>
									</c:if>
									<c:if test="${ status.index eq 3 }">
										<c:set var="address3" value="${ addr }"/>
									</c:if>
								</c:forTokens>
								
			                    <div class="form-group">
			                      <label>주소</label>
			                      <!-- https://postcode.map.daum.net/guide : 2. 사용자가 선택한 값 이용하기 -->
			                      	<table>
			                      		<tr>
			                      			<td>
			                      				 <input type="text" id="sample6_postcode" name="post" placeholder="우편번호" class="form-control" value="${ post }">
			                      			</td>
			                      			<td align="left">
			                      				 &nbsp;&nbsp;&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary mr-1"><br>
			                      			</td>
			                      		</tr>
			                      		<tr>
			                      			<td colspan="2">
			                      				 <input type="text" id="sample6_address" name="address1" placeholder="주소" class="form-control" value="${ address1 }">
			                      			</td>
			                      		</tr>
			                      		<tr>
			                      			<td>
			                      				<input type="text" id="sample6_detailAddress" name="address2" placeholder="상세주소" class="form-control" value="${ address2 }">
			                      			</td>
			                      			<td>
			                      				<input type="text" id="sample6_extraAddress" name="address3" placeholder="참고항목" class="form-control" value="${ address3 }">
			                      			</td>
			                      		</tr>
			                      	</table>
			                    </div>
			                   
			                  
								<div class="card-footer text-right">
				                    <button class="btn btn-primary mr-1" type="submit">수정하기</button>
				                    <button class="btn btn-secondary" type="button" onclick="location.href='myPage.me'">취소</button>
								</div>
							
								<!-- 값을 넘겨주기위해 hidden사용 -->
			                    <input type="hidden" class="form-control" name="pwd" value="${ loginUser.pwd }">
			                    <input type="hidden" class="form-control" name="mGrade" value="${ loginUser.mGrade }">
			                    <input type="hidden" class="form-control" name="dNo" value="${ loginUser.dNo }">
			                    <input type="hidden" class="form-control" name="hireDate" value="${ loginUser.hireDate }">
			                    <input type="hidden" class="form-control" name="mStatus" value="${ loginUser.mStatus }">
						 	</form>						
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<c:import url="../common/footer.jsp" />


	<script>
		
		/*------------------------------ 프로필 이미지 ------------------------------*/
		
		// 내용작성 부분의 공간을 클릭할때 파일 첨부 창이 뜨도록 설정
		$(function(){
			$("#fileArea").hide(); // 올리는 버튼 숨기기
			
			$("#titleImgArea").click(function(){
				$("#proImg").click();
			});
		});
		
		
		// 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
		function LoadImg(value, num){
			if(value.files && value.files[0]){ // 파일이 들어왔다고 했을때 
				var reader = new FileReader();
				
				reader.onload = function(e){								
					switch(num){
					//num : loadImg
					case 1: 
						$("#titleImg").attr("src", e.target.result); // 파일에 대한 경로값 집어넣기
						break;
								
					}
				}
							
				reader.readAsDataURL(value.files[0]);  // 여러개 선택시 가장 앞에 있는 파일만 넣기
			}
		}
	
		
		/*------------------------------ daum 주소 API ------------------------------*/
		 function sample6_execDaumPostcode() {
	       	 new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
		}
		
		
	
	</script>
</body>

</html>