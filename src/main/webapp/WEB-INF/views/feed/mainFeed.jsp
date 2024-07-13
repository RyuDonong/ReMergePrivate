<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main 페이지</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>	
  <jsp:include page="/WEB-INF/css/feedCSS.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 스와이퍼 css,cdn -->
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"
/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91ad4af1e5f058ed4f88efab8357dc34&libraries=services,clusterer"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<%@include file="../user/loginHeader.jsp"%>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <div class="outer">
        <!--스토리 목록-->
        <div class="storySwiper">
            <div class="storys swiper-wrapper">
            	<div class="story swiper-slide" onclick="addStory();">
		      		<img class="story_img" src="resources/plusicon.jpeg">
		      		<span>스토리 추가하기</span>
		      	</div>
            </div>
            <div class="swiper-button-prev"></div>
 			<div class="swiper-button-next"></div>
         </div>   
    <div class="body">
		   <div class="con_wrap">
		    <div class="conA">
		        <!-- 게시글 목록 영역 -->
		    </div>
		    <div class="container">
		        <div class="profile-header">
		        <c:choose>
		         	<c:when test="${loginUser.profileChangeName eq null}">
		         		<img id="profile" src="resources/unknown.jpg">
		         	</c:when>
		         	<c:otherwise>
		         		<img id="profile" src="${loginUser.profileChangeName}">
		         	</c:otherwise>
		        </c:choose>
		            <div class="profile-info">
		                <span class="username">${loginUser.userId}</span>
		            </div>
		        </div>
		        <div class="suggestions-header">
		            <span>회원님을 위한 추천</span>
		            <a href="followDetailList.fe?userId=${loginUser.userId}">모두보기</a>
		        </div>
		        <div class="suggestion" id="suggestion"></div>
		    </div>
		</div>
	</div>
	
	<!-- 첫 번째 모달: 이미지 업로드 -->
	<div class="modal fade" id="modal_create" tabindex="-1" role="dialog" aria-labelledby="modal_create_title" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="modal_create_title">이미지 업로드</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body d-flex justify-content-center align-items-center">
	                <div class="form-group text-center">
	                    <label for="files" class="custom-file-label">이미지 선택</label>
	                    <input type="file" class="form-control-file d-none" id="files" name="upfiles" multiple>
	                </div>
	                <div class="swiper-container mt-3" id="thumbnailsFeedSwiper">
	                    <div class="swiper-wrapper" id="thumbnailsFeed">
	                        <!-- 썸네일 이미지들이 이곳에 추가됩니다. -->
	                    </div>
	                    <!-- Add Pagination -->
	                    <div class="swiper-pagination"></div>
	                    <!-- Add Navigation -->
	                    <div class="swiper-button-next"></div>
	                    <div class="swiper-button-prev"></div>
	                </div>
	                <button id="confirm_button" class="btn btn-primary mt-3">다음</button>
	            </div>
	        </div>
	    </div>
	</div>

		
	<!-- 두 번째 모달: 게시글 작성 -->
	<div class="modal fade" id="modal_second" tabindex="-1" role="dialog" aria-labelledby="modal_second_title" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="modal_second_title">게시물 작성</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <form id="uploadForm" action="insert.fe" method="post" enctype="multipart/form-data">
	                <input type="hidden" value="${loginUser.userId}" name="feedWriter">
	                <div class="modal-body d-flex">
	                    <div class="thumbnail-container flex-fill text-center">
	                        <div class="swiper-container mt-3" id="selectedThumbnailsSwiper">
	                            <div class="swiper-wrapper" id="selectedThumbnails">
	                                <!-- 선택된 썸네일 이미지들이 이곳에 추가됩니다. -->
	                            </div>
	                            <!-- Add Pagination -->
	                            <div class="swiper-pagination"></div>
	                            <!-- Add Navigation -->
	                            <div class="swiper-button-next"></div>
	                            <div class="swiper-button-prev"></div>
	                        </div>
	                    </div>
	                    <div class="flex-fill ml-3">
	                        <div class="form-group">
	                            <label for="post_text">게시물 내용</label>
	                            <textarea class="form-control" id="post_text" rows="3" name="feedContent" placeholder="게시물 내용을 입력하세요..."></textarea>
	                        </div>
	                        <div class="form-group">
	                            <label for="tags">태그</label>
	                            <input type="text" class="form-control" id="tags" name="tags" placeholder="(#제외)태그를 입력해주세요">
	                            <div id="tagSuggestions" class="list-group"></div> <!-- 태그 제안 리스트 -->
	                        </div>
	                        <div class="form-group">
	                            <label for="location">위치</label>
	                            <input type="text" class="form-control" id="feedLocation" name="feedLocation" placeholder="위치를 입력하세요">
	                            <input type="button" onclick="searchAddress();" value="위치 검색">
	                        </div>
	                        <button type="submit" id="submit_post_button" class="btn btn-primary">게시</button>
	                    </div>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
	
	<!-- 게시물 디테일 모달 -->
	<div class="modal fade" id="modal_detail_feed" tabindex="-1" role="dialog" aria-labelledby="modal_detail_feed" aria-hidden="true">
	    <div class="modal-dialog modal-xl" role="document">
	        <div class="modal-content">
	            <div class="modal-body d-flex p-0">
	                <div class="modal-image flex-fill">
	                    <div class="swiper-container postSwiperDetail">
	                        <div class="swiper-wrapper" id="feed_detail_images">
	                            <!-- 이미지 슬라이드가 여기 추가됩니다. -->
	                        </div>
	                        <!-- 점  -->
	                        <div class="swiper-pagination"></div>
	                        <!-- 다음 전 -->
	                        <div class="swiper-button-next"></div>
	                        <div class="swiper-button-prev"></div>
	                    </div>
	                </div>
	                <div class="modal-details flex-fill d-flex flex-column">
	                    <div class="modal-header">
	                        <div class="d-flex align-items-center">
	                            <img src="resources/unknown.jpg" id="feed_user_img" class="rounded-circle" alt="프로필 사진">
	                            <div class="ml-2">
	                                <span class="username" id="feed_userId">사용자 이름</span>
	                                <div id="feed_location" class="text-muted" style="font-size: 12px;">위치 정보</div>
	                                <span class="timeAgo" id="feed_timeAgo"></span> <!-- 시간 경과 표시 -->
	                            </div>
	                        </div>
	                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                            <span aria-hidden="true">&times;</span>
	                        </button>
	                    </div>
	                    <div class="modal-body-content flex-fill p-3" style="overflow-y: auto;">
	                        <div id="feed_detail_content" class="mb-3"></div>
	                        <div id="feed_detail_replyList" class="comment-section"></div>
	                    </div>
	                    <div class="modal-footer border-top p-3 flex-column">
	                        <div id="feed_detail_like" class="mb-2 d-flex align-items-center w-100">
	                            <button id="likeButtonDetail" class="like-button btn p-0 mr-2">
	                                <i class="heart-icon far fa-heart" style="font-size: 24px; color: #FF5A5F;"></i>
	                            </button>
	                            <span id="likeCountDetail"></span>개
	                        </div>
	                        <div id="like_reply" class="w-100">
	                            <div class="form-group d-flex mb-0">
	                                <input type="text" name="content" id="content${feedNo}" class="form-control mr-2" placeholder="댓글을 입력해주세요.." style="height: 40px;">
	                                <button class="btn btn-primary" onclick="insertReply(${feedNo})">등록</button>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
		
		<!-- 지도 모달 -->
		<div class="modal fade" id="mapModal" tabindex="-1" role="dialog" aria-labelledby="mapModalTitle" aria-hidden="true">
		    <div class="modal-dialog modal-lg" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="mapModalTitle">위치 지도</h5>
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <div class="modal-body">
		                <div id="map" style="width: 100%; height: 800px;"></div>
		            </div>
		        </div>
		    </div>
		</div>
				
		<!-- 스토리 추가 모달 -->
		<div class="modal fade" id="modal_create_story" tabindex="-1" role="dialog" aria-labelledby="modal_create_story" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal_create_story_title">스토리 만들기</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" id="storyModalBody">
						<form action="insertStory.fe" method="post" enctype="multipart/form-data">
							<div class="form-group">
								<input type="hidden" name="userId" value="${loginUser.userId }">
								<label for="storyFile">이미지 선택</label> 
								<input type="file" class="form-control-file" id="storyFile" name="storyFile">
							</div>
							<div id="thumbnailContainer">
								<img id="storyThumbnail" class="thumbnail" alt="Thumbnail">
							</div>
								<br>
								<label for="storyContent">한줄 내용 : </label>
								<input type="text" name="storyContent" style="width:300px;">
								<button type="submit" class="btn btn-primary">등록</button>
						</form>
					</div>
				</div>
			</div>
		</div>


	<!-- 스토리 뷰 모달 -->
	<div class="modal fade" id="modal_view_story" tabindex="-1"
		role="dialog" aria-labelledby="modal_view_story_title"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal_view_story_title">스토리</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="storyClose();">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<img src="" id="story_view_img">
					<!-- 스토리 사진 영역 -->
					<div id="story_view_content"></div>
					<!-- 스토리 내용 영역 -->
					<button id="nextStory">next</button>
				</div>
			</div>
		</div>
	</div>
