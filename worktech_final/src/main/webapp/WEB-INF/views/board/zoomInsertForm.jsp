<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>화상게시판 작성</title>
<!-- CSS Libraries -->
	<link rel="stylesheet" href="../../resources/dist/assets/modules/summernote/summernote-bs4.css">
	<link rel="stylesheet" href="../../../resources/dist/assets/modules/codemirror/lib/codemirror.css">
	<link rel="stylesheet" href="../../../resources/dist/assets/modules/codemirror/theme/duotone-dark.css">
	<link rel="stylesheet" href="../../../resources/dist/assets/modules/jquery-selectric/selectric.css">
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
        
        .select {
        	border: 1px solid white;
        }
        
        .select:focus{
        	border: 1px solid black;
        }
    </style>
    
</head>
<body>
	<c:if test="${ loginUser.mGrade eq 'USER' }">
		<c:import url="../common/headerUser.jsp" />
	</c:if>
 <!--**********************************
            Content body start
        ***********************************-->
        <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>화상회의</h1>
          </div>
		<form action="zinsert.bo" method="post">
          <div class="section-body">
         <div class="section-body">
        <div class="row">
        <div class="col-12 col-md-12 col-lg-12">
               <div class="card" >
                  <div class="card-header">
                    <h4>ZOOM 알림 게시판</h4>
                  </div>
                  <div class="card-body">
                  <div class="form-group">
	               <label>글 제목</label>
	                <input type="text" class="form-control" name="bTitle" value="">
	              </div>
	              <div class="form-group half-col left-item">
	              <label>작성자</label>
	              <input type="text" class="form-control"  value="${ loginUser.name }">
	              <input type="hidden"  name="bWriter" value="${ loginUser.mNo }">
	              </div>
	               <div class="form-group half-col">
	                  <label>작성일</label>
	                <input type="date" class="form-control" name="bDate">
	               </div>
	             <div class="form-group">
                      <label>내용</label>
                      <textarea class="form-control" name="bContent">
                      Zoom 회의 참가
						https://zoom.us/j/97612342222?pwd=NUFDVFVKRWN1eW41OU5wN1E2bURrZz09
						
						회의 ID: 976 1234 2222
						암호: worktech
                      </textarea>
                    </div>
                    <div class="card-footer text-right">
                    <button class="btn btn-primary mr-1" type="submit">등록</button>
                    <button class="btn btn-secondary" type="reset">취소</button>
                  </div>
                  </div>
				</div>
				</div>
				</div>
				</div>
				</div>
			</form>
				</section>
				</div>
        
        
        <!-- JS Libraies -->
	<script src="./../../resources/dist/assets/modules/summernote/summernote-bs4.js"></script>
	<script src="../../../resources/dist/assets/modules/codemirror/lib/codemirror.js"></script>
	<script src="../../../resources/dist/assets/modules/codemirror/mode/javascript/javascript.js"></script>
	<script src="../../../resources/dist/assets/modules/jquery-selectric/jquery.selectric.min.js"></script>
</body>
</html>