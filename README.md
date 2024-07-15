# ReMergePrivate
ReMerge 는 기록을 뜻하는 Record와 결합하다라는 뜻을 가진 Merge를 합쳐 기록을 합친다라는 뜻을 가진 SNS 페이지 입니다.

<img width="600" alt="스크린샷 2024-07-06 오후 4 19 46" src="https://github.com/user-attachments/assets/66ae1e22-bc5c-4839-ab4e-41cdb29210b0">

# Intro

국비지원 자바 풀스텍 개발자 교육과정에서 파이널 프로젝트로 4주간 진행한 프로젝트입니다.

해당 프로젝트는 SpringLegacy로 프로그램 되었고, Ajax, FullCalendar, lombok등 다른 라이브러리들과 Kakao Map Api, Daum Post Code 등 무료로 제공되는 Api도 사용해보며 

해당하는 라이브러리, Api의 사용방법을 공식문서를 통해 터특하고 연구, Customize하는 좋은 기회가 되었습니다.

그리고, 해당 프로젝트는 MVC패턴을 사용하여 MVC패턴에 대해 이해하는데 도움이 많이 되었습니다.

지금 보고계시는 이 Repository는 파이널 프로젝트 기간 내에 제가 작성한 부분만 정리하여 보이드리고, 업데이트 될때마다 수정, 정리하여 계속 개발될 에정입니다.

# Project
- 제작기간
2024.06.17 ~ 2024.07.17

- Environment

  운영체제	: Window, OS

  사용언어	: Front - JavaScript, jQuery, HTML, CSS, Ajax
          : Back - Java
  
  FrameWork/Library	: SpringLegacy, Mybatis /ojdbc, cos, jstl, fullcalendar, lombok, Ajax.. 

  DB	: Oracle / SQL Developer

  Tool	: sts3, Visual Studio Code  

  Collaboration	: GitHub

# View

### 공유 캘린더 
<img width="1707" alt="스크린샷 2024-07-13 오후 3 14 51" src="https://github.com/user-attachments/assets/c0c09933-5a91-43ac-a066-a82fc88a3223">
<img width="1691" alt="스크린샷 2024-07-15 오후 3 41 42" src="https://github.com/user-attachments/assets/870af33e-82b2-426e-9943-3326339cdef7">
<img width="1710" alt="스크린샷 2024-07-13 오후 3 16 10" src="https://github.com/user-attachments/assets/a5b32a08-824e-4e45-a1e1-e6c2b0ebf7c2">

#### 공유캘린더 나의 일정

FullCalendar JavaScript 라이브러리를 사용하여 캘린더를 구현하고 사용자가 입력한 일정을 조회하고, 

날짜를 클릭시에 새로운 일정 입력 모달창이 나오며 입력된 정보들을 DB에 저장합니다.

저장된 일정클릭시 내가 작성한 일정의 경우 수정, 삭제가 가능하고 위치를 입력했다면 Kakao Map Api로써 지도를 보여줍니다.

***

<img width="1710" alt="스크린샷 2024-07-13 오후 3 15 42" src="https://github.com/user-attachments/assets/95fb2db9-4c2b-4c2f-8681-d4d2c1a24146">
<img width="1710" alt="스크린샷 2024-07-13 오후 3 16 26" src="https://github.com/user-attachments/assets/83337000-b343-4480-b376-83225614b701">

#### 공유캘린더 팔로우된 사용자 일정

나의 일정 페이지에서 우측 상단 팔로우리스트에서 팔로우된 회원들중 보고싶은 팔로워를 클릭후 캘린더 보기 클릭시 선택된 사용자 일정 조회

일정 클릭시 상세 일정 조회

***

### 스토리(24시간후 자동으로 다른사람에게 보이지 않는 게시글)
<img width="1706" alt="스크린샷 2024-07-13 오후 3 20 18" src="https://github.com/user-attachments/assets/013c1c40-941b-40e2-aaf0-b26420955c86">
<img width="1708" alt="스크린샷 2024-07-13 오후 3 20 31" src="https://github.com/user-attachments/assets/c4d40b11-0a3a-4dc2-8b42-04c49ec630fd">


#### 메인화면 상단 스토리 게시글
해당 게시글은 팔로우된 사용자중 24시간 내에 작성한 게시글만 조회(사용자별 하나씩으로 보여주고 해당 사용자 클릭시 next버튼으로 보여주기)



