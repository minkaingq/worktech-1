<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <title>익명 게시판 목록</title>

    <style>
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
        
        h4.section-title {
			top: -13px;
			display: inline;
		}
	
		h4.section-title:hover{
			cursor: pointer;
			color: #67d4ef;
		}
    </style>
</head>

<body>
    <c:import url="../common/headerUser.jsp" />
    <!-- Main Content -->
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>익명 게시판</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item">게시판</div>
                    <div class="breadcrumb-item">익명 게시판</div>
                </div>
            </div>

            <div class="section-body">
                <div class="row">
                    <div class="col-12 col-md-12 col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <c:url var="usAnBoList" value="anonyList.bo"/>
								<h4 style="font-size: 20px;" class="section-title" onclick="location.href='${ usAnBoList }'">익명 게시판</h4>
                                       
                                
<!--                                 <h4 style="font-size: 20px;">익명 게시판 목록</h4> -->
                            </div>
                            <div class="card-body">
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
                                    	<c:forEach var="b" items="${ list }">
	                                        <tr>
	                                            <td style="height: 45px;">${ b.bNo }</td>
                                    			<td>${ b.bTitle }
                                    				<c:if test="${ !empty n.fileList.get(0).fName }">
                                    					&nbsp;<i class="fas fa-save"></i>
                                    				</c:if>	
                                    			</td>
                                    			<td>익명</td>
                                    			<td>${ b.bDate }</td>
                                    			<td>${ b.bCount }</td>
                                    		</tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                                <button class="btn btn-primary push" onclick="location.href='ainsertView.bo';">글쓰기</button>
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
                                            		<c:url var="before" value="noticeList.ad">
														<c:param name="page" value="${ pi.currentPage - 1 }"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ before }" aria-label="Previous">
	                                                        <i class="fas fa-angle-double-left"></i>
	                                                    </a>
	                                                </li>
	                                                
                                            		<c:url var="start" value="noticeList.ad">
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
		                                            	<c:url var="pagination" value="noticeList.ad">
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
													<c:url var="after" value="noticeList.ad">
														<c:param name="page" value="${ pi.currentPage + 1 }"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ after }" aria-label="Next">
	                                                        <i class="fas fa-angle-right"></i>
	                                                    </a>
	                                                </li>
													
													<c:url var="end" value="noticeList.ad">
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
                                <div class="search">
                                	<c:url var="search" value="searchAnony.bo"/>
                                	<form action="${ search }">
	                                    <select name="searchCategory" style="height: 30px; width: 80px; border: 1px solid #e3e3e3;">
	                                        <option value="title">제목</option>
	                                        <option value="content">내용</option>
	                                    </select>
	                                    <input name="searchValue" type="text" style="height: 30px; width: 200px; border: 1px solid #e3e3e3;">
	                                    <button class="Searchbtn">검색</button>
                                	</form>
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
	    $(function() {
			$('#tb tbody td').mouseenter(function() {
				$(this).parent().css({'color':'#6ED7F9','background':'rgba(0, 0, 0, 0.04)', 'font-weight':'bold', 'cursor':'pointer'});
			}).mouseout(function() {
				$(this).parent().css({'color':'#656D73','background':'white', 'font-weight':'normal'});
			}).click(function() {
				var bNo = $(this).parent().children().eq(0).text();
				location.href="adetail.bo?bNo=" + bNo + '&page=' + ${pi.currentPage};
			});
		});
    </script>

</body>

</html>