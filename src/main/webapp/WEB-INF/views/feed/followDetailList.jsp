<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로우 리스트 조회</title>
  <jsp:include page="/WEB-INF/css/feedCSS.jsp"></jsp:include>
</head>
<body>
<%@include file="/WEB-INF/views/user/loginHeader.jsp" %>
	<div class="outer">
		<div class="container-list">
			<h2>추천</h2>
			<div id="recommendList">
				<c:forEach var="user" items="${recommendList}">
					<div class="suggestion-list">
						<div class="suggestion-info-list">
							<c:choose>
								<c:when test="${user.profileChangeName != null}">
									<img src="${user.profileChangeName}" alt="Profile Picture">
								</c:when>
								<c:otherwise>
									<img src="resources/unknown.jpg" alt="Profile Picture">
								</c:otherwise>
							</c:choose>
							<div>
								<div class="recommendName white-text">${user.userId}</div>
								 <c:set var="oneDayInMillis" value="${3 * 24 * 60 * 60 * 1000}" />
	                            <c:set var="Time" value="${TimeMap[user.userId]}" />
	                            <c:choose>
	                                <c:when test="${Time <= oneDayInMillis}">
	                                     <p class="gray-text">Re:Merge 신규 가입</p>
	                                </c:when>
	                                <c:otherwise>
	                                    <p class="gray-text">회원님을 위한 추천</p>
	                                </c:otherwise>
	                            </c:choose>
							</div>
							<div class="follow-btn" onclick="follow('${user.userId}')">팔로우</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<!-- 회원 추천 팔로우 -->
		<script>
			function follow(toUser) {
				$.ajax({
					url : 'follow.fe',
					type : 'get',
					data : {
						fromUser : "${loginUser.userId}",
						toUser : toUser
					},
					success : function(result) {
						console.log(result);
						if (result > 0) {
							alert('팔로우 성공');
						} else {
							alert('팔로우 실패');
						}
						window.location.reload();//결과 확인 누르면 새로 고침
					},
					error : function() {
						console.log('통신실패');
					}
				});
			}
		</script>
</body>
</html>