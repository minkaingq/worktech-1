<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<style> table{text-align : center;}</style>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
<title>사원 관리</title>
<style>
	
	h4.section-title {
		top: -13px;
		display: inline;
	}
	
	h4.section-title:hover{
		cursor: pointer;
		color: #67d4ef;
	}
	
	#count{margin-bottom : 15px;}
	
	.paging-area {
            display: flex;
            justify-content: center;
    }
    
/*      #searchCondition{ border-radius : 30px; } */

	.searchOption{color : black; 
				  background : white;
/* 				  border : 1px solid skyblue; */
/*   				  border-radius: 4px; */
	}
	
	
</style>
</head>

<body>
	<c:import url="../common/headerAdmin.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>사원관리</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="mList.me">사원관리</a>
					</div>
					<div class="breadcrumb-item">사원목록</div>
				</div>
			</div>
			
			
			<div class="section-body">
				 <div class="row">
	              <div class="col-12">
	                <div class="card">
	                  <div class="card-header">
	                    <!-- 2 -->
	                    <c:url var="adMemList" value="mList.me"/>
								<h4 style="font-size: 20px;" class="section-title" onclick="location.href='${ adMemList }'">사원 목록</h4>
	                    		
	                        <!-- 1 -->
<!-- 	                  	<h4 style="font-size: 20px;">사원 목록</h4> -->
	                    
	                    <div class="card-header-form">
	                     <!-- 검색 : 이름 / 부서 / 직급 -->
<!-- 	                      <form action="memList.me" method="post" id="listForm"> -->
	                        <div class="input-group">   
		                        <select id="searchCondition" name="searchCondition"  class="btn btn-primary dropdown-toggle">
 	                        		<option class="searchOption" value="">검색 조건</option> 
 	                        		<option class="searchOption" value="name">이름</option> 
 	                        		<option class="searchOption" value="department">부서</option> 
 	                        		<option class="searchOption" value="grade">직급</option> 
 	                        	</select> &nbsp;&nbsp;&nbsp; 

	                          <input type="search" class="form-control" placeholder="Search" id="searchValue" name="searchValue">
	                          <div class="input-group-btn">
	                            <button class="btn btn-primary" type="button" onclick="searchBoard();"><i class="fas fa-search"></i></button>
	                          </div>
	                        </div>
<!-- 	                      </form> -->
	                      
	                    </div>
	                  </div>
	                  <div class="card-body">
	                    <div class="table-responsive">
	                      <!-- 관리자를 제외한 사원의 수 -->
	                      <h6 id="count" >총 사원의 수는 <span style="color : #6ED7F9">${ memCount }</span>명 입니다. </h6>
	                      <table class="table table-striped" id="memberTable">
	                        <tr>
	                          <th width="30px;"></th>
	                          <th  class="p-0 text-center">
	                            <div class="custom-checkbox custom-control" >
	                              <input type="checkbox" data-checkboxes="mygroup" data-checkbox-role="dad" class="custom-control-input" id="checkbox-all" onclick="selectAll();">
	                              <label for="checkbox-all" class="custom-control-label">&nbsp;</label>
	                            </div>
	                          </th>
	                          <th>사원 번호</th>
	                          <th>사원 명</th>
	                          <th>부서</th>
	                          <th>직급</th>
	                          <th></th>
	                        </tr>
							<form action="memList.me" method="post" id="listForm">
		                        <c:forEach var="a" items="${ aList }">
			                        <tr class="cls">
			                          <td></td>
			                          <td class="p-0 text-center"  onclick="event.cancelBubble=true;">
			                          </td>
			                          <td onclick="event.cancelBubble=true;">
			                          		<b>${ a.mNo }</b>
			                          		<input type="hidden" id="adminMNo" name="adminMNo" value="${ a.mNo }">
			                          </td>
			                          <td class="align-middle" onclick="event.cancelBubble=true;">
			                          		<b>${ a.name }</b>
			                          		<input type="hidden" id="adminName" name="adminName" value="${ a.name }">
			                          </td>
			                          <td  onclick="event.cancelBubble=true;"><b> - </b></td>
			                          <td  onclick="event.cancelBubble=true;"><b> - </b></td>
			                          <td  onclick="event.cancelBubble=true;"><button class="btn btn-secondary" id="updatePwd">비밀번호 변경</button></td>
			                        </tr>
		                        </c:forEach>
							</form>
	                        <!-- 사원 목록 : 관리자 제외-->
	                        <c:forEach var="m" items="${ mList }">
		                        <tr class="cls">
		                          <td></td>
		                          <td class="p-0 text-center" onclick="event.cancelBubble=true;">
		                          	   <div class="custom-checkbox custom-control">
			                              <input type="checkbox" data-checkboxes="mygroup" class="custom-control-input" id="${ m.mNo }" value ="${ m.mNo }" name="checkB"  onclick="selectOne();">
			                              <label for="${ m.mNo }" class="custom-control-label">&nbsp;</label>
			                           </div>
		                          </td>
		                          <td id="mNo">${ m.mNo }</td> <!-- 사원번호 -->
		                          <td class="align-middle" id="name">${ m.name }</td> <!-- 사원명 -->
		                          <td id="depName">${ m.dName }</td> <!-- 부서 -->
		                          <td id="dGrade">${ m.jobGrade }</td> <!-- 이름 -->
