<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/css/feedCSS.jsp"></jsp:include>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"
/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
</head>
<body>
<%@include file="../user/loginHeader.jsp" %>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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

	<script type="text/javascript">
	
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
		            var likeCountElement = likeButton.siblings('.reply-like-count');
		
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
		            var likeCountElement = likeButton.siblings('.reply-like-count');
		
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
	
	
	
	</script>
</body>
</html>