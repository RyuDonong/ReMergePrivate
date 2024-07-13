<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/css/festivalCSS.jsp"></jsp:include>
</head>
<body>
	<%@ include file="../user/loginHeader.jsp" %>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<div class="outer">
		<div class="festivalTitle">
			축제 리스트 
		</div>
		<div class="festivalContent">
			<div id="openDataResult"></div>
		</div>
		<div class="buttons">
			<button id="prevPage">이전</button>
			<button id="nextPage">다음</button>
		</div>
		
		<!-- 공유하기 버튼 클릭시 보여지는 모달 -->
		<div class="modal fade" id="shareFestival" tabindex="-1" role="dialog" aria-labelledby="shareFestivalTitle" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="shareFestivalTitle">공유하기</h5>
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <div class="modal-body">
		            </div>
		        </div>
		    </div>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function(){
			var pageNo = 1;
			function paging(pageNo){
				$.ajax({
					url:"selectFestival.fs",
					type:"get",
					data:{
						pageNo:pageNo,
					},
					success:function(data){
						/* console.log(data); */
						var items=data.response.body.items;
						var str = "<ul class='festivalBox'>";
						for(var i=0;i<items.length;i++){
							var item = items[i];
							var recommendCount = getRecommendCount(item.fstvlNm);
							var recStr = getRecStr(item.fstvlNm);
							str+="<li>";
							str+="<div onclick='naverPage("+JSON.stringify(item)+");'>";
							str+="<strong>"+item.fstvlNm+"</strong>";
							str+="<span>"+item.opar+"</span>";
							str+="<div>"+item.fstvlStartDate+" ~ "+item.fstvlEndDate+"</div>"
							str+="<div>"+item.fstvlCo+"</div>";
							str+="</div>"
							if(recommendCount > 0){
                                str += "<div class='countRecommend'>추천 수 : " + recommendCount + "</div>";
                            }
							if(${not empty loginUser}){
								if(recStr === '추천'){
									str+="<button onclick='recommend(event,"+JSON.stringify(item)+");'>"+recStr+"</button>";
								}else{
									str+="<button onclick='deRecommend(event,"+JSON.stringify(item)+");'>"+recStr+"</button>";
								}
								str+="<botton onclick='shareFestival("+JSON.stringify(item)+");'><img src='resources/shareIcon.png'></button>"
							}
							str+="</li>";
						}
						str+="</ul>";
						document.getElementById("openDataResult").innerHTML = str;
						//console.log("ajax 실행됨");
						updateButton(pageNo);
					},
					error:function(){
						console.log("통신 실패");
					}
				});
			}
			paging(pageNo);
			//1 페이지 일때 이전 버튼 막기
			function updateButton(pageNo) {
                if (pageNo === 1) {
                    $("#prevPage").attr("disabled", true);
                } else {
                    $("#prevPage").attr("disabled", false);
                }
            }
			
			//데이터 이전 버튼 
			$("#prevPage").click(function() {
		        if (pageNo > 1) {
			    	pageNo--;
			        paging(pageNo);
			    
			    }
			 });
			 
			 //데이터 다음버튼 
			 $("#nextPage").click(function() {
			 	pageNo++;
			 	/* console.log(pageNo); */
			    paging(pageNo);
			 });
			 
			 //세션에 담긴 추천수 공공데이터와 비교하여 추천수 넣어주기
			 function getRecommendCount(festivalName) {
                var count = 0;
                <c:forEach var="recommend" items="${recommendList}">
                    if (festivalName === "${recommend.festivalName}") {
                        count = ${recommend.recommendCount};
                    }
                </c:forEach>
                return count;
	         }
			 
             //추천 누른 유저 비교하여 비추천 으로 바꾸기 
			 function getRecStr(festivalName){
				 var recStr='추천';
				 <c:forEach var="recommendUser" items="${userList}">
                 if (festivalName === "${recommendUser.festivalName}"&& ${recommendUser.userId eq loginUser.userId} ) {
                     //console.log("통과");
                     recStr = '추천 취소';
                 }
            	 </c:forEach>
            	 return recStr;
			 }
		});//$(function 닫기 
	
		function naverPage(data){
			//console.log(data.homepageUrl); 
			location.href="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+encodeURIComponent(data.fstvlNm); 
		}
		
		//추천하기
		function recommend(e,festival){
			e.preventDefault();
			e.stopPropagation();
			var festivalName = festival.fstvlNm;
			$.ajax({
				url:"insertRecommend.fs",
				type:"post",
				data:{
					userId:"${loginUser.userId}",
					festivalName:festivalName
				},
				success:function(data){
					//console.log(data);
					if(data>0){
						alert('성공적으로 추천되었습니다.');
            			location.reload();
					}
				},
				error:function(){
					
				}
			});
			
		}
		
		//추천 취소
		function deRecommend(e,festival){
			e.preventDefault();
			e.stopPropagation();
			var festivalName = festival.fstvlNm;
			$.ajax({
				url:"deleteRecommend.fs",
				type:"post",
				data:{
					userId:"${loginUser.userId}",
					festivalName:festivalName
				},
				success:function(data){
					//console.log(data);
					if(data>0){
						alert('성공적으로 취소되었습니다.');
	        			location.reload();
					}
				},
				error:function(){
					
				}
			});
			
		}
		//모달 보여주기
		function shareFestival(data){
			//console.log(data.fstvlNm);
			$("#shareFestival").modal('show');
			var shareButtonHtml="";
			shareButtonHtml+="<div id='shareChat' onclick='shareChat("+JSON.stringify(data)+");'><img src='resources/chat.png'>DM</div>";
			shareButtonHtml+="<div id='shareCopy' onclick='shareCopy("+JSON.stringify(data)+");'><img src='resources/copyIcon.png'>복사하기</div>";
			$(".modal-body").html(shareButtonHtml);
			
		}
		function shareChat(data){
			//console.log(data);
			alert("메세지 기능 구현 후 구현될 서비스입니당 ^^* ");
		}
		
		function shareCopy(data){
			navigator.clipboard.writeText("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+encodeURIComponent(data.fstvlNm)).then(
					  () => {
					    // 클립보드에 write이 성공했을 때 불리는 핸들러
					    alert("복사되었습니다.");
					  }
					);
		}
		
	</script>

</body>
</html>