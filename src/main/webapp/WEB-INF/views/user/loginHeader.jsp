<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<jsp:include page="/WEB-INF/css/headerCSS.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script><!-- jquery CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"><!-- bootstrapCSS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
var socket; // 전역변수 설정
var displayedNotifications = new Set(); // 표시된 알림을 추적하는 집합

$(document).ready(function() {
    Notification.requestPermission().then(function(permission) {  // 알림 허용
        if (permission === 'granted') {
            console.log('알림 권한이 허용되었습니다.');
        } else {
            console.log('알림 권한 설정에 실패했습니다.');
        }
    });
    
    connectWebSocket(); // 페이지가 로드 시 웹소켓 연결
    
    function connectWebSocket() {
        var sessionId = localStorage.getItem('sessionId'); // 세션 ID 로드
		console.log("세션아이디"+sessionId);
        if (sessionId) {
            socket = new SockJS("<c:url value='/echo-ws'/>?sessionId=" + sessionId);
        } else {
            socket = new SockJS("<c:url value='/echo-ws'/>");
        }
        socket.onerror = function(e) {
            console.log("웹소켓 핸들러 못들어옴 : "+e);
        };
        socket.onmessage = function(event) {
            try {
                var data = JSON.parse(event.data);

                if (data.type === 'notification') {
                    showNotification(data);
                } else if (data.type === 'unreadMessageCount') {
                    updateUnreadMessageCount(data.count);
                } else {
                    console.error('예기치 않은 데이터 형식:', data);
                }
            } catch (error) {
                console.error('JSON 파싱 실패 :', event.data);
            }
        };
    }
});

function showNotification(data) {
    if (Notification.permission === 'granted') {
        var fromUserId = data.fromUserId; // sendId
        var notificationMessage = data.content; // Content

        var displayedNotifications = JSON.parse(localStorage.getItem('displayedNotifications')) || [];

        if (!displayedNotifications.includes(notificationMessage)) {
            var notification = new Notification(fromUserId, {
                body: notificationMessage
            });

            notification.onclick = function(event) {
                event.preventDefault();
                location.href = "${pageContext.request.contextPath}/message/dm";
            };

            setTimeout(notification.close.bind(notification), 3000);
            displayedNotifications.push(notificationMessage);

            localStorage.setItem('displayedNotifications', JSON.stringify(displayedNotifications));
        } else {
            console.log('이미 표시된 알림 : ', notificationMessage);
        }
    } else {
        console.log('알림 권한이 없습니다.');
    }
}

function updateUnreadMessageCount(count) {
    console.log('안 읽은 메시지 개수:'+ count);
    var countSpan = document.getElementById('unreadMessageCount');
    countSpan.textContent = count > 0 ? count : '';
}

