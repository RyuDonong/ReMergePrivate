package com.kh.reMerge.user.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.reMerge.user.model.service.UserService;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.SearchHistory;
import com.kh.reMerge.user.model.vo.User;
@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender mailSenderNaver;;
	private int mailCheckNum = 0;
	
	private int loginCount = 0;
	
	@RequestMapping("login.us")
	public String loginUser(User u, HttpSession session) {
		
		User loginUser = userService.loginUser(u);
		//System.out.println(u.getUserPwd());
		//System.out.println(loginUser.getUserPwd());
		if (loginUser == null || !bcryptPasswordEncoder.matches(u.getUserPwd(), loginUser.getUserPwd())) {
			loginCount+=1;
			session.setAttribute("loginCount", loginCount);
			//System.out.println(loginCount);
			if(loginCount>=3) {
				session.setAttribute("alertMsg", "로그인 3회 이상 실패 하셨기 때문에 로봇이 아닙니다를 체크해주세요!");
				return "user/mainLogin";
			}else {
				session.setAttribute("alertMsg", "로그인 실패!");
				return"user/mainLogin";
			}
		} else {
			loginCount =0;
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인 성공!");
			session.setAttribute("loginCount", loginCount);
			//System.out.println(loginCount);
			return "redirect:/feed.fe";
		}
		
		
		
	}
	
	
	
	@RequestMapping("logout.us")
	public String logoutMember(HttpSession session) {
		loginCount =0;
		session.setAttribute("loginCount", loginCount);
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	@RequestMapping("insertEnrollForm.us")
	public String memberEnrollForm() {
		//System.out.println("왔나");
		return "user/userEnrollForm";
	}
	
	@RequestMapping("forFindUser.us")
	public String forFindUser() {
		//System.out.println("왔나");
		return "user/findUser";
	}
	
	@ResponseBody
	@RequestMapping("findId.us")
	public String findId(String idForFindEmail, HttpSession session) {
		
		String findId = userService.findId(idForFindEmail);
		//System.out.println(findId);
		return findId;
	}
	
	@PostMapping("insert.us")
	public String insertUser(User u, HttpSession session) {
		String bcrPwd = bcryptPasswordEncoder.encode(u.getUserPwd());
		u.setUserPwd(bcrPwd);
		int result = userService.insertUser(u);
		
		if (result > 0) {
			session.setAttribute("alertMsg", "회원 가입 성공!!");
			return "user/mainLogin";
		} else {
			session.setAttribute("alertMsg", "회원 가입 실패!!");
			return "user/userEnrollForm";
		}
	}
	
		@ResponseBody
		@RequestMapping("checkId.us")
		public String checkId(String checkId,HttpSession session) {
			
			int count = userService.checkId(checkId);
			
			
			String result = "";
			
			if(count>0) {
				result = "NNNNN";
				
			}else {
				result = "NNNNY";
			}
			//System.out.println(result);
			return result;
		}
		
		@ResponseBody
		@RequestMapping("checkPwandChange.us")
		public String checkId(String changePwd,String cheChangePwd,String userId,HttpSession session) {
			//System.out.println(changePwd);
			//System.out.println(cheChangePwd);
			
			String result ="";
			if(!changePwd.equals(cheChangePwd)) {//같지않다면
				//System.out.println(changePwd.equals(cheChangePwd));
				
				result="NNNNN1";
				return result;
			}else {//이메일 인증으로 인해 버튼이 활성화 됬음으로 다른 절차는 필요하지않음
				//System.out.println(changePwd.equals(cheChangePwd));
				User u = new User();
				u.setUserId(userId);
				String bcrPwd = bcryptPasswordEncoder.encode(changePwd);
				u.setUserPwd(bcrPwd);
				
				int updateCheck = userService.updateChangePwd(u);
				
				if(updateCheck>0) {
					result = "NNNNY";
					
				}else {
					result = "NNNNN";
				}
				//System.out.println(result);
				return result;
			}
			
		}
		
		
		@ResponseBody
		@RequestMapping("emailCheck.us")
		private String checkEmail(String email) {
			String result = "";
			
			int count = userService.checkEmail(email);
			
			if(count>0) {
				result = "NNNNN";
			}else {
				result = "NNNNY";
			}
		
			return result;
		}
		
		@ResponseBody
		@RequestMapping("checkPw.us")
		public String checkPw(String checkPw,String checkpwChk) {
			String resultPw = "";
			
			if(checkPw.equals(checkpwChk) ) {
				resultPw = "NNNNY";
			}else {
				resultPw = "NNNNN";
			}
			//System.out.println(resultPw);
			return resultPw;
		}

		// 메시지용 - 중구
		@RequestMapping("userList.us")
		public String userList(Model model) {
		    ArrayList<User> userList = userService.getAllUsers();
		    model.addAttribute("userList", userList);
		   
		    for (User user : userList) {
		        System.out.println("유저비동기"+user);
		    }
		    return "user/userList";
		}
		@ResponseBody
		@RequestMapping("userListAjax.us")
		public ArrayList<User> getUserListAjax() {
		    return userService.getAllUsers();
		}
		
		//유저 검색
		@ResponseBody
		@GetMapping("searchUser.us")
		public ArrayList<User> searchUser(String searchStr){
			
			return userService.searchUser(searchStr);
		}
		
	//팔로우 신청
	@ResponseBody
	@PostMapping(value="insertFollow.us")
	public int insertFollow(FollowList followList) {
		
		return userService.insertFollow(followList);
	}
	
	//언팔로우
	@ResponseBody
	@PostMapping("deleteFollow.us")
	public int deleteFollow(FollowList followList) {
		
		return userService.deleteFollow(followList);
	}
	
	
	//이메일 인증 메일 보내기
	@ResponseBody
	@RequestMapping("accEmail.us")
	public Map  accEmail(String pwForEmail,String userId, HttpSession session, Model model) {
		
		Map map = new HashMap();
		User u = new User();
		u.setEmail(pwForEmail);
		u.setUserId(userId);
		
		int result =userService.accEmail(u);
		
		
		if(result >0) { //아이디 및 이메일이 일치 할때
			
			//session.removeAttribute("numAcc");
			Random r = new Random();
	        int numE = r.nextInt(9999);
	        //session.setAttribute("numAcc", num);
	        //model.addAttribute("numAcc", num);
	       
	        mailCheckNum = numE;
	       
			StringBuilder sb = new StringBuilder();
			
			
			String setFrom = "skwjdalssk@naver.com";//발신자 이메일
			String tomail = pwForEmail;//수신자 이메일
			String title = "[Re:merge] 비밀번호 변경 인증 이메일입니다.";
			sb.append(String.format("안녕하세요 %s님\n", userId));
			sb.append(String.format("Re:merge 비밀번호 찾기(변경) 인증번호는 %d입니다.", numE));
			String content = sb.toString();
			
			try {
				//보낼 이메일 주소 선언후 작성
				MimeMessage mm = mailSenderNaver.createMimeMessage();
				MimeMessageHelper mh = new MimeMessageHelper(mm,true,"UTF-8");
				mh.setFrom(setFrom);
				mh.setTo(tomail);
				mh.setSubject(title);
				mh.setText(content);
				
				mailSenderNaver.send(mm);
				
			} catch (MessagingException e) {
				//e.printStackTrace();
				//System.out.println(e.getMessage());
				
			}
			map.put("status", true);
			map.put("num", numE);
			map.put("m_idx",userId );
			return map;
			
		}else { //아이디 및 이메일이 일치 하지 않았을때
			//session.removeAttribute("numAcc");
			return map;
		}
	}
	
	@ResponseBody
	@RequestMapping("numAcc.us")
	public int numAccCheck(int numAccInput, HttpSession session) {
		
		int result = 0;
		
		if(mailCheckNum==numAccInput) { //같다면
			result = 1;
			return result;
		}else { //틀리면 그대로 0
			return result;
		}
		
	}
	
	//검색 기록 넣기 
	@ResponseBody
	@PostMapping("insertSearchHistory.us")
	public int insertSearchHistory(SearchHistory searchHistory) {

		return userService.insertSearchHistory(searchHistory);
	}
	
	//검색 기록 조회
	@ResponseBody
	@PostMapping("selectSearchHistory.us")
	public ArrayList<User> selectSearchHistory(String userId){

		return userService.selectSearchHistory(userId);
	}
	
	//검색 기록 삭제
	@ResponseBody
	@PostMapping("deleteSearchHistory.us")
	public int deleteSearchHistory(SearchHistory searchHistory) {
		
		return userService.deleteSearchHistory(searchHistory);
	}
	
	
	
}