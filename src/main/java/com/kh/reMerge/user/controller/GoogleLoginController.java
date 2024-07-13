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
import com.kh.reMerge.user.model.vo.GoogleLoginBo;
import com.kh.reMerge.user.model.vo.User;
import com.kh.reMerge.user.model.vo.UserinfoAuthAPI;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/google")
@RequiredArgsConstructor
public class GoogleLoginController {
	private final GoogleLoginBo googleLoginBo;
	private final UserService UserService;

	@RequestMapping("/login")
	public String googlelogin(HttpSession session) throws UnsupportedEncodingException {
		String googleAuthUrl = googleLoginBo.getAuthorizationUrl(session);
		return "redirect:" + googleAuthUrl;
	}

	@RequestMapping("/callback")
	public String googlelogin(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException/*, ExistsUserinfoException, UserinfoNotFoundException*/, ParseException {
		//System.out.println("여기는 콜백");
		OAuth2AccessToken accessToken = googleLoginBo.getAccessToken(session, code, state);

		String apiResult = googleLoginBo.getUserProfile(accessToken);
		//System.out.println("apiResult : "+apiResult);
		JSONParser parser = new JSONParser();
		Object object = parser.parse(apiResult);
		JSONObject responseObject = (JSONObject) object;

		// 사용자 json 데이터를 각각 id, email 등 각각 나눠서 저장
		String id = (String) responseObject.get("id");
		String email = (String) responseObject.get("email");
		String joinDate = (String) responseObject.get("joinDate");
		String profilePath = (String) responseObject.get("profilePath");
		String status = (String) responseObject.get("status");
		String shopBrandChek = (String) responseObject.get("shopBrandChek");
		String userMemo = (String) responseObject.get("userMemo");
		
		//String name = (String) responseObject.get("name");

		
		UserinfoAuthAPI UserAPI = new UserinfoAuthAPI();
		UserAPI.setId("google_" + id);


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
		//System.out.println("User : "+u);
		//UserService.addUserinfoAuth();
		String APIcheckId = loginUser.getUserId();
		int result = UserService.checkId(APIcheckId);
		
		System.out.println(loginUser);
		//System.out.println("result : "+result);
		if(result>0) { //중복아이디 있음
			
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "구글에 중복된 아이디가 있습니다!! = 바로 로그인");
			return "redirect:/feed.fe";
		}else { //중복아이디 없음
			UserService.insertUser(loginUser);
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "구글을 이용한 이메일아이디로 회원가입 완료!!");
		return "redirect:/feed.fe";
		}
	}
}