<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userEnrollForm</title>
</head>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>





</head>
<body>


	<div class="center">
		<h2 align="center" style="color: black;">회원가입</h2>
		<br>
		<br>
		<form action="insert.us" method="post">
			<label for="userId">* 아이디</label><br>
			<input type="text" name="userId" id="userId" required placeholder="아이디를 입력해주세요.">
			<div id="idResult" style='font-size: 0.8em;'>*한글없이 특,영문으로만 2글자부터 10자 까지 작성해주세요</div>
			<div id="idResult" style='font-size: 0.8em; display=none'></div>
			<br>
			<hr>
			<br> 
			<label for="userPwd">* 비밀번호</label> <br>
			<input type="password" name="userPwd" id="userPwd" required><br> 
			<div id="idResult" style='font-size: 0.8em;'>*대,소문자 구분하여 2글자이상(특문포함) 2글자부터 16자 까지 작성해주세요</div>
			<label for="userpwChk">* 비밀번호 확인</label><br> 
			<input type="password" name="userpwChk" id="userpwChk" required><br>
			<div id="pwResult" style='font-size: 0.8em; display=none'></div>
			<hr>
			<br> 
			<label for="email">* 이메일</label><br>
			<input type="email" name="email" id="email"><br>
			<div id="idResult" style='font-size: 0.8em;'>*아이디 및 비밀번호 찾기에 사용되니 유의하여 작성해주세요!!</div>
			<div id="emailResult" style='font-size: 0.8em; display=none'></div>
			<hr>
			<br>
			<p>상표등록 확인</p><br>
			<input type="text" id="brandCheck" name="brandCheck">
			<button type="button" onclick="brandCheck();">확 인</button>
			<br> <br> <br>
			<div align="center">
				<button id="sign" type="submit"  disabled>회원가입</button>
				<button type="reset" >초기화</button>
			</div>
			 </form>
			<br> <br> <br>
			<br>

	</div>
	



	<script>
		$(function() {
			var inputId = $("#userId");
			inputId.keyup(function() {
				/* console.log(inputId.val()) */
				$.ajax({
					url : "checkId.us",
					data : {
						checkId : inputId.val()
					},
					success : function(result) {
						/* console.log(result) */
						if (result == 'NNNNN') {
							$("#idResult").show();
							$("#idResult").css("color", "red").text("중복 아이디입니다.");

						} else {
							$("#idResult").show();
							$("#idResult").css("color", "green").text(
									"사용가능한 아이디입니다.");
						}

					},
					error : function() {
						console.log("통신 오류");
					}
				});

			});

		});
		
		$(function() {
			var inputPw = $("#userPwd");
			var inputUserpwChk = $("#userpwChk");
			inputUserpwChk.keyup(function() {
				/* console.log(inputPw.val())
				console.log(inputUserpwChk.val()) */
				$.ajax({
					url : "checkPw.us",
					data : {
						checkPw : inputPw.val(),
						checkpwChk : inputUserpwChk.val()
					},
					success : function(result) {
						if (result == 'NNNNN') {
							$("#pwResult").show();
							$("#pwResult").css("color", "red").text("비밀번호가 일치하지않습니다!");
						} else {
							$("#pwResult").show();
							$("#pwResult").css("color", "green").text("비밀번호가 일치합니다!");
						}

					},
					error : function() {
						console.log("통신 오류");
					}
				});

			});

		});
		
		$(function () {
			var inputemail = $("#email")
			inputemail.keyup(function () {
				console.log(inputemail);
				$.ajax({
					url : "emailCheck.us",
					data : {
						email : inputemail.val()
					},
					success : function (result) {
						console.log(result);
						if(result=="NNNNN"){
							$("#emailResult").show();
							$("#emailResult").css("color", "red").text("*중복된 이메일입니다.");
							$("button[type=submit]").attr("disabled", true);
						}else{
							$("#emailResult").show();
							$("#emailResult").css("color", "green").text("이메일 형식 일치!");
							$("button[type=submit]").attr("disabled", false);
						}
					},
					error: function () {
						console.log("통신 오류");
					}
				});
				
			});
		});
	</script>


</body>
</html>