</div>
	<script>
		<!-- 태그 -->
		$(document).ready(function() {
		    $('#uploadForm').submit(function(event) {
		        var tags = $('#tag').val();
		        if (tags) {
		            tags = tags.split(' ').join(','); // 공백으로 구분된 태그를 쉼표로 구분
		            $('#tag').val(tags);
		        }
		    });
		});
		
		<!-- 게시물 등록 스크립트 -->
		 <!--썸네일 만들기-->
		 $(document).ready(function() {
			feedList(1);
			loadAllLikes();
			
			$(window).scroll(function() {
	            if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
	                // 현재 페이지 수를 가져와서 다음 페이지를 로드합니다.
	                const currentPage = Math.ceil($('.con').length / 6) + 1; // 예시: 현재 보여지는 게시물 갯수로 대체
	                feedList(currentPage);
	            }
	        });
		
			const fileInput = document.getElementById('files');
		    const thumbnailsFeed = document.getElementById('thumbnailsFeed');
		    const selectedThumbnails = document.getElementById('selectedThumbnails');
		    let selectedFiles = [];

		    fileInput.addEventListener('change', function() {
		        thumbnailsFeed.innerHTML = ''; // 기존 썸네일 초기화
		        selectedFiles = Array.from(fileInput.files);
		        
		        selectedFiles.forEach(file => {
		            const reader = new FileReader();
		            reader.onload = function(e) {
		                const img = document.createElement('img');
		                img.setAttribute('src', e.target.result);
		                img.setAttribute('class', 'swiper-slide thumbnail img-fluid m-2');
		                thumbnailsFeed.appendChild(img);
		            };
		            reader.readAsDataURL(file);
		        });
		        
		        new Swiper('#thumbnailsFeedSwiper', {
		            slidesPerView: 1,
		            spaceBetween: 10,
		            centeredSlides: true,
		            navigation: {
		                nextEl: '.swiper-button-next',
		                prevEl: '.swiper-button-prev',
		            },
		            pagination: {
		                el: '.swiper-pagination',
		                clickable: true,
		            },
		        });
		    });

		    $('#confirm_button').click(function() {
		        $('#modal_create').modal('hide');
		        selectedThumbnails.innerHTML = ''; // 기존 썸네일 초기화

		        selectedFiles.forEach(file => {
		            const reader = new FileReader();
		            reader.onload = function(e) {
		                const img = document.createElement('img');
		                img.setAttribute('src', e.target.result);
		                img.setAttribute('class', 'swiper-slide thumbnail img-fluid m-2');
		                selectedThumbnails.appendChild(img);
		            };
		            reader.readAsDataURL(file);
		        });
		        
		        new Swiper('#selectedThumbnailsSwiper', {
		            slidesPerView: 1,
		            spaceBetween: 10,
		            centeredSlides: true,
		            navigation: {
		                nextEl: '.swiper-button-next',
		                prevEl: '.swiper-button-prev',
		            },
		            pagination: {
		                el: '.swiper-pagination',
		                clickable: true,
		            },
		        });

		        $('#modal_second').modal('show');
		    });

		    $('#uploadForm').submit(function(event) {
		        event.preventDefault();
		        const formData = new FormData();
		        selectedFiles.forEach(file => {
		            formData.append('upfiles', file);
		        });
		        formData.append('feedWriter', $('[name="feedWriter"]').val());
		        formData.append('feedContent', $('#post_text').val());
		        formData.append('feedLocation', $('#feedLocation').val());
		        formData.append('tags', $('#tags').val());

		        <!-- 게시글 등록 ajax -->
		        $.ajax({
		            url: 'insert.fe',
		            type: 'POST',
		            data: formData,
		            processData: false,
		            contentType: false,
		            success: function(response) {
		                // 성공 시 로직 추가
		                alert('게시물이 성공적으로 업로드되었습니다.');
		                location.reload();
		            },
		            error: function(jqXHR, textStatus, errorThrown) {
		                // 실패 시 로직 추가
		                alert('게시물 업로드에 실패했습니다.');
		            }
		        });
		    });
		});
		 		
		 	function loadAllLikes() {
			    $('.con').each(function() {
			        var feedNo = $(this).data('feed-no');
			        var userId = '${loginUser.userId}';
			        loadLikeStatus(feedNo, userId);
			    });
			}

	      // 첫 번째 모달 열기
	      $('#create').click(function() {
	        $('#modal_create').modal('show');
	      });

	      // 첫 번째 모달 확인 버튼 클릭 시 두 번째 모달 열기
	     $('#confirm_button').click(function() {
	       $('#modal_create').modal('hide');
	       $('#modal_second').modal('show');
	       console.log($('#file'));
	     });


		 // 두 번째 모달 닫기
		 $('#close_second_modal_button').click(function() {
		   $('#modal_second').modal('hide');
		 });
		 
		 //게시물 모달 닫기
		 $('#close_createDetail_button').click(function() {
		   $('#createDetail').modal('hide');
		 });
		
		</script>
		
	<!-- 스토리 조회해오기 --> 
	<script>
		// 전역 변수 선언
	    var currentStoryIndex = 0;
	    var storiesData = [];

		$(function(){
			
			$.ajax({
				url:"selectStory.fe",
				type:"post",
				data:{
					userId:"${loginUser.userId}"
				},
				success:function(data){
					// 스토리 데이터를 전역 변수에 저장
	                storiesData = data.story;
					var story = data.story;
					var history = data.history;
					//console.log(data); 데이터 확인
					//스토리 기능은 한명이 작성한 글은 하나의 글로 확인 가능하고
					//상세페이지를 조회한다면 다른 글도 조회할수 있기 때문에 view페이지에서 한 유저의 스토리들은 하나로만 보여야 함
					//그에 따라 처리된 아이디를 저장하고 저장된 아이디와 비교하며 html 생성
					var seenStory = false;
					var html = "";
					const processedUserIds = new Set();// 생성된 스토리 html 아이디를 저장할 집합
					for(var i=0;i<story.length;i++){
						if(!processedUserIds.has(story[i].userId)){//저장된 집합에 이름이 있는지 확인
							
							html +="<div class='story swiper-slide' onclick='storyView("+i+");'>";
							html +="<input type='hidden' class='storyNoCheck' value='"+story[i].storyNo+"'>";
							html +="<img class='story_img' src='"+story[i].changeName+"'>";
							html +="<span>"+story[i].userId+"</span>";
							html +="</div>";
							processedUserIds.add(story[i].userId);//처리된 아이디 집합에 넣기
						}
					}
					$(".storys").append(html);//작성된 html 넣어주기
					for (var i = 0; i < history.length; i++) {
	                    // 해당 스토리 이미지를 찾아서 클래스 추가
	                    var storyNo = history[i].storyNo;
	                    $(".storyNoCheck").each(function() {
	                        if ($(this).val() == storyNo) {
	                            $(this).siblings('.story_img').addClass('readed');
	                        }
	                    });
	                }
				},
				error:function(){
					console.log("통신 실패");
				}
			});
		});	
		/* 스토리 스와이프 */
		 new Swiper('.storySwiper', {
	            slidesPerView: 8,
	            spaceBetween: 2,
	            navigation: {
	                nextEl: '.swiper-button-next',
	                prevEl: '.swiper-button-prev',
	            },
	            pagination: {
	                el: '.swiper-pagination',
	                clickable: true,
	            },
	        });
		
		<!-- 게시글 detail 스와이프 -->
		function detailSwiper() {
		    new Swiper('.postSwiperDetail', {
		        slidesPerView: 1,
		        spaceBetween: 10,
		        centeredSlides: true,
		        navigation: {
		            nextEl: '.postSwiperDetail .swiper-button-next',
		            prevEl: '.postSwiperDetail .swiper-button-prev',
		        },
		        pagination: {
		            el: '.postSwiperDetail .swiper-pagination',
		            clickable: true,
		        },
		    });
		}

		<!-- 게시글 detail 불러오기 -->
		function detailView(feedNo){
			var userId = '${loginUser.userId}';
			$('#modal_detail_feed').modal('show');
			$.ajax({
				url : "detail.fe",
				type : "post",
				data :{
					feedNo : feedNo
				},
				success:function(result){
			         $('#feed_userId').text(result.f.feedWriter);
			         $('#feed_location').text(result.f.feedLocation || '');
			         $('#feed_detail_content').text(result.f.feedContent || '');
			         
			         var timeAgo = result.timeAgo; // 디테일 모달에서도 시간 표시
			         $('#feed_timeAgo').text(timeAgo);
			         
			         if (result.f.userProfile && result.f.userProfile.profileChangeName) {
			                $('#feed_user_img').attr('src', result.f.userProfile.profileChangeName);
			            } else {
			                $('#feed_user_img').attr('src', 'resources/unknown.jpg');
			            }
			         
			         loadLikeStatusDetail(result.f.feedNo, userId); //디테일 게시글 좋아요 유저
			         
			         if (result.f.feedImg && result.f.feedImg.length > 0) {
			                var slides = '';
			                result.f.feedImg.forEach(function(img) {
			                    slides += '<div class="swiper-slide"><img src="' + img.changeName + '" alt="" class="con_img"></div>';
			                });
			                $('#feed_detail_images').html(slides);
			                detailSwiper();
			            } else {
			                $('#feed_detail_images').html('<div class="swiper-slide"><img src="" class="con_img"></div>');
			            }
			         
			         var str = "";
			         for(var i = 0; i<result.rList.length; i++){
			        	 var reply = result.rList[i];
			        		str += '<div class="modal-body">';
			        	    str += '    <div id="feed_detail_replyList">';
			        	    str += '        <p><strong>' + reply.userId + ':</strong> ' + reply.reContent;
			        	    str += '            <button class="reply-like-button" onclick="toggleReplyLike(' + reply.replyNo + ', \'' + "${loginUser.userId}"	+ '\')">';
			        	    str += '                <i class="reply-heart-icon far fa-heart"></i>';
			        	    str += '            </button>';
			        	    str += '            <span class="reply-like-count" id="reply-like-count-' + reply.replyNo + '"></span>';
			        	    str += '        </p>';
			        	    str += '    </div>';
			        	    str += '</div>';

			         }
			         
			         $('#feed_detail_replyList').html(str);
			         
					 var reHtml = "";			        
					 reHtml += '<div>';
					 reHtml += '<input type="text" name="content" id="content'+result.f.feedNo+'" placeholder="댓글을 입력해주세요..">';
					 reHtml += '<label><button onclick="insertModal(this,'+result.f.feedNo+')">등록</button></label>'
					 reHtml += '</div>';
	
			         var content = $("#content"+feedNo).val();
			         console.log("content",content);
			         $('.form-group').html(reHtml);
			         
			         $("#likeButtonDetail").off("click").on("click", function() {
			                toggleLikeDetail(result.f.feedNo, userId);
			            });
			         
			         // 댓글 좋아요 상태 로드
			            for (var i = 0; i < result.rList.length; i++) {
			                var reply = result.rList[i];
			                loadReplyLikeStatus(reply.replyNo, userId);
			            }
			         
				},
				error : function(){
					console.log("통신실패");	
				}
			});
		}

		function storyView(index){ 
			currentStoryIndex = index; // 현재 스토리 인덱스 업데이트
	        var data = storiesData[index]; 
			$('#modal_view_story_title').html(data.userId);
			$('#story_view_img').attr('src',data.changeName);
			$('#story_view_content').html(data.storyContent);
			$('#modal_view_story').modal('show');//스토리 div 누르면 view 보여주기
			
			$.ajax({//시청 기록 넣기
				url:"insertHistory.fe",
				type:"post",
				data:{
					userId:"${loginUser.userId}",
					storyNo:data.storyNo
				},
				success:function(result){
					//console.log(result);//시청 기록 추가 확인
				},
				error:function(){
					console.log("통신 실패");
				}
				
			});
			
		}
		
		// 다음 스토리를 보여주는 함수
	    function showNextStory(){
	        if(currentStoryIndex < storiesData.length - 1){ //조회해왔던 data 길이 -1 과 비교후 작을때만 
	            storyView(currentStoryIndex + 1);
	        } else {
	            alert("마지막 스토리입니다.");
	        }
	    }

	    // nextStory 버튼 클릭 이벤트
	    $('#nextStory').click(function(){
	        showNextStory();
	    });
	    

		</script>
		
		<!-- 게시글 스와이프 -->
		<script>
		function initializePostSwiper() {
            $('.postSwiper').each(function() {
                new Swiper(this, {
                    slidesPerView: 1,
                    spaceBetween: 10,
                    centeredSlides: true,
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                    },
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
                    },
                });
            });
        }
		</script>

	<script>
		<!-- 게시글 리스트 목록 -->
		function feedList(currentPage) {
            $.ajax({
                url: 'feedList.fe',
                type: 'POST',
                dataType: 'json',
                data: {
                    currentPage: currentPage,
                    userId: "${loginUser.userId}"
                },
                success: function(response) {
                    var str = "";
                    var timeAgoMap = response.timeAgoMap;
                    for (var i = 0; i < response.list.length; i++) {
                        var feed = response.list[i];
                        var userProfile = feed.userProfile;
                        str += '<div class="con" data-feed-no="' + feed.feedNo + '">';
                        str += '    <div class="title">';
                        if (userProfile && userProfile.profileChangeName) {
                            str += '        <img src="' + userProfile.profileChangeName + '" class="img">';
                        } else {
                            str += '        <img src="resources/unknown.jpg" class="img">';
                        }
                        str += '        <div class="info">';
                        str += '            <span class="username">' + feed.feedWriter + '</span>';
                        str += '            <span class="timeAgo">' + timeAgoMap[feed.feedNo] + '</span>';
                        str += '            <p class="location" onclick="showMap(\'' + feed.feedLocation + '\')">' + feed.feedLocation + '</p>';
                        str += '        </div>';
                        str += '    </div>';
                        str += '    <div class="swiper-container postSwiper">';
                        str += '        <div class="swiper-wrapper">';
                        if (feed.feedImg && feed.feedImg.length > 0) {
                            for (var j = 0; j < feed.feedImg.length; j++) {
                                var img = feed.feedImg[j];
                                str += '    <div class="swiper-slide">';
                                str += '        <img src="' + img.changeName + '" alt="" class="con_img">';
                                str += '    </div>';
                            }
                        }
                        str += '        </div>';
                        str += '        <div class="swiper-pagination"></div>';
                        str += '        <div class="swiper-button-next"></div>';
                        str += '        <div class="swiper-button-prev"></div>';
                        str += '    </div>';
                        str += '    <div class="logos">';
                        str += '        <div class="logos_left">';
                        str += '            <button id="likeButton' + feed.feedNo + '" class="like-button" data-feed-no="' + feed.feedNo + '" data-user-id="' + '${loginUser.userId}' + '" onclick="toggleLike(' + feed.feedNo + ', \'' + '${loginUser.userId}' + '\')">';
                        str += '                <i class="heart-icon far fa-heart" style="font-size: 30px; color: #ff5a5f;"></i>';
                        str += '            </button>';
                        str += '            <img src="resources/chat.png" class="logo_img" onclick="detailView(' + feed.feedNo + ')" >';
                        str += '            <img src="resources/direct.png" alt="" class="logo_img">';
                        str += '        </div>';
                        str += '        <div class="logos_right">';
                        str += '            <button id="saveButton' + feed.feedNo + '" class="save-button" data-feed-no="' + feed.feedNo + '" onclick="saveFeed(' + feed.feedNo + ')">';
                        str += '                <i class="save-icon far fa-bookmark" style="font-size: 30px;"></i>';
                        str += '            </button>';
                        str += '        </div>';
                        str += '    </div>';
                        str += '    <div class="content">';
                        str += '        <p><b>좋아요 <span class="like-count" data-feed-no="' + feed.feedNo + '">' + feed.likeCount + '</span>개</b></p>';
                        str += '        <p id="feedContent' + feed.feedNo + '" class="feed-content">' + feed.feedContent + '</p>';
                        str += '        <button id="moreButton' + feed.feedNo + '" class="more-button" onclick="showFullContent(' + feed.feedNo + ')" style="display: none;">더보기</button>';
                        str += '        <div id="fullContent' + feed.feedNo + '" class="full-content" style="display: none;">' + feed.feedContent + '</div>';
                        str += '        <div id="replyList' + feed.feedNo + '"></div>';
                        if (feed.tags && feed.tags.length > 0) {
                            str += '        <p>';
                            for (var j = 0; j < feed.tags.length; j++) {
                                str += '<a href="selectTag.fe?tagContent=' + encodeURIComponent(feed.tags[j]) + '">#' + feed.tags[j] + '</a> ';
                            }
                            str += '        </p>';
                        }
                        str += '        <input type="text" name="reContent" id="reContent' + feed.feedNo + '" placeholder="댓글을 입력해주세요..">';
                        str += '        <label><button onclick="insertReply(' + feed.feedNo + ')">등록</button></label>';
                        str += '    </div>';
                        str += '</div>';
                        
                        replyList(feed.feedNo);
                    }
                    $(".conA").append(str);
                    if (currentPage >= response.pi.maxPage) {
                        $(window).unbind('scroll');
                    }
                    loadAllLikes();
                    loadAllSaves();
                    applyContent();
                    initializePostSwiper();
                },
                error: function() {
                    alert('게시물 로딩에 실패했습니다.');
                }
            });
        }
		</script>

		<!-- 댓글 리스트 -->
		<script>
		function replyList(feedNo){
		    $.ajax({
		        url : "replyList.fe",
		        data : {
		            feedNo : feedNo
		        },
		        success : function(result){
		            var str = "";
		            if(result.rList.length > 0){
		                    var reply = result.rList[0];
		                    str += '<div class="comment">';
		                    str += '    <p><strong class="username">' + reply.userId + ':</strong> ' + reply.reContent + '</p>';
		                    str += '    <button class="reply-like-button" onclick="toggleReplyLike(' + reply.replyNo + ', \'' + reply.userId + '\')">';
		                    str += '</div>';
		            }
		            $("#replyList" + feedNo).html(str); // 댓글 리스트를 해당 게시물 div에 추가
		            
		        },
		        error : function(){
		            console.log("통신오류");
		        }
		    });
		};
			
			<!-- 댓글 입력 -->
			function insertReply(feedNo){
				var reContent =$("#reContent" + feedNo).val();
				
				$.ajax({	
					url : "insertReply.fe",
					type : "post",
					data : {
						feedNo : feedNo,
						userId : "${loginUser.userId}",
						reContent: reContent
					},
					success : function(result){
						if(result>0){
							replyList(feedNo); //추가된 댓글 정보까지 다시 조회
							$("#reContent"+feedNo).val("");
							
							alert("댓글등록");
						}else{
							alert("댓글작성실패");
						}
					},
					error : function(){
						console.log("안 뜸");
					}
				});
			};
			
			<!-- 두번째 댓글 입력 -->
			function insertModal(el,feedNo){
				var content = $(el).parent().siblings().first().val();
				
				$.ajax({
					url : "insertModal.fe",
					type : "post",
					data : {
						feedNo : feedNo,
						userId : "${loginUser.userId}",
						reContent : content 
					},
					success : function(result){
						if(result>0){
							var newReply = '<div class="reply">';
			                newReply += '<p><strong>${loginUser.userId}:</strong> ' + content + '</p>';
			                newReply += '</div>';
			                
			                $('#feed_detail_replyList').append(newReply); // 댓글 리스트에 새로운 댓글 추가
			                $(el).parent().siblings().first().val(""); // 입력 필드 초기화
							alert("댓글 등록");
						}else{
							alert("댓글작성실패");
						}
					},
					error : function(){
						console.log("안 떠요");
					}
				});
			};
			
		</script>
		
		<!-- 좋아요 상태 확인 -->
		<script>
			function loadLikeStatus(feedNo, userId) {
			    $.ajax({
			        url: "likeStatus.fe",
			        type: "get",
			        data: {
			            feedNo: feedNo,
			            userId: userId
			        },
			        success: function(response) {
			            var likeButton = $("#likeButton" + feedNo);
			            var heartIcon = likeButton.find(".heart-icon");
			            var likeCountElement = $(".like-count[data-feed-no='" + feedNo + "']");
	
			            if (response.status === "liked") {
			                likeButton.addClass("liked");
			                heartIcon.removeClass("far fa-heart");
			                heartIcon.addClass("fas fa-heart");
			            } else {
			                likeButton.removeClass("liked");
			                heartIcon.removeClass("fas fa-heart");
			                heartIcon.addClass("far fa-heart");
			            }
	
			            likeCountElement.text(response.likeCount);
			        },
			        error: function() {
			            alert("게시물 정보를 가져오는데 실패했습니다.");
			        }
			    });
			}

           function toggleLike(feedNo, userId) {
               $.ajax({
                   url: "feedLike.fe",
                   type: "post",
                   data: {
                       feedNo: feedNo,
                       userId: userId
                   },
                   success: function(response) {
                       var likeButton = $("#likeButton" + feedNo);
                       var heartIcon = likeButton.find(".heart-icon");

                       if (response.status === "liked") {
                           likeButton.addClass("liked");
                           heartIcon.removeClass("far fa-heart");
                           heartIcon.addClass("fas fa-heart");
                       } else {
                           likeButton.removeClass("liked");
                           heartIcon.removeClass("fas fa-heart");
                           heartIcon.addClass("far fa-heart");
                       }

                       $(".like-count[data-feed-no='" + feedNo + "']").text(response.likeCount);
                   },
                   error: function() {
                       alert("좋아요 실패");
                   }
               });
           }
           
        // 디테일 모달 좋아요 상태 로드
           function loadLikeStatusDetail(feedNo, userId) {
               $.ajax({
                   url: "likeStatus.fe",
                   type: "get",
                   data: {
                       feedNo: feedNo,
                       userId: userId
                   },
                   success: function(response) {
                       var likeButton = $("#likeButtonDetail");
                       var heartIcon = likeButton.find(".heart-icon");
                       var likeCountElement = $("#likeCountDetail");

                       if (response.status === "liked") {
                           likeButton.addClass("liked");
                           heartIcon.removeClass("far fa-heart");
                           heartIcon.addClass("fas fa-heart");
                       } else {
                           likeButton.removeClass("liked");
                           heartIcon.removeClass("fas fa-heart");
                           heartIcon.addClass("far fa-heart");
                       }

                       likeCountElement.text(response.likeCount);
                   },
                   error: function() {
                       alert("실패.");
                   }
               });
           }
	         
        // 디테일 모달 좋아요 토글
           function toggleLikeDetail(feedNo, userId) {
               $.ajax({
                   url: "feedLike.fe",
                   type: "post",
                   data: {
                       feedNo: feedNo,
                       userId: userId
                   },
                   success: function(response) {
                       var likeButton = $("#likeButtonDetail");
                       var heartIcon = likeButton.find(".heart-icon");

                       if (response.status === "liked") {
                           likeButton.addClass("liked");
                           heartIcon.removeClass("far fa-heart");
                           heartIcon.addClass("fas fa-heart");
                       } else {
                           likeButton.removeClass("liked");
                           heartIcon.removeClass("fas fa-heart");
                           heartIcon.addClass("far fa-heart");
                       }

                       $("#likeCountDetail").text(response.likeCount);
                   },
                   error: function() {
                       alert("좋아요 실패");
                   }
               });
           }
	         
         //댓글 좋아요 
         function toggleReplyLike(replyNo, userId) {
			    $.ajax({
			        url: 'replyLike.fe',
			        type: 'post',
			        data: {
			            replyNo: replyNo,
			            userId: userId
			        },
			        success: function(response) {
			            var likeButton = $('.reply-like-button[onclick="toggleReplyLike(' + replyNo + ', \'' + userId + '\')"]');
			            var heartIcon = likeButton.find('.reply-heart-icon');
			            var likeCountElement = $('#reply-like-count-' + replyNo);
			
			            if (response.status === 'liked') {
			                likeButton.addClass('liked');
			                heartIcon.removeClass('far fa-heart');
			                heartIcon.addClass('fas fa-heart');
			            } else {
			                likeButton.removeClass('liked');
			                heartIcon.removeClass('fas fa-heart');
			                heartIcon.addClass('far fa-heart');
			            }
			
			            likeCountElement.text(response.likeCount);
			        },
			        error: function() {
			            alert('댓글 좋아요 처리에 실패했습니다.');
			        }
			    });
			}
         
     
		        
		// 댓글 좋아요 상태 로드 함수 (필요 시 호출)
		function loadReplyLikeStatus(replyNo, userId) {
			    $.ajax({
			        url: 'replyLikeStatus.fe',
			        type: 'get',
			        data: {
			            replyNo: replyNo,
			            userId: userId
			        },
			        success: function(response) {
			            var likeButton = $('.reply-like-button[onclick="toggleReplyLike(' + replyNo + ', \'' + userId + '\')"]');
			            var heartIcon = likeButton.find('.reply-heart-icon');
			            var likeCountElement = $('#reply-like-count-' + replyNo);
			
			            if (response.status === 'liked') {
			                likeButton.addClass('liked');
			                heartIcon.removeClass('far fa-heart');
			                heartIcon.addClass('fas fa-heart');
			            } else {
			                likeButton.removeClass('liked');
			                heartIcon.removeClass('fas fa-heart');
			                heartIcon.addClass('far fa-heart');
			            }
			
			            likeCountElement.text(response.likeCount);
			        },
			        error: function() {
			            alert('댓글 좋아요 상태를 가져오는데 실패했습니다.');
			        }
			    });
			}
			
		</script>
		
		<script>
			 //주소 검색하는 함수
		    function searchAddress(){
		    	new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수

		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }

		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("feedLocation").value = extraAddr;
		                
		                } else {
		                    document.getElementById("feedLocation").value = '';
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('feedLocation').value = data.zonecode;
		                document.getElementById("feedLocation").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("feedLocation").focus();
		               	
		            }
		        }).open();
		    }
			 
		  //지도 여는 함수
		   window.onload = function () {
	        function showMap(feedLocation) {
	            // 모달을 엽니다.
	            $('#mapModal').modal('show');
	
	            var mapContainer = document.getElementById('map');
	            var mapOption = {
	                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	                level: 3 // 지도의 확대 레벨
	            };
	
	            var map = new kakao.maps.Map(mapContainer, mapOption);
	
	            var geocoder = new kakao.maps.services.Geocoder();
	
	            geocoder.addressSearch(feedLocation, function (result, status) {
	                if (status === kakao.maps.services.Status.OK) {
	                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	                    var marker = new kakao.maps.Marker({
	                        map: map,
	                        position: coords
	                    });
	
	                    map.setCenter(coords);
	
	                    // 모달이 완전히 열린 후에 지도 크기를 조정합니다.
	                    $('#mapModal').on('shown.bs.modal', function () {
	                        map.relayout();
	                        map.setCenter(coords);
	                    });
	                }
	            });
	        }
	        window.showMap = showMap;
	    };
	    
	    	//게시글 더보기 눌렀을 때 보여주는 함수
			function applyContent() {
			    $(".feed-content").each(function() {
			        var content = $(this).text();
			        if (content.length > 30) { // 원하는 글자 수로 변경
			            var shortContent = content.substring(0, 30) + '...';
			            var feedNo = $(this).attr('id').replace('feedContent', '');
			            $(this).html(shortContent);
			            $("#moreButton" + feedNo).show();
			        }
			    });
			}
	    
		    //게시글 더보기 누르면 댓글 보여줌
		    function showFullContent(feedNo) {
		        $("#feedContent" + feedNo).hide();
		        $("#moreButton" + feedNo).hide();
		        $("#fullContent" + feedNo).show();
		    }
		</script>			
			 
			 
		
		
		<script>
		<!-- 스토리 추가 스크립트 -->
		function addStory(){
			
			 $('#modal_create_story').modal('show');//모달 켜기
		}		
		
		var storyFile = document.getElementById('storyFile');//파일 인풋 요소 잡기
		var storyThumbnail = document.getElementById('storyThumbnail'); //미리보기요소 잡아주기

		//스토리 이미지 파일 선택시 미리보기
		storyFile.addEventListener('change', function(event) {//인풋요소에 파일이 들어오면
		     var file = event.target.files[0];//인풋요소 처음들어온 파일 잡고
		     if (file) {//들어온 파일이 있다면
		    	 document.getElementById('thumbnailContainer').style.display='block';//미리보기 감싸는 div숨겨놓고 사진 입력되면 보여주기
		         var storyFileReader = new FileReader();//파일 정보 읽어줄 객체 FileReader() 준비
		         storyFileReader.onload = function(e) {
		             storyThumbnail.setAttribute('src', e.target.result);//파일 읽어 src속성에 넣어주기
		         }
		         storyFileReader.readAsDataURL(file);
		     }
		 });
		function storyClose(){
			
			location.reload();
		}
		
		
	</script>
	
	<!-- 게시글 저장 함수 -->
		<script>
		 // 게시글 저장 함수
	    function saveFeed(feedNo) {
	        $.ajax({
	            url: 'saveFeed.fe',
	            type: 'POST',
	            data: {
	                feedNo: feedNo,
	                userId: "${loginUser.userId}"
	            },
	            success: function(response) {
	                if (response.status === "saved") {
	                    $('#saveButton' + feedNo + ' .save-icon').removeClass('far').addClass('fas');
	                } else {
	                    $('#saveButton' + feedNo + ' .save-icon').removeClass('fas').addClass('far');
	                }
	            },
	            error: function() {
	                alert('저장 요청에 실패했습니다.');
	            }
	        });
	    }
	
	    // 게시글 저장 상태 로드 함수
	    function loadAllSaves() {
	        $(".con").each(function() {
	            var feedNo = $(this).data("feed-no");
	            $.ajax({
	                url: 'saveStatus.fe',
	                type: 'GET',
	                data: {
	                    feedNo: feedNo,
	                    userId: "${loginUser.userId}"
	                },
	                success: function(response) {
	                    if (response.status === "saved") {
	                        $('#saveButton' + feedNo + ' .save-icon').removeClass('far').addClass('fas');
	                    }
	                }
	            });
	        });
	    }
	
	    $(document).ready(function() {
	        loadAllSaves(); // 저장 상태 로드
	    });
		</script>
		
		<!-- 팔로우 안 된 사람 리스트 5명 -->
		<script>
		 $(document).ready(function() {
			 loadRecommend();

		        function loadRecommend() {
		            $.ajax({
		                url: 'recommend.fe',
		                type: 'GET',
		                data: {
		                    userId: "${loginUser.userId}"
		                },
		                success: function(users) {
		                    var suggestionsHtml = '';
						for(var i=0; i<users.length; i++){
							var user = users[i];
							suggestionsHtml += 
								 '<div class="suggestion-info">' +
		                            (user.profileChangeName ? 
		                                '<img src="' + user.profileChangeName + '" alt="Profile Picture">' : 
		                                '<img src="resources/unknown.jpg" alt="Profile Picture">') +
		                            '<div>' +
		                                '<div class="recommendName">' + user.userId + '</div>' +
		                            '</div>' +
		                            '<div class="follow-btn" onclick="follow(\'' + user.userId + '\')">팔로우</div>' +
		                        '</div>';
		                    }
		                    $('#suggestion').html(suggestionsHtml);
		                },
		                error: function() {
		                    console.log('통신 실패');
		                }
		            });
		        }
		    });
		</script>
		
		<!-- 회원 추천 팔로우 -->
		<script>
			function follow(toUser){
				$.ajax({
					url: 'follow.fe',
					type: 'get',
					data: {
						fromUser:"${loginUser.userId}",
						toUser: toUser
					},
					success: function(result){
						console.log(result);
						if(result>0){
							alert('팔로우 성공');
						}else{
							alert('팔로우 실패');
						}
						window.location.reload();//결과 확인 누르면 새로 고침
					},
					error: function(){
						console.log('통신실패');
					}
				});
			}
			
		</script>
	
	
</body>
</html>