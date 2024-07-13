<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공유 캘린더</title>
	 <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8bbc3ea0a937b0baf9ab04c7ad6b1970&libraries=services,clusterer"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
	<style type="text/css">
	 .fc .fc-daygrid-day-number,
    .fc .fc-col-header-cell-cushion{
    	color : black;
    	text-decoration : none;
    }
    .mb-3 textarea{
    	width:300px;
    	height:40px;
    }
	</style>
	
</head>
<body>
	<jsp:include page="../user/loginHeader.jsp"/>
	
	 <div class="outer">
        <div id="calendar"></div>
    </div>
    
    <!-- datail modal -->
     <div class="modal fade" id="shareDetailModal" tabindex="-1" aria-labelledby="shareDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="shareDetailModalLabel">일정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                        <div class="mb-3">
                            <label for="shareDetailTitle" class="form-label">일정 제목</label>
                            <input type="text" class="form-control" id="shareDetailTitle" name="title" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="shareDetailStart" class="form-label">일정 시작일</label>
                            <input type="datetime-local" class="form-control" id="shareDetailStart" name="startDate" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="shareDetailEnd" class="form-label">일정 종료일</label>
                            <input type="datetime-local" class="form-control" id="shareDetailEnd" name="endDate" readonly>
                        </div>
                        <div class="mb-3">
                        	<label for="shareDetailLocation" class="form-label"></label>
                        	<input type="text" placeholder="위치" id="shareDetailLocation" name="location" style="width:300px;" readonly>
                        	<div id="map"></div>
                        </div>
                      	<div class="mb-3">
                      		<label for="shareDetailMemo" class="form-label">메모</label>
                            <textarea id="shareDetailMemo" name="memo" readonly></textarea>
                      	</div>
                      	<div class="mb-3">
                      		<label for="shareDetailUserId" class="form-label">아이디</label>
                            <input type="text" id="shareDetailUserId" name="userId" readonly>
                      	</div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
	    // 빈 배열 선언
	    var list = [];
	    
	    // JSP 스크립트릿을 사용하여 ArrayList의 각 요소를 자바스크립트 배열에 추가
	    <c:forEach var="event" items="${list}">
	        list.push({
	            id: "${event.scheduleNo}",
	            title: "${event.title}",
	            start: "${event.startDate}",
	            end: "${event.endDate}",
	            description: "${event.memo}",
	            userId: "${event.userId}"
	        });
	    </c:forEach>
		
	    document.addEventListener('DOMContentLoaded', function() {
	    	/* console.log(list); */
	        const calendarEl = document.getElementById('calendar');
	        const calendar = new FullCalendar.Calendar(calendarEl, {
	            initialView: 'dayGridMonth',
	            customButtons: {
	                private: {
	                    text: '개인 캘린더',
	                    click: function() {
	                        location.href = 'calendar.sc';
	                    }
	                },
	                followList:{
	                	text:'팔로우 목록',
	                	click:function(){
	                		location.href = 'followList.sc?userId=${loginUser.userId}';
	                	}
	                }
	            },
	            headerToolbar: {
	                left: 'prev,next today',
	                center: 'title',
	                right: 'private followList'
	            },
	            events: function(fetchInfo, successCallback, failureCallback) {
	               
	                successCallback(list);
	            },
	            eventContent:function(arg){
	            	//일정 보여주는 목록 설정
	            	let userId = arg.event.extendedProps.userId;
	                let eventTitle = arg.event.title;
	            	/* console.log(eventTitle);
	            	console.log(author); */ // 데이터 확인
	            	
	            	//일정 보여줄때 보이는 내용 커스텀 
	                let contentHtml ='<div>';
	                contentHtml += '<div><strong>'+eventTitle+'</strong> <small>by '+userId+'</small></div>';
	                return { html: contentHtml };
	            },
	            locale:'ko',
	            eventClick:function(info){//일정 클릭했을때 상세 조회
	            	
	            	var id = info.event.id;//조회해올때 내 db에서 만들어진 squence id값 뽑기
	            	//console.log(id); //console로 확인
	            	$.ajax({ //확인해봤으니 ajax로 조회해서 모달창 띄워 정보 보여주기
	            		url:"detailSchedule.sc",
	            		type:"get",
	            		data:{
	            			scheduleNo:id
	            		},
	            		success:function(data){
	            			console.log(data); //조회해온 데이터 확인
	            			//모달창 열기
	            			var map={};
	            			var coords ="";
	            			var shareDetailModal = new bootstrap.Modal(document.getElementById('shareDetailModal'));
	            			document.getElementById('shareDetailTitle').value = data.title;
	                        document.getElementById('shareDetailStart').value = data.startDate;
	                        document.getElementById('shareDetailEnd').value = data.endDate;
	                        if(data.location!=null){//필수 요소가 아니기때문에 확인작업
	                        	document.getElementById('shareDetailLocation').value= data.location;//위치 input창에 값 넣어주기
	                        	
	                        	//map 띄워주기 위한 카카오 api script
	                        	var mapContainer = document.getElementById('map'); // 지도를 표시할 div
	                        	mapContainer.style.width = '100%';
	                            mapContainer.style.height = '350px';
	                        	var mapOption = {
	                                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	                                level: 3 // 지도의 확대 레벨
	                            };  
	                        	
	                             
	                            // 지도를 생성합니다    
	                            map = new kakao.maps.Map(mapContainer, mapOption); 
								
	                            function relayout(){
	                            	map.relayout();
	                            }
	                            // 주소-좌표 변환 객체를 생성합니다
	                            var geocoder = new kakao.maps.services.Geocoder();
	                           
	                            // 주소로 좌표를 검색합니다
	                            geocoder.addressSearch(data.location, function(result, status) {
	                            	 
	                                // 정상적으로 검색이 완료됐으면 
	                                 if (status === kakao.maps.services.Status.OK) {
	
	                                    coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	                                    // 결과값으로 받은 위치를 마커로 표시합니다
	                                    var marker = new kakao.maps.Marker({
	                                        map: map,
	                                        position: coords
	                                    });
	
	                                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	                                    map.setCenter(coords);
	                                    
	                                } 
	                            });  
	                        }
	                        if(data.memo!=null){
	                            document.getElementById('shareDetailMemo').value= data.memo;
	                        }
	                        document.getElementById('shareDetailUserId').value= data.userId;
	                        if('${loginUser.userId}'==data.userId){//수정 삭제 버튼 사용자라면 보여주기
	                        	
	                        } 
	                      
	                        shareDetailModal.show();
		                    if(data.location!=null){//지도를 보여줄 필요가 없다면 실행시키지 않아야함 
		                        	
		                        setTimeout(function(){//모달로 지도 표시하기때문에 지도 생성보다 딜레이 시켜 지도 사이즈 다시 잡기
		                        	map.relayout();
		                        	map.setCenter(coords);
		                        },200);
	                        }
	                       
	            		},
	            		error:function(){
	            			console.log("통신실패");
	            		}
	            	}); 
	            }
	        });
	        calendar.render();
	    });
	</script>
</body>
</html>