<!-- 		                          <td><button class="btn btn-secondary" type="button" id="oneDelete">삭제</button></td> -->
		                          <td onclick="event.cancelBubble=true;"><button class="btn btn-secondary" id="oneDelete">삭제</button></td>
		                        </tr>
	                        </c:forEach>
	                      </table>
	                      <!-- ※ 첫 페이지의 경우 관리자가 별도로 추가되어있기때문에 10명의 사원이 아니라 11명의 사원이 보임 (수정 필요...?) -->
	                      
	                      <br clear="all">                      
	                      <!-- 페이딩 처리 -->
	                      <div class="card-body paging-area">
	                      	<div class="buttons">
	                      		<nav aria-label="Page navigation example">
	                      			<ul class="pagination">
	                      				<!-- 이전 : 현재 페이지가 1보다 작을때 (맨 첫페이지) -->
	                      				<c:if test="${ pi.currentPage <= 1 }">
	                      					<li class="page-item disabled">
	                      						<a class="page-link" aria-label="Previous">
	                      							<i class="fas fa-angle-double-left"></i> 
	                      						</a>
	                      					</li>
	                      					<li class="page-item disabled">
	                      						<a class="page-link" aria-label="Previous">
	                      							<i class="fas fa-angle-left"></i> 
	                      						</a>
	                      					</li>
	                      				</c:if>
	                      				<!-- 이전 : 현재 페이지가 2이상일때 -->
	                      				<c:if test="${ pi.currentPage > 1 }">
	                      					<!-- 따로 페이지를 입력하는것이 아니라 현재 페이지(?)에 따라 바뀔수 있도록 만들기 : ${ loc } -->
<%-- 	                      					<c:url var="start" value="mList.me">  --%>
	                      					<c:url var="start" value="${ loc }">
	                      						<c:param name="page" value="1"/>
	                      					</c:url>
	                      					<li class="page-item">
	                      						<a class="page-link" href="${ start }" aria-label="Previous">
	                      							<i class="fas fa-angle-double-left"></i> 
	                      						</a>
	                      					</li>
	                      					
