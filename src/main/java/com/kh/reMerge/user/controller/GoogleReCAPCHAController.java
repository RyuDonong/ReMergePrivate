
package com.kh.reMerge.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.reMerge.user.model.vo.VerifyRecaptcha;


@Controller
@RequestMapping
public class GoogleReCAPCHAController {
	
	@ResponseBody
	@RequestMapping("/VerifyRecaptcha.us")
	public int VerifyRecaptcha(HttpServletRequest request, HttpSession session) {
		// 시크릿 키를 리캡챠를 받아올수 있는 Class에 보내서 그곳에서 값을 출력한다
		//System.out.println("request : "+request);
		//System.out.println("request.getParameter(\"recaptcha\") : "+request.getParameter("recaptcha"));
		//System.out.println("컨트롤러");
		
		//시크릿키 세팅
		VerifyRecaptcha.setSecretKey("6LcfpgEqAAAAAF6XXS02CSdy3j3ZrU80PPKpCPr2");
		//System.out.println("시크릿키 세팅완료");
		
		//recaptcha값을 가져와 gRecaptchaResponse으로 선언
		String gRecaptchaResponse = request.getParameter("recaptcha");
		//System.out.println("gRecaptchaResponse : "+gRecaptchaResponse);
		
		try {
			//VerifyRecaptcha클래스에서 verify라는 boolean메소드호출 gRecaptchaResponse값을 가져간다
			
			
			if(VerifyRecaptcha.verify(gRecaptchaResponse)) { //true일 경우
				//session.setAttribute("alertMsg", "리캡쳐 승인 로그인가능");
				return 0; // 성공
				
				
			}else  //false일 경우
				//session.setAttribute("alertMsg", "리캡쳐 실패 로그인 재시도");
				return 1; // 실패
			
			
		} catch (Exception e) {
			e.printStackTrace();
			//session.setAttribute("alertMsg", "리캡쳐 컨트롤러 에러");
			//에러날 경우
			return -1; //에러
		}
	}
}
	