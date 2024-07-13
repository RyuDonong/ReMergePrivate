<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>로그인 화면</title>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- Popper.js -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Bootstrap JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Alertify.js CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css">

<!-- Alertify.js JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
<!-- google 리캡쳐 API -->
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<body>
	<br>
	<br>
	



	<table align="center">
		<tr>
			<td><img src="resources/Remergelogo.png"></td>
		</tr>
	</table>
	<h2 align="center">로그인</h2>
	
	 <form action="login.us" method="post" id="auto_form">
		<div align="center">
			<input type="text" id="userId" name="userId" placeholder="아이디"><br><br>
			<input type="password" id="userPwd" name="userPwd" placeholder="비밀번호"><br><br>
			<div style="display:none" id="recaptcha-area" class="g-recaptcha"
			data-callback="recaptchaCallback"
			 data-sitekey="6LcfpgEqAAAAAER00cficVYpBUjK-P75pBJt3D56"></div><br><br>
			<button type="submit" id="loginBtn1" onclick="loginBtn1();"  name="loginBtn1">로그인</button>
		<br> <br>
		</div>
	</form>
	
			<br> <br>


			<h2 align="center">다른 계정으로 로그인!!!!!!!</h2>
			<br>

			<div class="social-login-buttons" align="center">
				<img class="naver-login-img" alt="네이버로그인"	style="width: 80px; height: 80px;"	
				src="<c:url value="resources/btnG_naver.png"/>"	onclick="location.href='<c:url value="/naver/login"/>';" role="button">
				 &nbsp;&nbsp; &nbsp;&nbsp; 
				<img class="google-login-img" alt="구글로그인"	style="width: 80px; height: 80px;"
				src="<c:url value="resources/btnG_google.png"/>" onclick="location.href='<c:url value="/google/login"/>';"  role="button">
			</div>
			<br>

	<br>
	<br>
	<br>
	<div class="find-area" align="center">
		<a href="forFindUser.us">아이디 및 비밀 번호 찾기</a>  &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; | &nbsp;&nbsp; &nbsp;&nbsp;
		<a href="insertEnrollForm.us">회원 가입!</a>
		<br><br><br><br><br><br>
	</div>

	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}" );
		</script>
		<c:remove var="alertMsg" />
	</c:if>



	<!-- 구글 리캡쳐 API 호출구문 -->
	
	<script>
	var loginCount = Number("${loginCount}");
	console.log(loginCount);
	if (loginCount >= 3) {
		$("#recaptcha-area").show();
	}

	$("#auto_form").submit(function(event) {
		if (loginCount >= 3) {
			event.preventDefault();  
			// 폼 제출 막기
			var recaptchaResponse = $(".g-recaptcha-response").val();
			if (!recaptchaResponse) {
				alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
				return;
			}
            	console.log(recaptchaResponse);
    			$.ajax({
    				url : "VerifyRecaptcha.us",
    				type : "post",
    				data : {
    					recaptcha : recaptchaResponse
    				},
    				success : function(res) {
    					console.log(res);
    						switch (res) {
    						case 0:
    							alert("자동 가입 및 매크로 방지 봇 통과");
    							$("#auto_form").off("submit").submit();  
    							// 폼 제출 재개
    							break;
    						case 1:
    							alert("자동 가입 및 매크로 방지 봇을 확인 한뒤 진행 해 주세요.");
    							break;
    						default:
    							alert("자동 가입 및 매크로 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : "+Number(data)+"]");
    							break;
    						}
    				},
    				error: function () {
    					console.log("에러 발생")	
    				}
    			});
            
		}
		});
   
   	function recaptchaCallback(response) {
       if (response.length !== 0) {
       	// 사용자가 체크박스를 체크했을 때
           $("#loginBtn1").show();
           alert("reCAPTCHA checked.");
    	}
	};
		
	</script>
	
	
	
	
<body>



</body>
</html>