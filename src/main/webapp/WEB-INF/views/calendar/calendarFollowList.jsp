<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로우 정보</title>
<jsp:include page="/WEB-INF/css/followListCSS.jsp"/>
</head>
<body>
	<%@include file = "../user/loginHeader.jsp" %>
	<div class="outer">
		<div class="followListTitle"><h1>팔로우 목록</h1></div>
		<div class="followListContent">
			<div class="searchTap">
				<label for="searchFollower">검색</label>
				<input type="text" id="searchFollower" oninput="searchFollow();">
			</div>
			<form action="shareCalendar.sc" method="post">
				<div class="FollowResult">
					<ul id="searchFollowResult"></ul>
				</div>
				<ul id="followList"></ul>
				<div id="loading" style="display: none; text-align: center;">Loading...</div>
				<div>
					<button type="submit">공유 캘린더 보기</button>
				</div>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function() {
		    var currentPage = 1;
		    var isLoading = false;
		    $("#searchFollowResult").hide();
		    
		    // 초기 로드
		    loadFollowList(currentPage);
			
		    $(window).scroll(function() {
		        // 문서 전체 높이 - 윈도우 높이 <= 현재 스크롤 위치 
		        if ($(window).scrollTop() + $(window).height() >= $(document).height() - 1000) {
		            if (!isLoading) {
		                isLoading = true;
		                loadFollowList(++currentPage);
		            }
		        }
		    });
		    //무한스크롤 ajax 실행 함수
		    function loadFollowList(page) {
		        $('#loading').show();
				
		        $.ajax({
		            url: "selectFollowList.sc",
		            type: "post",
		            data: {
		                userId: "${loginUser.userId}",
		                currentPage: page
		            },
		            success: function(data) {
		                var followList = data.followList;
		                var fpi = data.fpi; //followList PageInfo
		                var str = "";
		                for (var i = 0; i < followList.length; i++) {
		                    str += "<li class='followUser'>";
		                    if (followList[i].profileChangeName == null) {
		                        str += "<span class='profileImage'><img src='resources/unknown.jpg'></span>";
		                    } else {
		                        str += "<span class='profileImage'><img src='" + followList[i].profileChangeName + "'></span>";
		                    }
		                    str += "<p>";
		                    str += "<strong class='userId'>" + followList[i].userId + "</strong>";
		                    str += "<span class='memo'>" + followList[i].userMemo + "</span>";
		                    str += "</p>";
		                    str += "<input type='checkbox' value='" + followList[i].userId + "' name='chooseFollow' onclick='duplCheck(this);'>";
		                    str += "</li>";
		                }
		                $("#followList").append(str);
		                $('#loading').hide();
		                isLoading = false;

		                if (page >= fpi.maxPage) {
		                    $(window).off("scroll");
		                }
		            },
		            error: function() {
		                console.log("통신 실패");
		                isLoading = false;
		                $('#loading').hide();
		            }
		        });
		    }
		    
		    //5개 이상 선택 막기 
		   	$("#followList").on("click","input[type='checkbox']",function(){
		   		var count = $("input[type='checkbox']:checked").length;
		   		//console.log(count);
		   		if(count>5){
		   			alert("5개 이하만 선택 가능합니다.");
		   			$(this).prop("checked", false); // 마지막으로 클릭한 체크박스를 해제
		   		}
		   	});
		});
		
	    // 검색 함수 정의
        function searchFollow() {
            var searchFollower = $("#searchFollower").val();
            if(searchFollower == ""){
            	$("#searchFollowResult").hide();
            	$("#searchFollowResult").html("");//검색어 지운다면 비워두기 
	            /* console.log(searchFollower);  */
            }else{
            	 $("#searchFollowResult").show();
	            $.ajax({
	                url: "searchFollower.sc",
	                data: {
	                    fromUser: "${loginUser.userId}",
	                    toUser: searchFollower
	                },
	                success: function(data) {
	                   // console.log(data);
	                   var searchResult = "";
	                   for (var i = 0; i < data.length; i++) {
	                	   searchResult += "<li class='followUser'>";
		                    if (data[i].profileChangeName == null) {
		                    	searchResult += "<span class='profileImage'><img src='resources/unknown.jpg'></span>";
		                    } else {
		                    	searchResult += "<span class='profileImage'><img src='" + data[i].profileChangeName + "'></span>";
		                    }
		                    searchResult += "<p>";
		                    searchResult += "<strong class='userId'>" + data[i].userId + "</strong>";
		                    searchResult += "<span class='memo'>" + data[i].userMemo + "</span>";
		                    searchResult += "</p>";
		                    searchResult += "<input type='checkbox' value='" + data[i].userId + "' name='chooseFollow' onclick='duplCheck(this);'>";
		                    searchResult += "</li>";
		                }
		                $("#searchFollowResult").html(searchResult);
	                   
	                   
	                },
	                error: function() {
	                    console.log("통신실패");
	                }
	            }); 
            }
        }
	    
	    function duplCheck(checkbox){
	    	  // 이름이 "check"인 모든 체크박스를 가져옴
            var checks = $('input[name="chooseFollow"]');
			//console.log(checks);
			
            // 체크된 체크박스의 값을 가져옴
            var value = checkbox.value;
            var isChecked = checkbox.checked;
            //console.log('반복문 밖에서 찍기 '+value);
           
            for (var i = 0; i < checks.length; i++) {
                // 현재 체크박스와 같은 값을 가진 체크박스들의 체크 상태를 동기화
                if (checks[i].value === value) {
                	//console.log(value);
                    checks[i].checked = isChecked;
                }
            }
	    	
	    }
	    
	</script>
</body>
</html>