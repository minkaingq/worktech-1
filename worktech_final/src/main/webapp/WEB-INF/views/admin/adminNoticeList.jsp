<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <title>공지사항 게시판 목록</title>

    <style>
        
         h4.section-title {
			top: -13px;
			display: inline;
		}
	
		h4.section-title:hover{
			cursor: pointer;
			color: #67d4ef;
		}
		
        table {
            border-collapse: collapse;
            background: white;
        }

        table th {
            border-bottom: 1px solid #e3e3e3;
            text-align: center;
            font-size: 15px;
        }

        table td {
            border-bottom: 1px solid #e3e3e3;
            text-align: center;
            font-size: 15px;
        }

        .push {
            float: right;
        }

        .search {
            display: flex;
            justify-content: center;
        }

        .Searchbtn {
            margin-left: -70px;
            background-color: transparent !important;
            background-image: none !important;
            border-color: transparent;
            font-weight: bold;
            width: 80px;
        }

        .Searchbtn:hover {
            cursor: pointer;
        }

        .Searchbtn:active,
        .Searchbtn:focus {
            outline: none !important;
            box-shadow: none !important;
        }

        .paging-area {
            display: flex;
            justify-content: center;
        }
        
        select:focus {outline:none;}
        input:focus {outline:none;}
        
        .limit{
        	margin-bottom: 15px;
        	border-radius: 20em;
        }
        
        #searchValue{
        	padding-left: 5px;
        }
        
        
        /* 검색창 css 테스트중 */
/*         #searchCondition{ border-radius : 30px; }  */
        
        .searchOption{color : black; 
				  background : white;
/* 				  border : 1px solid skyblue; */
/*   				  border-radius: 4px; */
	}
	
 	#searchb{
/* 		height : 30px; */
 		vertical-align : middle;
 	} 
    </style>
</head>

<body>
	<c:if test="${ loginUser.mGrade eq 'USER' }">
		<c:import url="../common/headerUser.jsp" />
	</c:if>
	<c:if test="${ loginUser.mGrade eq 'ADMIN' }">
	    <c:import url="../common/headerAdmin.jsp" />
	</c:if>
    <!-- Main Content -->
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>공지사항 게시판</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item">게시판 관리</div>
                    <div class="breadcrumb-item">공지사항 게시판</div>
                </div>
            </div>

            <div class="section-body">
                <div class="row">
                    <div class="col-12 col-md-12 col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <c:url var="adNoList" value="noticeList.ad"/>
								<h4 style="font-size: 20px;" class="section-title" onclick="location.href='${ adNoList }'">공지사항 목록</h4>
                                
