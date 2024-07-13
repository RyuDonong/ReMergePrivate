<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

body {
	height: auto;
	margin: 0;
	padding: 0;
	background-color: #fafafa;
	font-family: 'Arial', sans-serif;
}

.outer{width: calc(100% - 250px); margin-left:250px;}

header {
	display: flex;
	height: 100px;

}

.sidebar {
	width: 250px;
	background-color: #FFFFFF;
	border-right: 1px solid #DBDBDB;
	display: flex;
	flex-direction: column;
	align-items: center;
	padding-top: 20px;
}
.logo img {
	width: 120px;
	margin-bottom: 30px;
	margin-right: 120px;
}
.menu {
	width: 100%;
}
.menu ul {
	list-style: none;
	padding: 0;
	margin: 0;
}
.menu ul li {
	width: 100%;
	margin-bottom: 20px;
}
.menu-item {
	display: flex;
	align-items: center;
	padding: 10px 20px;
}
.menu-item a {
	display:block; 
	cursor: pointer;
	font-size: 16px;
	font-weight: 500; 
	width:100%;
	text-decoration: none;
	color: black;
}
.menu-item img {
	width: 24px;
	height: 24px;
	margin-right: 15px;
}
.menu-item:hover {
	background-color: #F0F0F0;
	border-radius: 10px;
}



.searchBox{
	display:none; 
	background-color: #FFFFFF;
    height: 1000px;
    width: 360px;
    position: relative;
    z-index:1001;
}
.searchBox.active{
	display:block;
}
.searchBox .searchBoxTitle {
	font-size:24px; font-size: 24px;
    font-weight: 700;
    padding: 32px 16px 40px;
}
.searchBox .btn {
	position:absolute;
	top:5px; 
	right:5px;
}
.searchBox .searchfollow {
	padding: 0 16px;
}
.searchBox .searchfollow input {
	width: 100%;
    background-color: #efefef;
    line-height: 40px;
    border-radius: 5px;
    outline: none;
    border: none;
}
.searchUserResult {}
.searchUserResult ul {    
	list-style: none;
    padding: 16px;
}
.searchUserResult ul li {
	display: flex;
    gap: 10px;
    margin-top: 16px;
}
.searchUserResult ul li .profileImage {
	width: 44px;
    height: 44px;
    overflow: hidden;
    border-radius: 100%;
}
.searchUserResult ul li .profileImage img{
	widgh: 100%;
	height: 100%;
}
.searchUserResult ul li button {
	background-color: #ffffff;
	border: 0px;
	
}
.searchUserResult ul li p {
    font-size: 14px;
}
.searchUserResult ul li p .userId {
	display:block;
}
.searchUserResult ul li p .memo {
	color:#737373;
}

.badge {
    margin-left: 5px;
    padding: 0.5em;
    border-radius: 50%;
    background-color: red;
    color: white;
    width: 25px;
}
</style>
</head>
<body>
</body>
</html>