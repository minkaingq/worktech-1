<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>일반 게시판 상세</title>

    <!-- CSS Libraries -->
    <link rel="stylesheet" href="resources/dist/assets/modules/summernote/summernote-bs4.css">
    <link rel="stylesheet" href="resources/dist/assets/modules/codemirror/lib/codemirror.css">
    <link rel="stylesheet" href="resources/dist/assets/modules/codemirror/theme/duotone-dark.css">
    <link rel="stylesheet" href="resources/dist/assets/modules/jquery-selectric/selectric.css">

    <style>
        .inputData {
            border: 1px #dff5fa solid;
            padding: 10px;
            border-radius: 5px;
            text-align: left;
            height: 500px;
        }
        
        .inputFile {
            padding: 10px;
            border-radius: 5px;
            text-align: left;
        }

        .half-col {
            display: inline-block;
            width: 49%;
        }

        .left-item {
            margin-right: 19px;
        }

        :disabled,
        input[type="text"]:disabled,
        input[type="date"]:disabled,
        input[type="number"]:disabled {
            background: white;
        }
        
        .formStyle{
        	display: inline-block;
        	margin-right: 10px;
        	margin-left: 5px;
        }

        #replyBox{
        	resize: none;
        }
        
        #rTable{
        	width: 100%;
        	border-collapse: collapse;
        }
        
        #rTable td{
        	padding: 12px;
        	border-top: 1px solid #dff5fa;
        	border-bottom: 1px solid #dff5fa;
        }
        
        i[name='rDeleteBtn']:hover{
        	cursor: pointer;
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
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item active">
                    </div>
                    <div class="breadcrumb-item">화상회의 게시판</div>
                </div>
            </div>

            <div class="section-body">
                <h2 class="section-title">화상회의 게시판</h2>
                <div class="row">
                    <div class="col-12 col-md-12 col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <label>글 제목</label>
                                    <input type="text" class="form-control" id="bTitle" disabled value=" ${ b.bTitle }">
                                </div>
                                <div class="form-group half-col left-item">
                                    <label>작성자</label>
                                    <input type="text" class="form-control" disabled value="${ b.name }">
                                </div>
                                <div class="form-group half-col">
                                    <label>작성일</label>
                                    <input type="date" class="form-control" disabled value="${ b.bDate }">
                                </div>
                                <div class="form-group">
                                    <label>내용</label>
                                     <textarea class="form-control" >${ b.bContent }</textarea>
                                </div>
                            </div>
                            <div class="card-footer text-right">
                            	<form action="zoomDelete.bo" method="post" class="formStyle">
										<input type="hidden" name="bNo" value="${ b.bNo }">
	                                	<button class="btn btn-danger" type="submit" onclick="return zoomDelete();">삭제하기</button>
	                               </form>
								
                                <button class="btn btn-secondary" type="button" onclick="location.href='javascript:history.back();'">목록으로</button>
                            </div>
                            <div class="card-footer form-group">
                            	<label id="rCount"></label>
                           		<table id="rTable" width="100%"></table>
                           		<br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </section>
    </div>

     
    <c:import url="../common/footer.jsp" />
    <script src="resources/dist/assets/modules/summernote/summernote-bs4.js"></script>
    <script src="resources/dist/assets/modules/codemirror/lib/codemirror.js"></script>
    <script src="resources/dist/assets/modules/codemirror/mode/javascript/javascript.js"></script>
    <script src="resources/dist/assets/modules/jquery-selectric/jquery.selectric.min.js"></script>

	<script>
		// 게시글 삭제 확인
		function zoomDelete() {
			var result = confirm('정말로 삭제하시겠습니까?');
			
			if(result<0){
				return false;
			}
			
		}
	</script>
</body>
</html>