<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.festivalTitle{
		background-color: black;
		color: white;
		text-align: center;
		font-size: 30px;
		padding: 15px 0;
		margin-bottom: 20px;
		border-radius: 5px;
	}
	.festivalContent{
		padding-top: 20px;  
	}
	.festivalBox{
		list-style: none;
		padding: 0;
		display: flex;
		flex-wrap: wrap;
		gap: 10px;
	}
	.festivalBox li{
		background-color: white;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		flex: 1 1 calc(33.333% - 20px);
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		transition: background-color 0.3s ease;
	}
	
	.festivalBox li:hover{
		cursor:pointer;
		background-color: gray;
	}
	.festivalBox div {
		margin-bottom: 10px;
	}
	.festivalBox strong {
		display: block;
		font-size: 18px;
		margin-bottom: 5px;
	}
	.festivalBox span {
		display: block;
		font-size: 14px;
		color: #666;
	}
	.countRecommend {
		color: black;
		font-weight: bold;
	}
	.festivalBox button {
		background-color: black;
		color: white;
		border: none;
		padding: 5px 10px;
		border-radius: 5px;
		cursor: pointer;
		transition: background-color 0.3s ease;
	}
	.festivalBox button:hover {
		background-color: #ccc;
	}
	.festivalBox button.deRecommend {
		background-color: black;
	}
	.festivalBox button.deRecommend:hover {
		background-color: #ccc;
	}
	.buttons {
		text-align: center;
		margin: 20px 0;
	}
	.buttons button {
		background-color: black;
		color: white;
		border: none;
		padding: 10px 20px;
		font-size: 16px;
		border-radius: 5px;
		cursor: pointer;
		margin: 0 10px;
		transition: background-color 0.3s;
	}
	.buttons button:disabled {
		background-color: #ccc;
		cursor: not-allowed;
	}
	.buttons button:hover:not(:disabled) {
		background-color: #333;
	}
	/* shareModal css */
	.modal-content {
		border-radius: 10px;
	}
	.modal-header {
		border-bottom: none;
		position: relative;
		background-color: black;
		color: white;
	}
	.modal-title {
		font-size: 20px;
		font-weight: 700;
	}
	.modal-header .close {
		position: absolute;
		right: 15px;
		top: 15px;
		font-size: 24px;
	}
	.modal-body {
		display: flex;
		justify-content: space-around;
		align-items: center;
	}
	.modal-body div {
		text-align: center;
	}
	.modal-body img {
		width: 50px;
		height: 50px;
		margin-bottom: 10px;
	}
	.modal-body label {
		display: block;
		font-size: 14px;
		font-weight: 500;
	}
</style>
</head>
<body>

</body>
</html>