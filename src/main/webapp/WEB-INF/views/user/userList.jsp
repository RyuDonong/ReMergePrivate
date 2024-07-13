<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
    <%@include file="/WEB-INF/views/user/loginHeader.jsp" %>

    <div class="outer">
        <div class="table-container">
            <table class="sel">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Password</th>
                        <th>Email</th>
                        <th>Join Date</th>
                        <th>Profile Path</th>
                        <th>Status</th>
                        <th>Shop Brand Check</th>
                        <th>User Memo</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.userPwd}</td>
                            <td>${user.email}</td>
                            <td>${user.joinDate}</td>
                            <td>${user.profilePath}</td>
                            <td>${user.status}</td>
                            <td>${user.shopBrandChek}</td>
                            <td>${user.userMemo}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</body>
</html>
