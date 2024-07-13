<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.followListTitle{
	background-color: black;
	text-align: center;
}
.followListTitle h1{
	color: white;
}
.followListContent {}
.followListContent ul {    
	list-style: none;
    padding: 16px;
}
.followListContent ul li {
	display: flex;
    gap: 10px;
    margin-top: 16px;
}
.followListContent ul li .profileImage {
	width: 44px;
    height: 44px;
    overflow: hidden;
    border-radius: 100%;
}
.followListContent ul li .profileImage img{
	width: 100%;
	height: 100%;
}
.followListContent ul li p {
    font-size: 14px;
}
.followListContent ul li p .userId {
	display:block;
}
.followListContent ul li p .memo {
	color:##737373;
}
#searchFollowResult{
	border: 1px solid black;
}
</style>
</head>
<body>

</body>
</html>