<%-- 	                      					<c:url var="before" value="mList.me"> --%>
	                      					<c:url var="before" value="${ loc }">
	                      						<c:param name="page" value="${ pi.currentPage - 1 }"/>
	                      						<!-- 검색했을시 -->
	                      						<c:if test="${ searchCondition ne null }">  
													<c:param name="searchCondition" value="${ searchCondition }"/>
													<c:param name="searchValue" value="${ searchValue }"/>
												</c:if>
	                      					</c:url>
	                      					<li class="page-item">
	                      						<a class="page-link" href="${ before }" aria-label="Previous">
	                      							<i class="fas fa-angle-left"></i>  
	                      						</a>
	                      					</li>
	                      				</c:if>
	                      				
	                      				<!-- 숫자 -->
	                      				<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	                      					<c:if test="${ p eq pi.currentPage }">
	                      						<li class="page-item disabled"><a class="page-link">${ p }</a></li>
	                      					</c:if>
	                      					
	                      					<c:if test="${ p ne pi.currentPage }">
<%-- 	                      						<c:url var="pagination" value="mList.me"> --%>
	                      						<c:url var="pagination" value="${ loc }">
	                      							<c:param name="page" value="${ p }"/>
	                      							<!-- 검색했을시 -->
	                      							<c:if test="${ searchValue ne null }"> 
														<c:param name="searchCondition" value="${ searchCondition }" />
														<c:param name="searchValue" value="${ searchValue }" />
													</c:if>
	                      						</c:url>
	                      						<li class="page-item">
	                      							<a class="page-link" href="${ pagination }">${ p }</a>
	                      						</li>
	                      					</c:if>
	                      				</c:forEach>
	                      				<!-- 다음 -->
	                      				<c:if test="${ pi.currentPage >= pi.maxPage }">
	                      					<li class="page-item disabled">
	                      						<a class="page-link" aria-label="Next">
	                      							<i class="fas fa-angle-right"></i>
	                      						</a>
	                      					</li>
	                      					<li class="page-item disabled">
	                      						<a class="page-link" aria-label="Next">
	                      							<i class="fas fa-angle-double-right"></i>
	                      						</a>
	                      					</li>
	                      				</c:if>
	                      				
	                      				<!-- 다음 -->
	                      				<c:if test="${ pi.currentPage < pi.maxPage }">
<%-- 	                      					<c:url var="after" value="mList.me"> --%>
	                      					<c:url var="after" value="${ loc }">
	                      						<c:param name="page" value="${ pi.currentPage + 1 }"/>
	                      						<!-- 검색했을시 -->
	                      						<c:if test="${ searchValue ne null }"> 
													<c:param name="searchCondition" value="${ searchCondition }" />
													<c:param name="searchValue" value="${ searchValue }" />
												</c:if>
	                      					</c:url>
	                      					<li class="page-item">
	                      						<a class="page-link" href="${ after }" aria-label="Next">
	                      							<i class="fas fa-angle-right"></i>
	                      						</a>
	                      					</li>