</script>
</head>
<body>
	<c:if test="${not empty alertMsg}">
		<script>
			alert("${alertMsg}");
		</script>
		<c:remove var="alertMsg"/>
	</c:if>	
	<header>
        <div class="sidebar">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/resources/Remergelogo.png" alt="Remerge logo">
            </div>
            <nav class="menu">
                <ul>
                    <li><div class="menu-item" id="home"><img src="${pageContext.request.contextPath}/resources/home.png">홈</div></li>
                    <li><div class="menu-item" id="search" onclick="searchDisplay();"><img src="${pageContext.request.contextPath}/resources/search.png">검색</div></li>
                    <li><div class="menu-item" id="explore"><img src="${pageContext.request.contextPath}/resources/explore.png">탐색</div></li>
                    <li><div class="menu-item" id="messages"><img src="${pageContext.request.contextPath}/resources/messages.png"><a href="/reMerge/message/dm">메시지</a></div></li>
                    <li><div class="menu-item" id="notifications"><img src="${pageContext.request.contextPath}/resources/notifications.png">알림
                     <span id="unreadMessageCount" class="badge bg-danger"></span>
                    </div></li>
                    <li><div class="menu-item" id="create"><img src="${pageContext.request.contextPath}/resources/create.png">만들기</div></li>
                    <li><div class="menu-item" id="store"><img src="${pageContext.request.contextPath}/resources/store.png">스토어</div></li>
                    <li><div class="menu-item" id="profile"><a href="myPage.us?userId=${loginUser.userId}"><img src="${pageContext.request.contextPath}/resources/unknown.jpg">프로필</a></div></li>
                    <li><div class="menu-item" id="calendarIcon"><a href="calendar.sc"><img src="${pageContext.request.contextPath}/resources/calendaricon.png">캘린더</a></div></li>
                    <li><div class="menu-item" id="festivalIcon"><a href="festival.fs"><img src="${pageContext.request.contextPath}/resources/festivalIcon.png">축제</a></div></li>
                </ul>
            </nav>
        </div>
        <div class="searchBox">
        	<div class="searchBoxTitle">검색</div>
        	<button class="btn btn-danger" onclick="closeSearch();">X</button>
	       	<div id="searchfollow" class="searchfollow"><!-- 검색 인풋 영역 -->
	       		<input type="text" id="searchUser" oninput="search();"><!-- oninput == 입력값이 변할때마다 -->
	       	</div>
	       	<div id="searchUserResult" class="searchUserResult"></div><!-- 검색 결과 -->
	       	
        </div>
    </header>
    <script>
    	function searchDisplay(){//검색 버튼 클릭시 검색 창 영역 보여주기
    		$('.searchBox').toggleClass('active');
    		selectSearchHistory();//검색 버튼 클릭시 검색 기록 함수 실행
    	}
    	
    	function closeSearch(){//검색창 활성화시 x버튼 클릭하면 검색창 닫기
    		$('.searchBox').removeClass('active');
    	}
    
    	function search(){//검색창에 하나의 단어 입력시마다 db에 저장된 아이디값에 포함된 단어의 아이디 조회해서 보여주기
    		var searchStr = $('#searchUser').val();
    			
    		if(searchStr==""){//검색어가 없다면
    			$('#searchUserResult').html("");//검색어 지웠을때 처리
    			selectSearchHistory();//검색어 지웠을때도 검색 기록 조회 함수 실행
    		}else{
	    		if(searchStr.includes('#')){//태그 검색 
	    			//console.log('태그시도');//작동하는지 확인
	    			$.ajax({
	    				url:"searchTag.fe",
	    				type:"get",
	    				data:{
	    					tagContent:searchStr
	    				},
	    				success:function(data){
	    					console.log(data);
	    					var html = "<ul>";
	    					if(!data||data.length===0){
	    						html+="<li>조회된 태그가 없습니다.</li>";
	    					}else{
								for(var i=0;i<data.length;i++){
									html+="<li onclick='selectTag("+JSON.stringify(data[i])+");'>#"+data[i].tagContent+"</li>";
								}    						
	    					}
	    					$('#searchUserResult').html(html);
	    				},
	    				error:function(){
	    					
	    				}
	    			});
	    		}
	    	
	    		$.ajax({//사용자 검색
	    			url:"searchUser.us",
	    			type:"get",
	    			data:{
	    				searchStr:searchStr
	    			},
	    			success:function(data){
	    				//console.log(data)// 데이터 확인
	    				var html = "";
	    				if(!data||data.length===0){
							html ="조회된 데이터가 없습니다.";    					
	    				}
	    				html += "<ul>";
	    				for(var i=0;i<data.length;i++){
	    					html+="<li class='searchResult' onclick='profileUser("+JSON.stringify(data[i])+");'>";//해당하는 div 클릭시 data를 매개변수로 보내 클릭시 아이디값 알수 있게 하기
	    					if(data[i].profileChangeName==null){
		    					html+="<span class='profileImage'><img src='resources/unknown.jpg'></span>";
		    				}else{
		    					html+="<span class='profileImage'><img src='"+data[i].profileChangeName+"'></span>";
		    				}
		    				html+="<p>";
		    				html+="<strong class='userId'>"+data[i].userId+"</strong>";
		    				if(data[i].userMemo==null){
		    					html+="<span class='memo'></span>";
		    				}else{
			    				html+="<span class='memo'>"+data[i].userMemo+"</span>";
		    				}
		    				html+="</p>";
		    				html+="</li>";
	    				}
	    				html+="</ul>"	
		    			$('#searchUserResult').html(html);
	    			},
	    			error:function(){
						console.log("통신 실패");    				
	    			}
	    		});
    		}
    	}
    	
    	function profileUser(data){//검색결과에서 해당하는 사용자 클릭시 프로필로 이동하는 함수
    		//console.log(data.userId);
    		var searchUser=data.userId;
    		$.ajax({
    			url:"insertSearchHistory.us",
    			type:"post",
    			data:{
    				fromUser:"${loginUser.userId}",
    				searchUser:data.userId
    			},
    			success:function(data){
    				//console.log(data);
    				location.href="/reMerge/myPage.us?userId="+searchUser;
    			},
    			error:function(){
    				console.log("통신 실패");
    			}
    		});
    	}  
    	
    	$('#home').click(function(){
    		location.href="/reMerge/feed.fe";
    	});
    
    	function selectTag(data){
    		//console.log(data.tagContent);
    		location.href="/reMerge/selectTag.fe?tagContent="+data.tagContent
    	}
    	
    	function selectSearchHistory(){//검색 기록 조회
    		$.ajax({
				url:"selectSearchHistory.us",
				type:"post",
				data:{
					userId:"${loginUser.userId}"
				},
				success:function(data){
					//console.log(data);
					var html = "<strong>최근 검색 기록</strong><hr>";
					
    				if(!data||data.length===0){
						html ="검색 기록이 없습니다.";    					
    				}
    				html += "<ul>";
    				for(var i=0;i<data.length;i++){
    					html+="<li class='searchResult' onclick='profileUser("+JSON.stringify(data[i])+");'>";//해당하는 div 클릭시 data를 매개변수로 보내 클릭시 아이디값 알수 있게 하기
    					if(data[i].profileChangeName==null){
	    					html+="<span class='profileImage'><img src='resources/unknown.jpg'></span>";
	    				}else{
	    					html+="<span class='profileImage'><img src='"+data[i].profileChangeName+"'></span>";
	    				}
	    				html+="<p>";
	    				html+="<strong class='userId'>"+data[i].userId+"</strong>";
	    				if(data[i].userMemo==null){
	    					html+="<span class='memo'></span>";
	    				}else{
		    				html+="<span class='memo'>"+data[i].userMemo+"</span>";
	    				}
	    				html+="</p>";
	    				html+="<button onclick='deleteSearchHistory(event,"+JSON.stringify(data[i])+");'>x</button>";
	    				html+="</li>";
    				}
    				html+="</ul>"	
	    			$('#searchUserResult').html(html);
				},
				error:function(){
					console.log("통신 실패");
				}
			});
    	}
    	
    	function deleteSearchHistory(e,data){//검색 기록 삭제
    		e.preventDefault();
    		e.stopPropagation(); // 부모 li 요소의 클릭 이벤트가 발생하지 않도록 방지(해당 유저 마이페이지 이동 막기)
    		$.ajax({
    			url:"deleteSearchHistory.us",
    			type:"post",
    			data:{
    				fromUser:"${loginUser.userId}",
    				searchUser:data.userId
    			},
    			success:function(data){
    				console.log(data);
    				$(e.target).closest('li').hide();//x 버튼 눌렸을때 해당 기록 지워주기(부모 li요소 숨기기)
    			},
    			error:function(){
    				console.log("통신 실패");
    			}
    		});
    	}
    	
    </script>
     <h2>${loginUser.userId}</h2>
	<a href="logout.us">로그아웃</a>
</body>
</html>