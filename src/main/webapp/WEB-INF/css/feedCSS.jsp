<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	height: auto;
	margin: 0;
	padding: 0;
	background-color: #FAFAFA;
	font-family: 'Arial', sans-serif;
}
header {
	display: flex;
	height: 100px;
}
.body {
	flex: 1;
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	align-items: flex-start; /* 맨 위 정렬 */
	padding: 20px;
}
.storySwiper{
	margin-top: -150px;
	position:relative;
	overflow:hidden;
	padding:0 22px;
}
.storys {
/* 	width: 50%;
	display: flex;
	justify-content: center; 
	align-items: flex-start; 
	position: absolute;
	top: 0px; 
	left: 50%; 
	transform: translateX(-50%); 
	padding: 10px;  */
	z-index: 1000; 
	background-color: white;
}
/* .story {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin: 10px;
} */
.storys .swiper-slide {
	text-align: center;
}
.story_img {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	border: 3px solid #F42664;
}
/* 읽었던 스토리에 추가될 css */
.readed {
	border: 3px solid gray;
}
.story span {
	margin-top: 5px;
	font-size: 12px;
	text-align: center;
	display:block;
}




.profile {
	display: flex;
	margin: 10px 0;
	justify-content: flex-end;
	padding-right: 250px;
}
.title .info {
	display: flex;
	flex-direction: column;
}
.title .username {
	font-weight: bold;
	margin-left: 10px;
}
.con_wrap {
	display: flex;
	width: 40%;
	justify-content: center;
	align-items: flex-start;
}
.conA {
	flex: 2;
	margin: 10px;
	justify-content: center;
}
.conA .con {
	width: 100%;
	max-width: 600px;
	margin-bottom: 30px;
	border: 1px solid #DBDBDB;
	border-radius: 3px;
	background-color: #FFFFFF;
}
.title {
	display: flex;
	align-items: center;
	padding: 10px;
}
.title p {
	margin-left: 10px;
	font-size: 16px;
	font-weight: bold;;
}
.title .location {
	font-size: 12px;
	margin-left: 10px;
	color: gray;
	display: inline-block;
}
.con_img {
	width: 100%;
	height: auto;
}
.img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
}
.logos {
	display: flex;
	justify-content: space-between;
	padding: 10px;
}
.content {
	padding: 10px;
}
.content p {
	margin: 5px 0;
}
.content input {
	width: 100%;
	height: 40px;
	border: none;
	border-top: 1px solid #DBDBDB;
	padding: 5px;
	font-size: 14px;
}
.content input:focus {
	outline: none;
}
.body .container {
	position: fixed;
	top: 100px;
	right: 200px;
	width: 400px; /* 원하는 너비로 조정 */
	background-color: white;
	border: 1px solid #DBDBDB;
	border-radius: 10px;
	padding: 20px;
}
.profile-header {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}
.profile-header img {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	margin-right: 15px;
}
.profile-header .profile-info {
	display: flex;
	flex-direction: column;
}
.profile-header .username {
	font-weight: bold;
}
.suggestions-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}
.suggestions-header span {
	color: #8E8E8E;
	font-size: 14px;
}
.suggestions-header a {
	color: #0095F6;
	font-size: 14px;
	text-decoration: none;
}
.suggestion {
	align-items: center;
	justify-content: space-between;
	margin-bottom: 15px;
}
.suggestion img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
}
.suggestion .suggestion-info {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
}
.suggestion .suggestion-info .name {
	font-weight: bold;
	font-size: 14px;
	margin-right: 10px; /* 이름과 버튼 사이 간격 추가 */
}
.follow-btn {
	padding: 5px 15px;
	border: 1px solid #0095F6;
	background-color: white;
	color: #0095F6;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
	margin-left: auto;
}
.follow-btn:hover {
	background-color: #0095F6;
	color: white;
}
<!--
모달-->.modal-content {
	display: flex;
	flex-direction: column;
	width: 90%;
	max-width: 100%;
	border-radius: 10px;
	overflow: hidden;
	border: none;
}
.modal-body {
	padding: 0;
	display: flex;
	flex-direction: column;
	width: 100%;
	height: auto; /* 모달의 높이를 자동으로 조정 */
}
.modal-image {
	flex: 1;
	background-color: #000;
}
.modal-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}
.modal-details {
	flex: 1;
	display: flex;
	flex-direction: column;
	padding: 0;
}
.modal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #DBDBDB;
	padding: 10px 20px;
}
.modal-header img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
}
.modal-header .username {
	font-weight: bold;
	display: block; /* 사용자 이름과 위치를 세로로 배치 */
}
.modal-header .text-muted {
	color: #8E8E8E;
}
.modal-header .close {
	font-size: 20px;
	color: #333;
}
.modal-body-content {
	flex: 1;
	overflow-y: auto;
	padding: 20px;
}
.modal-footer {
	display: flex;
	justify-content: flex-end;
	border-top: 1px solid #DBDBDB;
	padding: 10px 20px;
}
/* 숨겨진 파일 입력 */
.custom-file-label {
	cursor: pointer;
	color: blue; /* 원하는 색상으로 변경 */
	text-decoration: underline;
}
.form-control-file.d-none {
	display: none;
}
/* 이미지 미리보기 */
#thumbnailFeed img {
	width: 100%;
	height: auto;
	object-fit: cover;
}
.like-button, .reply-like-button {
	background: none;
	border: none;
	padding: 0;
	margin: 0;
	cursor: pointer;
	color: #FF5A5F;
}
.like-button:focus, .reply-like-button:focus {
	outline: none;
}
.reply-heart-icon {
	font-size: 16px;
	color: black;
}
.reply-heart-icon.liked {
	color: #FF5A5F;
}
.modal-content .modal-body-content .comment-section {
	margin-top: 5px; /* 댓글 섹션 상단 간격 줄임 */
}
.comment {
	display: flex;
	align-items: center;
	margin-bottom: 5px; /* 댓글 간격 줄임 */
	padding-left: 0; /* 왼쪽 여백을 제거하여 정렬 */
}
.comment img {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	margin-right: 10px;
}
.comment p {
	margin: 0;
	font-size: 14px;
}
.comment .username {
	font-weight: bold;
	margin-right: 5px;
}
.comment-input {
	display: flex;
	align-items: center;
	border-top: 1px solid #DBDBDB;
	padding-top: 5px; /* 댓글 입력 상자 위쪽 간격 줄임 */
}
.comment-input input {
	flex: 1;
	border: none;
	padding: 5px; /* 댓글 입력 상자의 패딩을 줄임 */
	font-size: 14px;
	height: 40px; /* 댓글 입력 상자 높이 설정 */
}
.comment-input input:focus {
	outline: none;
}
.comment-input button {
	background-color: transparent;
	border: none;
	color: #0095F6;
	font-weight: bold;
	cursor: pointer;
}
.thumbnail-container, .form-group, .hashTag {
	padding: 20px;
}
.thumbnail-container img {
	width: 100%;
	height: auto;
	display: block;
}
.btn-primary {
	background-color: #0095F6;
	border-color: #0095F6;
	border-radius: 4px;
	padding: 5px 15px;
	font-weight: 600;
}
.btn-primary:hover {
	background-color: #007BB5;
	border-color: #007BB5;
}
.close {
	font-size: 20px;
}
.close:hover {
	color: #FF5A5F;
}
.modal-lg {
	max-width: 800px;
}
/* 썸네일 스타일 */
.thumbnail-container {
	max-width: 300px;
	margin: auto;
}
.thumbnail {
	width: 100%;
	height: auto;
	border-radius: 10px;
	object-fit: cover;
}
#thumbnailFeed {
	display: none;
}
/* 스토리 미리 보기 칸  */
#thumbnailContainer {
	display: none;
}
.like-button {
	background: none;
	border: none;
	padding: 0;
	margin: 0;
	cursor: pointer;
}
.like-button:focus {
	outline: none;
}
.heart-icon {
	font-size: 30px;
	color: #FF5A5F;
}
/* 댓글 좋아요 버튼 스타일 */
.reply-like-button {
	background: none;
	border: none;
	padding: 0;
	margin-left: 10px;
	cursor: pointer;
}
.reply-like-button:focus {
	outline: none;
}
.reply-heart-icon {
	font-size: 16px;
	color: #black;
	margin-left: auto;
}
.reply-heart-icon.liked {
	color: #FF5A5F;
}
/* 태그 검색시 보여지는 tagDetail View CSS */
.feedBox {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}
.feedBlock {
	height: 22.7vw;
	flex: 0 0 30%;
	box-sizing: border-box;
	margin: 16px;
	border-radius: 5%;
	overflow: hidden;
	position: relative;
}
.feedBlock::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: #000;
	opacity: 0;
}
.feedBlock:hover::before {
	opacity: 0.3;
}
.feedBlock img {
	width: 100%;
	height: 100%;
}
.saveButton {
	display: none;
}
/*회원 추천 리스트*/
.container-list {
	max-width: 600px;
	margin: 10px auto;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
h2 {
	font-size: 24px;
	font-weight: 600;
	color: #333;
	margin-bottom: 20px;
}
.suggestion-list {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 0;
	border-bottom: 1px solid #ddd;
}
.suggestion-info-list {
	display: flex;
	align-items: center;
	flex-grow: 1;
}
.suggestion-info-list img {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	margin-right: 15px;
}
.recommendName {
	font-size: 18px;
	font-weight: 500;
	color: #333;
}
.follow-btn {
	background-color: #3897F0;
	color: #fff;
	border: none;
	padding: 8px 12px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	margin-left: auto; /* 추가: 버튼을 맨 오른쪽으로 이동 */
}
.follow-btn:hover {
	background-color: #347DC6;
}
.gray-text {
    color: gray;
    font-style: italic;
}
.white-text {
    color: right-black;
}
.timeAgo {
    color: #A9A9A9; /* 밝은 회색 */
    font-size: 12px; /* 필요에 따라 조정 */
    margin-left: 10px; /* ID와 시간 사이의 간격 조정 */
}
.swiper-slide {
    /* visibility: hidden; */
}
.swiper-slide-active {
    visibility: visible;
}
.swiper-container {
    position: relative;
    width: 100%;
    height: auto;
}
.swiper-button-next,
.swiper-button-prev {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 27px;
    height: 44px;
    z-index: 10;
    cursor: pointer;
    display: block;
}
.con_img {
    width: 600px;
    height: 600px;
    display: block;
    position: relative;
}
#story_view_img{
	width: 450px;
	height: 700px;
}
</style>
</head>
<body>
</body>
</html>