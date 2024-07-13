package com.kh.reMerge.user.model.vo;


import java.io.IOException;
import java.util.UUID;
import javax.servlet.http.HttpSession;
import org.springframework.util.StringUtils;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.kh.reMerge.user.model.service.NaverLoginApi;

public class NaverLoginBo { 
	
	private static final String NAVER_CLIENT_ID = "QtBQWMlKTonQr2ENTX3U";
	private static final String NAVER_CLIENT_SECRET = "4RQLDD98le";
	private static final String NAVER_REDIRECT_URI = "http://localhost:8888/reMerge/naver/callback";
	private static final String SESSION_STATE = "neathlo_state";
	private static final String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";

	/* 네이버 아이디로 인증 URL 생성 Method */
	 	public String getAuthorizationUrl(HttpSession session) { /* 세션 유효성 검증을 위하여 난수를 생성 */
	 	System.out.println("여기는 BO");
	 	String state=UUID.randomUUID().toString();
		/* 생성한 난수 값을 session에 저장 */
		session.setAttribute(SESSION_STATE, state); 
		session.setMaxInactiveInterval(60 * 60); 
		System.out.println("세션 : "+state);
		
		/*
		 * Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성
		 */
		
		OAuth20Service oauthService = new ServiceBuilder()
										.apiKey(NAVER_CLIENT_ID)
										.callback(NAVER_REDIRECT_URI)
										.state(state)
										.build(NaverLoginApi.instance());
		
		//앞서 생성한 난수값을인증 URL생성시 사용함
		String naverAuthUrl = oauthService.getAuthorizationUrl();
		
		return naverAuthUrl;
	
	}

	 	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException {
	 		String sessionState=(String)session.getAttribute(SESSION_STATE);
	 		//System.out.println("state : " + state);
	 		//System.out.println("sessionState : " + sessionState);
	 		//System.out.println("비교구문 : "+StringUtils.pathEquals(sessionState, state));
		if (StringUtils.pathEquals(sessionState, state)) {
			
			OAuth20Service oauthService = new ServiceBuilder()
											.apiKey(NAVER_CLIENT_ID)
											.apiSecret(NAVER_CLIENT_SECRET)
											.callback(NAVER_REDIRECT_URI)
											.state(state)
											.build(NaverLoginApi.instance());
			
			/*
			 * Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득
			 */ 
			
			OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			//System.out.println("토큰값 : "+accessToken);
			//System.out.println("oauth : "+oauthService);
			return accessToken;
		}
		return null;
	}

	/*
	 * Access Token을 이용하여 네이버 사용자 프로필 API를 호출
	 */ 
	public String getUserProfile(OAuth2AccessToken accessToken) throws IOException {
		
		OAuth20Service oauthService = new ServiceBuilder()
											.apiKey(NAVER_CLIENT_ID)
											.apiSecret(NAVER_CLIENT_SECRET)
											.callback(NAVER_REDIRECT_URI)
											.build(NaverLoginApi.instance());
		
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		
		oauthService.signRequest(accessToken, request);
		
		Response response = request.send();
		
		return response.getBody();
		
	}
}
