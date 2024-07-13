package com.kh.reMerge.user.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.reMerge.user.model.service.UserService;
import com.kh.reMerge.user.model.vo.NaverLoginBo;
import com.kh.reMerge.user.model.vo.User;
import com.kh.reMerge.user.model.vo.UserinfoAuthAPI;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/naver")
@RequiredArgsConstructor
class NaverController {
	private final NaverLoginBo naverLoginBO;
	private final UserService UserService;
	
	@RequestMapping("/login")
	public String login(HttpSession session) throws UnsupportedEncodingException{
		System.out.println("여기는 컨트롤러");
		String naverAuthUrl=naverLoginBO.getAuthorizationUrl(session);
		 
		 System.out.println("네이버:" + naverAuthUrl);
		 return "redirect:" +naverAuthUrl;
		 
		 }

	@RequestMapping("/callback")
	public String callback(@RequestParam(required = false) String code
			, @RequestParam(required = false) String error
			, @RequestParam String state
			, HttpSession session) throws IOException, ParseException{

		//System.out.println("callback ");
		//System.out.println("callback에서 : "+state);
		OAuth2AccessToken accessToken = naverLoginBO.getAccessToken(session, code, state);
		//System.out.println(oauthToken);

		String apiResult = naverLoginBO.getUserProfile(accessToken);

		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		//System.out.println(jsonObj);

		JSONObject responseobj = (JSONObject) jsonObj.get("response");
		String id = (String) responseobj.get("id");
		String email = (String) responseobj.get("email");
		String joinDate = (String) responseobj.get("joinDate");
		String profilePath = (String) responseobj.get("profilePath");
		String status = (String) responseobj.get("status");
		String shopBrandChek = (String) responseobj.get("shopBrandChek");
		String userMemo = (String) responseobj.get("userMemo");
		
		
		UserinfoAuthAPI UserAPI = new UserinfoAuthAPI();
		UserAPI.setId("naver_" + id);
		
		List<UserinfoAuthAPI> authList = new ArrayList<UserinfoAuthAPI>();
		authList.add(UserAPI);

		User loginUser = new User();
		loginUser.setUserId(email);
		loginUser.setUserPwd(UUID.randomUUID().toString());
		//userinfo.setNickname(name);
		loginUser.setEmail(email);
		loginUser.getJoinDate();
		loginUser.setProfilePath(null);
		loginUser.setStatus(null);
		loginUser.setShopBrandChek(null);
		loginUser.setUserMemo(null);
		System.out.println("User : "+loginUser);
		//UserService.addUserinfoAuth();
		String APIcheckId = loginUser.getUserId();
		int result = UserService.checkId(APIcheckId);
		
		// 여기부턴 spring-security 적용 관련입니다.
		// 네이버 로그인 사용자 정보를 사용하여 UserDetails 객체(로그인 사용자)를 생성하여 저장
		//System.out.println("result : "+result);
		if(result>0) { //중복아이디 있음
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "네이버에 중복된 아이디가 있습니다!! = 바로 로그인");
			return "redirect:/feed.fe";
		}else { //중복아이디 없음
			UserService.insertUser(loginUser);
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "네이버를 이용한 이메일아이디로 회원가입 완료!!");
		return "redirect:/feed.fe";
		}
	} 
}