<!--                                 <h4 style="font-size: 20px;">공지사항 목록</h4> -->

                            </div>
                            <div class="card-body">
	                            <div class="limit">
	                            	게시글 수
		                            <select style="height: 30px; width: 80px; border: 1px solid #e3e3e3;" name="boardLimit" id="boardLimit" class="btn btn-se dropdown-toggle">
		                                <option value="10" <c:if test="${ boardLimit eq 10 }">selected</c:if>>10개</option>
		                                <option value="20" <c:if test="${ boardLimit eq 20 }">selected</c:if>>20개</option>
		                                <option value="50" <c:if test="${ boardLimit eq 50 }">selected</c:if>>50개</option>
		                            </select>
	                            </div>
                                <table class="table" id="tb">
                                    <thead>
                                        <tr>
                                            <th style="width: 150px; height: 45px;">글 번호</th>
                                            <th style="width: 450px;">글 제목</th>
                                            <th style="width: 110px;">작성자</th>
                                            <th style="width: 170px;">작성일</th>
                                            <th style="width: 100px;">조회수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="n" items="${ list }">
	                                        <tr>
	                                            <td style="height: 45px;">${ n.bNo }</td>
                                				<td>
	                                    			<c:if test="${ n.bCritical == 'NORMAL' }">
	                                    				${ n.bTitle }
	                                    			</c:if>	
	                                    			<c:if test="${ n.bCritical == 'IMPORTANT' }">
	                                    				<p style="color: red; font-weight: 900; display: inline">${ n.bTitle }</p>
	                                    			</c:if>	
                                    				<c:if test="${ !empty n.fileList.get(0).fName }">
                                    					&nbsp;<i class="fas fa-save"></i>
                                    				</c:if>	
                                    			</td>
                                    			<td>${ n.name }</td>
                                    			<td>${ n.bDate }</td>
                                    			<td>${ n.bCount }</td>
                                    		</tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${ loginUser.mGrade eq 'ADMIN' }">
                                	<button class="btn btn-primary push" onclick="location.href='ninsertView.ad';">글쓰기</button>
                                </c:if>
                                <br clear="all">
                                <div class="card-body paging-area">
                                    <div class="buttons">
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination">

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
                                            	<c:if test="${ pi.currentPage > 1 }">
                                            		<c:url var="before" value="${ loc }">
														<c:param name="page" value="${ pi.currentPage - 1 }"/>
														<c:param name="searchCondition" value="${ searchCondition }"/>
														<c:param name="searchValue" value="${ searchValue }"/>
														<c:param name="boardLimit" value="${ boardLimit }"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ before }" aria-label="Previous">
	                                                        <i class="fas fa-angle-double-left"></i>
	                                                    </a>
	                                                </li>
	                                                
                                            		<c:url var="start" value="${ loc }">
														<c:param name="page" value="1"/>
														<c:param name="searchCondition" value="${ searchCondition }"/>
														<c:param name="searchValue" value="${ searchValue }"/>
														<c:param name="boardLimit" value="${ boardLimit }"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ start }" aria-label="Previous">
	                                                        <i class="fas fa-angle-left"></i>
	                                                    </a>
	                                                </li>
	                                            </c:if>
	                                            
	                                            <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	                                            	<c:if test="${ p eq pi.currentPage }">
	                                            		<li class="page-item disabled"><a class="page-link">${ p }</a></li>
	                                            	</c:if>
	                                            
	                                            	<c:if test="${ p ne pi.currentPage }">
		                                            	<c:url var="pagination" value="${ loc }">
															<c:param name="page" value="${ p }"/>
															<c:param name="searchCondition" value="${ searchCondition }"/>
															<c:param name="searchValue" value="${ searchValue }"/>
															<c:param name="boardLimit" value="${ boardLimit }"/>
														</c:url>
	                                            		<li class="page-item">
	                                            			<a class="page-link" href="${ pagination }">${ p }</a>
	                                            		</li>
	                                            	</c:if>
	                                            </c:forEach>

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

												<c:if test="${ pi.currentPage < pi.maxPage }">
													<c:url var="after" value="${ loc }">
														<c:param name="page" value="${ pi.currentPage + 1 }"/>
														<c:param name="searchCondition" value="${ searchCondition }"/>
														<c:param name="searchValue" value="${ searchValue }"/>
														<c:param name="boardLimit" value="${ boardLimit }"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ after }" aria-label="Next">
	                                                        <i class="fas fa-angle-right"></i>
	                                                    </a>
	                                                </li>
													
													<c:url var="end" value="${ loc }">
														<c:param name="page" value="${ pi.maxPage }"/>
														<c:param name="searchCondition" value="${ searchCondition }"/>
														<c:param name="searchValue" value="${ searchValue }"/>
														<c:param name="boardLimit" value="${ boardLimit }"/>
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
                                <div class="search">
                                    <select style="height: 30px; width: 80px; border: 1px solid #e3e3e3;" id="searchCondition" name="searchCondition">
                                        <option>-------</option>
                                        <option value="title" <c:if test="${ searchCondition eq 'title' }">selected</c:if>>제목</option>
                                        <option value="content" <c:if test="${ searchCondition eq 'content' }">selected</c:if>>내용</option>
                                    </select>
                                    <input type="search" id="searchValue" style="height: 30px; width: 200px; border: 1px solid #e3e3e3;"
                                    	<c:if test="${ !empty searchValue }">value="${ searchValue }"</c:if>>
                                    <button class="Searchbtn" onclick="searchBoard();">검색</button>


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
    	// 게시글 목록 마우스오버 이벤트
	    $(function() {
			$('#tb tbody td').mouseenter(function() {
				$(this).parent().css({'color':'#6ED7F9', 'background':'rgba(0, 0, 0, 0.04)', 'font-weight':'bold', 'cursor':'pointer'});
			}).mouseout(function() {
				$(this).parent().css({'color':'#656D73','background':'white', 'font-weight':'normal'});
			}).click(function() {
				var bNo = $(this).parent().children().eq(0).text();
				var boardLimit = $('#boardLimit').val();
				
				var searchCondition = $("#searchCondition").val();
				var searchValue = $("#searchValue").val();
				
				if(searchValue != ''){
					location.href= "ndetail.ad?bNo=" + bNo + '&page=' + ${pi.currentPage} + '&boardLimit=' + boardLimit + "&searchCondition="+searchCondition+"&searchValue="+searchValue;
				} else {
					location.href= "ndetail.ad?bNo=" + bNo + '&page=' + ${pi.currentPage} + '&boardLimit=' + boardLimit;
				}
			});
		});
    	
    	// 게시글 검색
    	function searchBoard(){
			var searchCondition = $("#searchCondition").val();
			var searchValue = $("#searchValue").val();
			
			if(searchCondition ==  "-------"){
				alert("검색 카테고리를 선택하세요.");
				$("#searchValue").val('');
				$("#searchValue").focus();
			} else {
				location.href="searchNotice.ad?searchCondition="+searchCondition+"&searchValue="+searchValue;
			}
		}
    	
    	// boardLimit 변경
    	$(function() {
			$('#boardLimit').on('change', function() {
				var boardLimit = $(this).val();
				var searchCondition = $("#searchCondition").val();
				var searchValue = $("#searchValue").val();
				
				if(searchValue != ''){
					location.href="searchNotice.ad?searchCondition="+searchCondition+"&searchValue="+searchValue + "&boardLimit=" + boardLimit;
				} else {
					location.href='noticeList.ad?boardLimit=' + boardLimit;
				}
			});
		})
    </script>

</body>

</html>