package com.kh.reMerge.user.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kh.reMerge.user.model.service.MyPageService;
import com.kh.reMerge.user.model.service.UserService;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

@Controller
public class MyPageController {
	
	@Autowired
	private MyPageService mypageService;
	
	@Autowired
	private UserService userService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;



//마이페이지로 이동
	@RequestMapping("myPage.us")
	public String myPage(String userId, HttpSession session) {

		boolean followFlag = false;// 팔로우 되어있는지 확인하기 위한 초기화
		String myId = ((User) session.getAttribute("loginUser")).getUserId();// 로그인된 유저 아이디 추출
		User u = userService.selectUser(userId);// 선택된 유저 정보 조회
		FollowList followList = new FollowList(userId, myId);// 팔로우 정보 조회하기 위해 담기
		int result = userService.selectFollow(followList);// 팔로우 되어있는지 확인하기 위한 조회
		if (result > 0) {// 팔로우 되어 있다면 true
			followFlag = true;
			
		}
		System.out.println("마이페이지에서 찍힌 유저:"+u);
		session.setAttribute("user", u);
		session.setAttribute("followFlag", followFlag);

		return "myPage/myPage";
	}

	// 프로필 편집 페이지로 이동
	@RequestMapping("updatePage.us")
	public String updatePage() {
		

		return "myPage/updatePage";
	}
	
	//비밀번호 변경
	@PostMapping("updatePwd.us")
	public String updatePwd(User u, Model model,String updatePwd, HttpSession session) {
		String bcrPwd = bcryptPasswordEncoder.encode(updatePwd);
		u.setUserPwd(bcrPwd);
		int result = mypageService.updatePwd(u);
		
		if(result>0) {
			User updateUser = userService.loginUser(u);
			session.setAttribute("loginUser", updateUser);
			session.setAttribute("alertMsg", "비밀번호 변경 성공");
			
		}else {
			model.addAttribute("alertMsg","비밀번호 변경 실패");
		}
		
		return "user/mainLogin";
		
	}
	//프로필 사진 제외한 정보 수정
	@RequestMapping("update.us")
	public String updateUser(User u, Model model, HttpSession session) {
		
		User loginUser = (User) session.getAttribute("loginUser");
		
		 if (loginUser != null) {
		        u.setProfileOriginName(loginUser.getProfileOriginName());
		        u.setProfileChangeName(loginUser.getProfileChangeName());
		    }


		int result = mypageService.updateUser(u);
		if (result > 0) {
			
			User updateUs = userService.loginUser(u);
			session.setAttribute("loginUser", updateUs);
			session.setAttribute("alertMsg", "정보 수정 성공");
			return "myPage/myPage";
		} else {
			model.addAttribute("alertMsg", "정보 수정 실패");
			return "myPage/updatePage";
		}

	}
	//프로필 사진 정보 수정
		@RequestMapping("updateProfile.us")
		public String updateProfile(User u,HttpSession session, MultipartFile upfile) {
			String defaultProfile = "";
			
			if (!upfile.getOriginalFilename().equals("")) {
				if (u.getProfileOriginName() != null) { // 원래 파일이 비어있지 않은 경우
	
					defaultProfile = u.getProfileChangeName(); // 프로필 경로로 설정
				} else {
					String profileChangePath = saveFile(upfile, session);
					System.out.println("profileChangePath : "+profileChangePath);
					// 새 사진 등록
					u.setProfileOriginName(upfile.getOriginalFilename());
					u.setProfileChangeName("resources/profile/" + profileChangePath);
	
				}
			}
			System.out.println("프로필 변경에서 찍은 유저 :"+u);
	
				int result = mypageService.updateProfile(u);
				System.out.println(result);
				if (result > 0) {
					User updateProfile = userService.loginUser(u);
					session.setAttribute("loginUser", updateProfile);
					session.setAttribute("alertMsg", "사진 수정 성공");
					
					return "redirect:myPage.us?userId="+updateProfile.getUserId();
				} else {
					session.setAttribute("alertMsg", "사진 수정 실패");
					return "myPage/updatePage";
				
			}
			
		}

		//파일 업로드 처리 메소드(재활용)
		public String saveFile(MultipartFile upfile
							  ,HttpSession session) {
			
			//파일명 수정작업하기 
			//1.원본파일명 추출
			String profileOriginName = upfile.getOriginalFilename();
			
			//2.시간형식 문자열로 만들기 
			//20240527162730
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			//3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기 
			String ext = profileOriginName.substring(profileOriginName.lastIndexOf("."));
			
			//4.랜덤값 5자리 뽑기 
			int ranNum = (int)(Math.random()*90000+10000);
			
			//5.하나로 합쳐주기 
			String profileChangePath = currentTime+ranNum+ext;
			
			//6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
			String savePath = session.getServletContext().getRealPath("/resources/profile/");
			
			try {
				//7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
				upfile.transferTo(new File(savePath+profileChangePath));
				
			} catch (IllegalStateException | IOException e) {
				
				e.printStackTrace();
			}
			
			return profileChangePath;
			
			
		}
		
		//회원탈퇴 메소드
		@RequestMapping("delete.us")
		public String deleteMember(String userPwd
								  ,HttpSession session
								  ,Model model) {
			//사용자의 아이디를 가지고 데이터베이스에서 해당 정보를 조회해온다(암호문인 비밀번호)
			//넘어온 평문과 조회한 암호문(비밀번호)를 비교한뒤 일치하면 회원탈퇴 시키기 
			
//			System.out.println("평문 : "+userPwd);
//			System.out.println("로그인 비밀번호 : "+((Member)session.getAttribute("loginUser")).getUserPwd());
			//로그인했을때 데이터베이스에 있는 암호문을 가지고 왔으니 
			//해당 암호문과 넘겨진 평문 matches() 메소드로 비교하여 처리하기 
			
			//로그인 정보의 비밀번호 변수처리
			User loginUser = ((User)session.getAttribute("loginUser"));
			String encPwd = loginUser.getUserPwd();
			String userId = loginUser.getUserId();
			
			//암호문을 복호화 하였을때 평문과 일치하다면(제대로 입력한 경우) 
			if(bcryptPasswordEncoder.matches(userPwd, encPwd)) {
				//탈퇴처리 
				int result = mypageService.deleteUser(userId);
				
				//탈퇴 성공시 - session에 있는 로그인정보 삭제 후 메인페이지로 이동 
				if(result>0) {
					session.removeAttribute("loginUser"); //로그인 정보 삭제
					session.setAttribute("alertMsg", "회원탈퇴가 완료되었습니다.");
					return "redirect:/";
				}else {
					//탈퇴 실패시 - 에러페이지로 이동 
					model.addAttribute("errorMsg","회원 탈퇴 실패");
					return "myPage/myPage";
				}
				
			}else {//비밀번호를 잘못 입력한 경우
				session.setAttribute("alertMsg", "비밀번호 입력 오류!");
				return "myPage/myPage";
			}
		}
}