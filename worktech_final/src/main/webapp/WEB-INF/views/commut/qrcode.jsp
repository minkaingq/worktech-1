<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QRcode</title>
<style>
	.wrapper {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  min-height: 300px;
	  background: #eee;
	}
	
	.content {
	  padding: 3rem;
	  border-radius: 1rem;
	}
</style>
</head>
<body>
<div class="wrapper">
	<div class="content">
		<img src="resources/qrcode/${ QRCode.file_name }">
	</div>
</div>
</body>
</html>