package com.kh.reMerge.feed.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.reMerge.feed.model.service.StoryService;
import com.kh.reMerge.feed.model.vo.History;
import com.kh.reMerge.feed.model.vo.Story;

@Controller
public class StoryController {
	
	@Autowired
	private StoryService storyService;

	//스토리 추가하기
	@PostMapping("insertStory.fe")
	public String insertStory(Story story,MultipartFile storyFile,HttpSession session) {
		
		//스토리 기능은 사진이 필수 이기에 사진 유무는 처리 하지 않음	
		//만들어둔 파일 업로드 처리 메소드 사용
		String changeName = saveFile(storyFile,session);
		
		story.setOriginName(storyFile.getOriginalFilename());
		story.setChangeName("resources/uploadFiles/"+changeName);
		//타이머 작동을 위해 storyNo 미리 뽑아오기
		int sequence = storyService.selectSequnece();
		story.setStoryNo(sequence);//조회 해온 시퀀스 넣어주기
		
		int result = storyService.insertStory(story);//필요한 정보 넣어주었으니 실행 시켜 결과값 받기
		
		if(result>0) {//입력 됬다면 
//			Thread updateThread = new Thread() {
//				public void run() {
//					try {
//						Thread.sleep(10*1000);//10초 동안 동작 안하기
////						Thread.sleep(24*60*60*1000);//24시간 동안 동작 안하기
//					} catch (InterruptedException e) {
//						// TODO Auto-generated catch block
//						e.printStackTrace();
//					}
//					int result = storyService.updateStoryStatus(story);
//					System.out.println("Thread 실행 하여 N으로 수정 결과 "+result);
//				}
//			};
//			updateThread.setDaemon(true);//메인쓰레드가 종료되면 종료될수있도록 종속 시키기
//			updateThread.start();
			session.setAttribute("alertMsg", "성공적으로 등록되었습니다.");
			return "redirect:feed.fe";
		}else {
			session.setAttribute("alertMsg", "등록되지 않았습니다. 관리자에게 문의하세요.");
			return "redirect:feed.fe";
		}
	}
	
	//피드페이지에서 스토리 조회하기
	@ResponseBody
	@PostMapping(value="selectStory.fe",produces="application/json;charset=UTF-8")
	public HashMap<String, Object> selectStory(String userId){
		
		ArrayList<Story> storyList = storyService.selectStory(userId);
		ArrayList<History> historyList = storyService.selectHistory(userId);
		HashMap<String, Object> map = new HashMap<>();
		map.put("story", storyList);
		map.put("history",historyList);
		
		return map;
	}
	
	//스토리 시청 기록 넣기
	@ResponseBody
	@PostMapping(value="insertHistory.fe",produces="application/json;charset=UTF-8")
	public int insertHistory(History history) {
		boolean duplCheck = false;
		ArrayList<History> list = storyService.selectHistory(history.getUserId());//아이디로 시청기록 조회해와서
		for(History h : list) {
			if(h.getStoryNo()==history.getStoryNo()) {//시청 기록 중복 제거
				duplCheck=true;
			}
		}
		if(!duplCheck) {//중복되지 않았다면 
//			Thread historyThread = new Thread() {
//				public void run() {
//					try {
//						Thread.sleep(10*1000);//10초 동안 동작 안하기
//					    //Thread.sleep(24*60*60*1000);//24시간 동안 동작 안하기
//					} catch (InterruptedException e) {
//						// TODO Auto-generated catch block
//						e.printStackTrace();
//					}
//					int result = storyService.deleteHistory(history);
//					System.out.println("Thread 실행 하여 history 삭제 결과 "+result);
//				}
//			};
//			historyThread.setDaemon(true);//메인쓰레드가 종료되면 종료될수있도록 종속 시키기
//			historyThread.start();
			
			return storyService.insertHistory(history);
		}
		return 0;//중복됬어도 사용자에게 알려줄 정보가 없음
	}
	
	//시청 기록 조회해오기
	@ResponseBody
	@PostMapping(value="selectHistory.fe",produces="application/json;charset=UTF-8")
	public ArrayList<History> selectHistory(String userId){
		
		return storyService.selectHistory(userId);
	}
	
	
	//파일 업로드 처리 메소드 (파일 이름 바꿔주기 모듈화)
	public String saveFile(MultipartFile upfile,HttpSession session) {
			//파일명 수정작업하기
			//1.원본파일명 추출
			String originName = upfile.getOriginalFilename();
			//2.시간형식 문자열로 만들기
			//20240527162730
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			//3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기
			String ext = originName.substring(originName.lastIndexOf("."));
			//4.랜덤값 5자리 뽑기
			int ranNum = (int)(Math.random()*90000+10000);
			//5.하나로 합쳐주기
			String changeName = currentTime+ranNum+ext;
			//6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
			try {
			//7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
			upfile.transferTo(new File(savePath+changeName));
			} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			}
			return changeName;
		}
	
	
	
}