<%-- 	                      					<c:url var="end" value="mList.me"> --%>
	                      					<c:url var="end" value="${ loc }">
	                      						<c:param name="page" value="${ pi.maxPage }"/>
	                      					</c:url>
	                      					<li class="page-item">
	                      						<a class="page-link" href="${ end }" aria-label="Next">
	                      							<i class="fas fa-angle-double-right"></i>
	                      						</a>
	                      					</li>
	                      				</c:if>
	                      			</ul>
	                      		</nav>
	                      	</div>
	                      </div>
	                    
                        <!-- 사원 등록 & 전체 삭제 버튼 -->
                        <div class="card-footer text-right">
						    <button class="btn btn-primary mr-1" type="button" onclick="location.href='enrollView.me'">사원 등록</button>
						    <button class="btn btn-danger" type="button" id="selectDelete">전체 삭제</button>
					    </div>
                      
                    </div>
                  </div>
                </div>
              </div>
            </div>
		</div>
		</section>
	</div>
				
	<c:import url="../common/footer.jsp" />
	
	<script>
	
	/*------------------------------ 체크박스 선택 ------------------------------*/
	
	// 전체 체크박스 선택&해제
	var all = document.getElementById("checkbox-all");
	var agree = document.getElementsByName("checkB");
	var memCount = ${ memCount }; // user의 수
	console.log(memCount);
	
	function selectAll() {
		if (all.checked) {
			for (var i = 0; i < agree.length; i++) {
				agree[i].checked = true;
			}
		} else {
			for (var i = 0; i < agree.length; i++) {
				agree[i].checked = false;
			}
		}
	}
	
	// 개별 체크박스 선택/해제시 전체 체크박스 선택/해제
	function selectOne() {
			var count = 0;
			
			for (var i = 0; i < agree.length; i++) {
				if (agree[i].checked) {
					count++;
				}
			}
			if (count != 10) { // 한 페이지에 있는 checkbox는 10개
				all.checked = false;
			} else {
				all.checked = true;
			}
		}
	
	/*------------------------------ 사원 목록 검색 ------------------------------*/
	function searchBoard(){
		var searchCondition = $("#searchCondition").val();
		var searchValue = $("#searchValue").val();
		
		location.href="searchMem.me?searchCondition="+searchCondition+"&searchValue="+searchValue;
	}
	
	/*--------------------- 상세 페이지로 이동 : 클릭할수 있도록 만들기 ---------------------*/
	$(function(){
		//table id = memberTable
		$('#memberTable tr.cls').mouseenter(function(){
			$(this).children().css({'color':'#6ED7F9', 'font-weight':'bold', 'cursor':'pointer'});
		}).mouseout(function(){
			$(this).children().css({'color':'#656D73', 'font-weight':'normal'});
		}).click(function(){
			var mNo = $(this).children().eq(2).text();
			location.href="mdetail.me?mNo=" + mNo + '&page=' + ${pi.currentPage}; 
		});
	});
	
	/*------------------------------ 개별 사원 삭제 ------------------------------*/
	// .btn-secondary : 개별 삭제버튼 & 단체 삭제버튼
	$('#oneDelete').click(function(){
		var mNo =  $(this).parent().parent().children().eq(2).text(); // 사번이 찍히는것 확인했음
		   
		console.log(mNo);
			
		var bool = confirm("정말 삭제하시겠습니까?");
		if(bool){
			// ajax
			$.ajax({
				url : 'mdelete.me',
				data : {mNo:mNo},
				success : function(data){
					console.log(data);
					location.reload();
				},
				error : function(data){
					console.log(data);
				}
			});
		} 
	});
	
	/*------------------------------ 선택 사원 전체 삭제 ------------------------------*/
	
	$('#selectDelete').click(function(){
		
// 		var valueArr = [];
		var values = '';
		var list = $("input[name='checkB']"); // checkbox에 value를 mNo로 넣어주기
		
		// checkB(개별 체크박스)가 선택되어 있을 시 배열에 값을 저장
		for(var i = 0; i < list.length; i++){
			if(list[i].checked){
// 				valueArr.push(list[i].value);
				// push : 배열의 마지막에 새로운 요소를 추가한 후, 변경된 배열의 길이를 반환
				values += list[i].value + " "
			}
		}
		
// 		if(valueArr.length == 0){
		if(values.length == 0){
			alert("선택된 사원이 없습니다.");
		} else {
			var bool = confirm("정말 삭제하시겠습니까?");
			if(bool){
				// ajax
				$.ajax({
					url : 'selectDelete.me',
// 					data : {'valueArr':valueArr},
					data : {'valueArr':values},
					type: 'post',
					success : function(data){
						console.log(data);
						location.reload();
					},
					error : function(data){
						console.log(data);
					}
				});
			} 
		}
	});
	
	/*------------------------------ 관리자 비밀번호 변경 페이지로 이동 ------------------------------*/
	$('#updatePwd').click(function(){
// 			var mNo =  $(this).parent().parent().children().eq(2).text(); // 사번이 찍히는것 확인했음
// 			console.log(mNo);
				
			$('#listForm').attr('action', 'adminPwdView.me');
			$('#listForm').submit();
	});
	
	</script>
	
</body>

</html>