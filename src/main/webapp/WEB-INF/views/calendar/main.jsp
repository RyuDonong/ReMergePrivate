<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>캘린더</title>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8bbc3ea0a937b0baf9ab04c7ad6b1970&libraries=services,clusterer"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
    
    .fc .fc-daygrid-day-number,
    .fc .fc-col-header-cell-cushion{
    	color : black;
    	text-decoration : none;
    }
    .mb-3 textarea{
    	width:300px;
    	height:40px;
    }
    #btnDiv{
    	display:none;
    }

    </style>
    
</head>
<body>
    
	<%@include file = "../user/loginHeader.jsp" %>
    <div class="outer">
        <div id="calendar"></div>
    </div>
	
    <!-- 일정 추가 Modal -->
    <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">일정 추가하기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addScheduleForm">
                    	<input type="hidden" name="userId" value=${loginUser.userId} >
                        <div class="mb-3">
                            <label for="scheduleTitle" class="form-label">일정 제목</label>
                            <input type="text" class="form-control" id="scheduleTitle" required>
                        </div>
                        <div class="mb-3">
                            <label for="scheduleStart" class="form-label">일정 시작일</label>
                            <input type="datetime-local" class="form-control" id="scheduleStart" required>
                        </div>
                        <div class="mb-3">
                            <label for="scheduleEnd" class="form-label">일정 종료일</label>
                            <input type="datetime-local" class="form-control" id="scheduleEnd" >
                        </div>
                        <div class="mb-3">
                        	<label for="scheduleLocation" class="form-label"></label>
                        	<input type="text" placeholder="위치" id="scheduleLocation" style="width:300px;">
                        	<input type="button" onclick="searchAddress();" value="위치 검색">
                        </div>
                      	<div class="mb-3">
                      		<label for="scheduleMemo" class="form-label">메모</label>
                            <textarea id="scheduleMemo" ></textarea>
                      	</div>
                        
                        <button type="submit" class="btn btn-primary">일정 추가하기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- detail Modal -->
    <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="detailModalLabel">일정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="updateScheduleForm" action="updateSchedule.sc" method="post">
                    	<input type="hidden" id="detailScheduleNo" name="scheduleNo">
                        <div class="mb-3">
                            <label for="detailTitle" class="form-label">일정 제목</label>
                            <input type="text" class="form-control" id="detailTitle" name="title" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="detailStart" class="form-label">일정 시작일</label>
                            <input type="datetime-local" class="form-control" id="detailStart" name="startDate" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="detailEnd" class="form-label">일정 종료일</label>
                            <input type="datetime-local" class="form-control" id="detailEnd" name="endDate" readonly>
                        </div>
                        <div class="mb-3">
                        	<label for="detailLocation" class="form-label"></label>
                        	<input type="text" placeholder="위치" id="detailLocation" name="location" style="width:300px;" readonly>
                        	<div id="map"></div>
                        </div>
                      	<div class="mb-3">
                      		<label for="detailMemo" class="form-label">메모</label>
                            <textarea id="detailMemo" name="memo" readonly></textarea>
                      	</div>
                      	<div class="mb-3">
                      		<label for="detailUserId" class="form-label">아이디</label>
                            <input type="text" id="detailUserId" name="userId" readonly>
                      	</div>
                      	<div id="btnDiv" class="mb-3">
                        	<button type="submit" class="btn btn-primary flag">수정하기</button>
                        	<button type="button" class="btn btn-danger flag" onclick="deleteSchedule();">일정 삭제</button>
                        </div>	
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
	    
    	document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
            	customButtons: {
            	    shareCalendar: {
            	      text: '공유 캘린더',
            	      click: function() {
            	        location.href='followList.sc';
            	      }
            	   }
            	},
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'shareCalendar'
                },
                selectable: true,
                dateClick: function(info) { //날짜 클릭시 일정 추가를 위한 모달 열기
                	document.getElementById('addScheduleForm').reset();
                	//console.log(info.dateStr); 입력값 확인
                	var dateStr =info.dateStr+'T00:00';//날짜만 입력 되기에 시간은 초기화
                    // 모달 창 열기
                    var scheduleModal = new bootstrap.Modal(document.getElementById('scheduleModal'));
                    //console.log(dateStr);//입력값 확인
                    document.getElementById('scheduleStart').value = dateStr;
                    document.getElementById('scheduleEnd').value = ''; // 종료 날짜 초기화
                    scheduleModal.show();
                    
                },
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
                			//console.log(data); 조회해온 데이터 확인
                			//모달창 열기
                			var map={};
                			var coords ="";
                			var detailModal = new bootstrap.Modal(document.getElementById('detailModal'));
                			document.getElementById('detailScheduleNo').value = data.scheduleNo;
                			console.log(data.scheduleNo);
                			document.getElementById('detailTitle').value = data.title;
                            document.getElementById('detailStart').value = data.startDate;
                            document.getElementById('detailEnd').value = data.endDate;
                            if(data.location!=null){//필수 요소가 아니기때문에 확인작업
                            	document.getElementById('detailLocation').value= data.location;//위치 input창에 값 넣어주기
                            	
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
	                            document.getElementById('detailMemo').value= data.memo;
                            }
                            document.getElementById('detailUserId').value= data.userId;
                            if('${loginUser.userId}'==data.userId){//수정 삭제 버튼 사용자라면 보여주기
                            	
                            	// 버튼이 있는 div 요소 선택
                            	var flag = document.getElementById('btnDiv');

                            	//사용자 이름이 같다면 버튼 div 활성화
                            	flag.style.display='block';
                            	
                            } 
                          
                            detailModal.show();
                            
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
                },
                locale: 'ko',
              	//이벤트 조회해서 보여주기
                events: function(fetchInfo, successCallback, failureCallback) {
                    $.ajax({
                        url: "selectSchedule.sc", 
                        method: "GET",
                        dataType: "json",
                        data:{
                        	userId:"${loginUser.userId}"
                        },
                        success: function(data) {
                        	
                            var events = [];
                            data.forEach(function(event) {
                                events.push({
                                    id: event.scheduleNo,
                                    title: event.title,
                                    start: event.startDate,
                                    end: event.endDate,
                                    description: event.memo,
                                    userId: event.userId
                                });
                            });
                            /* console.log(events); */
                            successCallback(events);
                            
                            //작성자와 사용자가 같을때 수정 가능하게 속성 변경
                            data.forEach(function(schedule){
	                          	if('${loginUser.userId}'==schedule.userId){
	                            	document.getElementById('detailTitle').removeAttribute('readonly');
	                            	document.getElementById('detailStart').removeAttribute('readonly');
	                            	document.getElementById('detailEnd').removeAttribute('readonly');
	                            	document.getElementById('detailLocation').removeAttribute('readonly');
	                            	document.getElementById('detailMemo').removeAttribute('readonly');
	                            }	
                            	
                            })
                        },
                        error: function() {
                            failureCallback();
                        }
                    });
                },
                eventContent:function(arg){
                	//일정 보여주는 목록 설정
                	let userId = arg.event.extendedProps.userId;
                    let eventTitle = arg.event.title;
                	/* console.log(eventTitle);
                	console.log(author); */ // 데이터 확인
                	
                    let contentHtml ='<div>';
                    contentHtml += '<div><strong>'+eventTitle+'</strong> <small>by '+userId+'</small></div>';
                    return { html: contentHtml };
                }
            });
            calendar.render();
        });

            // 일정 추가 폼 submit 시 이벤트 추가
            document.getElementById('addScheduleForm').addEventListener('submit', function(e) {
               e.preventDefault();

                // 폼 데이터 가져오기
                var title = document.getElementById('scheduleTitle').value;
                var start = document.getElementById('scheduleStart').value;
                var end = document.getElementById('scheduleEnd').value;
                var location = document.getElementById('scheduleLocation').value;
                var memo = document.getElementById('scheduleMemo').value;
				console.log(memo);
                $.ajax({//일정 추가 
                	url:"insertSchedule.sc",
                	type:"post",
                	data:{
                		title:title,
                		startDate:start,
                		endDate:end,
                		location:location,
                		memo:memo,
                		userId:"${loginUser.userId}"
                	},
                	success:function(result){
                		if(result>0){
                			alert('성공적으로 등록되었습니다.');
                			location.reload();
                		}else{
                			alert('등록 실패, 관리자에게 문의하세요.')
                		}
                	},
                	error:function(){
                		console.log("통신오류");
                	}
                });

                // 모달 창 닫기
                var scheduleModal = bootstrap.Modal.getInstance(document.getElementById('scheduleModal'));
                scheduleModal.hide();

                // 폼 초기화
                document.getElementById('addScheduleForm').reset();
                
                //
               	setTimeout(function() {
	                window.location.reload();
				}, 3000);
                
            });
            
            //위치 탭에서 주소 검색 하는 함수(postCode api(daum))
            function searchAddress(){
            	var geocoder = new daum.maps.services.Geocoder();
            	new daum.Postcode({
                    oncomplete: function(data) {
                        var addr = data.address; // 최종 주소 변수

                        // 주소 정보를 해당 필드에 넣는다.
                        document.getElementById("scheduleLocation").value = addr;
                        // 주소로 상세 정보를 검색
                        geocoder.addressSearch(data.address, function(results, status) {
                            // 정상적으로 검색이 완료됐으면
                            if (status === daum.maps.services.Status.OK) {

                                var result = results[0]; //첫번째 결과의 값을 활용
                            }
                        });
                    }
                }).open();
            }
    	    
            //삭제 버튼 클릭시 호출되는 함수
            function deleteSchedule(){
            	var scheduleNo = document.getElementById("detailScheduleNo").value;
            	location.href="deleteSchedule.sc?scheduleNo="+scheduleNo;
            }
            
	</script>
	  
</body>
</html>