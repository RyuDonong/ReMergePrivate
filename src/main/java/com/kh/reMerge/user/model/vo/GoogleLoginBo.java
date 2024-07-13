package com.kh.reMerge.user.model.vo;


import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.kh.reMerge.user.model.service.GoogleLoginApi;


@Component
public class GoogleLoginBo {
	private final static String GOOGLE_CLIENT_ID = "363177318285-ssbc38p1uc9ngg94n28op1qqsh1oiumc.apps.googleusercontent.com";
    private final static String GOOGLE_CLIENT_SECRET = "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";
    private final static String GOOGLE_REDIRECT_URI = "http://localhost:8888/reMerge/google/callback";
    private final static String GOOGLE_SCOPE = "email openid profile";
    private final static String PROFILE_API_URL ="https://www.googleapis.com/oauth2/v2/userinfo";
	private static final String SESSION_STATE="googleSessionState";
	
	// 구글 로그인 기능을 제공하는 API를 호출하여 결과(code와 stae)를 반환하는 메소드
	public String getAuthorizationUrl(HttpSession session) {
		
		// 세션의 유효성 검증을 위한 난수값을 생성
		String state=UUID.randomUUID().toString();
		// 난수값을 세션 속성값으로 저장
		session.setAttribute(SESSION_STATE, state);
		session.setMaxInactiveInterval(60 * 60); 
		//System.out.println("state : "+state);
		
		// 로그인 기능을 요청하기 위한 정보가 저장된 OAuth20Service 객체 생성
		OAuth20Service oauthService=new ServiceBuilder()
				.apiKey(GOOGLE_CLIENT_ID)
				.apiSecret(GOOGLE_CLIENT_SECRET)
				.callback(GOOGLE_REDIRECT_URI)
				.state(state)
				.scope(GOOGLE_SCOPE)
				.build(GoogleLoginApi.instance());
		
		// 인증 URL
		String authorizationUrl = oauthService.getAuthorizationUrl();
		//System.out.println("authorizationUrl : "+authorizationUrl);
		return authorizationUrl;
	}
	
	// 로그인 처리 후 로그인 사용자의 접근 토큰을 발급받는 API를 호출 -> 사용자 접근 토큰을 반환
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException {
		// 세션의 유효성 검증을 위해 세션에 저장된 속성값을 반환받아 저장
		String sessionState=(String)session.getAttribute(SESSION_STATE);
		//System.out.println(StringUtils.pathEquals(sessionState, state));
		
		// 매개변수로 받은 값과 세션에 저장된 값이 다른 경우
		if(!StringUtils.pathEquals(sessionState, state)) {
			return null;
		}
		
		// 사용자 접근 토큰을 발급 받기 위한 정보가 저장된 OAuth20Service 객체 생성
		OAuth20Service oAuth20Service=new ServiceBuilder()
				.apiKey(GOOGLE_CLIENT_ID)
				.apiSecret(GOOGLE_CLIENT_SECRET)
				.callback(GOOGLE_REDIRECT_URI)
				.state(state)
				.scope(GOOGLE_SCOPE)
				.build(GoogleLoginApi.instance());
		
		// 사용자 접근 토큰을 발급하는 API를 요청하여 토큰을 발급받아 저장
		OAuth2AccessToken accessToken=oAuth20Service.getAccessToken(code);
		//System.out.println("accessToken : "+accessToken);
		return accessToken;
	}
	
	// 사용자 접근 토큰을 사용하여 사용자의 프로필을 제공하는 API를 호출
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException{
		OAuth20Service oauthService=new ServiceBuilder()
				.apiKey(GOOGLE_CLIENT_ID)
				.apiSecret(GOOGLE_CLIENT_SECRET)
				.callback(GOOGLE_REDIRECT_URI)
				.scope(GOOGLE_SCOPE)
				.build(GoogleLoginApi.instance());
		
		// 사용자의 프로필을 제공하는 API를 요청하기 위한 객체 생성
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		// 사용자 접속 토큰과 API 요청 객체를 전달하여 로그인 사용의 프로필 요청
		oauthService.signRequest(oauthToken, request);
		// 사용자 프로필을 저장
		Response response = request.send();
		String responseBody = response.getBody();
		
		return responseBody;
	}
}
