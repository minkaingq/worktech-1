<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="resources/js/jquery-3.6.0.min.js"></script>
<script src="resources/ztree/js/jquery.ztree.core.js"></script>
<script src="resources/ztree/js/jquery.ztree.core.min.js"></script>
<script src="resources/ztree/js/jquery.ztree.excheck.js"></script>
<link rel="stylesheet" href="resources/ztree/css/zTreeStyle/zTreeStyle.css">
<meta charset="UTF-8">
<title>부서 구조</title>
<!-- General CSS Files -->
<link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">

<!-- Template CSS -->
<link rel="stylesheet" href="resources/dist/assets/css/style.css">
<link rel="stylesheet" href="resources/dist/assets/css/components.css">
<script type="text/javascript">
/*------------------------------ 부서 목록 : zTree ------------------------------*/
$(document).ready(function() {

	var zNodes = ${jsonArray};
// 	console.log(zNodes);
	var setting = {
			data: {
	            simpleData: {
	            	enable: true,
	                idKey: "id",
	                pIdKey: "pId",
	                rootPId: 0
	            }
	        },
	        view: {
	            dblClickExpend: true,
	            selectedMulti: true
	        },
	        callback : {
	 
	        }
	    };
	console.log($.fn.zTree);
	zTreeObj = $.fn.zTree.init($("#deptList"), setting, zNodes);
});
</script>

<style type="text/css">
	table {
	    border-collapse: collapse;
	    background: white;
	    width: 100%;
	}
	
	table th {
	    border-bottom: 1px solid #e3e3e3;
	    text-align: center;
	    font-size: 14px;
	    background: rgba(0, 0, 0, 0.1);
	    padding: 0 !important;
	    height: 40px !important;
	}
	
	table td {
	    border-bottom: 1px solid #e3e3e3;
	    text-align: center;
	    font-size: 13px;
	    padding: 0 !important;
	    height: 40px !important;
	}
	
	
	#deptMemberList {
		display: none;
	}
	
	.main-content {
		padding-top: 0;
	}
	
	.deptListDiv{
		border: 1px solid #a0e4f5;
		margin-bottom: 10px;
	}
	
	#groupDiv{
		display: none;
	}
	
	.deleteBtn{
		border: none;
	}
	
	.creatGroup {
		text-align: center;
		margin-bottom: 10px;
	}
	
	#hiddenInput {
		display: none;
	}
	
	.addDiv {
		text-align: right;
		margin-right: 10px;
	}
	
	.goList {
		float: right;
	}
</style>

</head>
<body>
	<div class="main-content">
		<section class="section">
			<div class="section-body">
				<h2 class="section-title">부서 구조
				</h2>
			</div>
		</section>
		<div class="deptListDiv">
			<ul id="deptList" class="ztree"></ul>
		</div>
	</div>

</body>
</html>