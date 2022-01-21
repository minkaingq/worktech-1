<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <title>예약 자산 목록</title>

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
    </style>
</head>

<body>
    <c:import url="../common/headerAdmin.jsp" />
    <!-- Main Content -->
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>예약 관리</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item">예약 관리</div>
                    <div class="breadcrumb-item active">예약 자산 목록</div>
                </div>
            </div>

            <div class="section-body">
                <div class="row">
                    <div class="col-12 col-md-12 col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <c:url var="adRvProList" value="rvProductList.ad"/>
								<h4 style="font-size: 20px;" class="section-title" onclick="location.href='${ adRvProList }'">예약 자산 목록</h4>
	                    		
<!--                                 <h4 style="font-size: 20px;">예약 자산 목록</h4> -->
                            </div>
                            <div class="card-body">
                                <table class="table" id="tb">
                                    <thead>
                                        <tr>
                                            <th style="width: 100px; height: 45px;">번호</th>
                                            <th style="width: 150px;">카테고리</th>
                                            <th style="width: 300px;">자산명</th>
                                            <th style="width: 170px;">등록 날짜</th>
                                            <th style="width: 150px;">예약 가능 수량</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="r" items="${ list }">
	                                        <tr>
	                                            <td style="height: 45px;">${ r.pdNo }</td>
                                				<td>${ r.pdCategory }</td>
                                    			<td>${ r.pdName }</td>
                                    			<td>${ r.pdDate }</td>
                                    			<td>${ r.pdCount }</td>
                                    		</tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                                <button class="btn btn-primary push" onclick="location.href='addRvView.ad'">추가</button>
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
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ before }" aria-label="Previous">
	                                                        <i class="fas fa-angle-double-left"></i>
	                                                    </a>
	                                                </li>
	                                                
                                            		<c:url var="start" value="${ loc }">
														<c:param name="page" value="1"/>
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
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ after }" aria-label="Next">
	                                                        <i class="fas fa-angle-right"></i>
	                                                    </a>
	                                                </li>
													
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
				$(this).parent().css({'color':'#6ED7F9','background':'rgba(0, 0, 0, 0.04)', 'font-weight':'bold', 'cursor':'pointer'});
			}).mouseout(function() {
				$(this).parent().css({'color':'#656D73','background':'white', 'font-weight':'normal'});
			}).click(function() {
				var pdNo = $(this).parent().children().eq(0).text();
				location.href="rvpdetail.ad?pdNo=" + pdNo + '&page=' + ${pi.currentPage};
			});
		});
    	
    </script>

</body>

</html>