package com.kh.reMerge.message.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.reMerge.message.model.service.MessageService;
import com.kh.reMerge.message.model.vo.Message;
import com.kh.reMerge.user.model.vo.User;

@Controller
@RequestMapping("/message")
public class MessageController {
    @Autowired
    private MessageService messageService;

    @GetMapping("/dm")
    public String basic(Model model) {
        return "chat/chat";
    }
    
    @GetMapping("/getChatRoom")
    @ResponseBody
    public int getChatRoom(HttpSession session, @RequestParam("receiveId") String receiveId) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            throw new IllegalArgumentException("로그인 정보가 없습니다.");
        }

        String sendId = loginUser.getUserId();
        
        // 메시지가 있는지 확인하여 채팅방 번호를 받아옴
        int messageRoomNo = messageService.getMessageRoomNo(sendId, receiveId);
        System.out.println("기존 채팅방 번호 : " + messageRoomNo);

        // 채팅방이 없으면 새로 생성
        if (messageRoomNo == 0) {
            messageRoomNo = messageService.createChatRoom(sendId, receiveId);
            System.out.println("새로운 채팅방 번호 : " + messageRoomNo);
        }
        return messageRoomNo;
    }

    @GetMapping("/getChatHistory")
    @ResponseBody
    public ResponseEntity<List<Message>> getChatHistory(@RequestParam("messageRoomNo") int messageRoomNo) {
        List<Message> chatHistory = messageService.getChatHistory(messageRoomNo);
        return ResponseEntity.ok(chatHistory);
    }
    public String saveFile(MultipartFile upfile,HttpSession session) {
		
		// 파일명 수정작업하기
		// 1.원본파일명 추출
		String originName = upfile.getOriginalFilename();

		// 2.시간형식 문자열로 만들기
		// 20240527162730
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

		// 3.확장자 추출하기 . 찾아서 뒤로 잘라내기
		String ext = originName.substring(originName.lastIndexOf("."));

		// 4.랜덤값 5자리 뽑기
		int ranNum = (int)(Math.random()*90000 + 10000);

		// 5.하나로 합쳐주기
		String changeName = currentTime+ranNum+ext;

		// 6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");

		// 7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
		try {
			upfile.transferTo(new File(savePath + changeName));

		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return changeName;
	}
    
    @PostMapping("/upload")
    public String uploadFile(@RequestParam("file") MultipartFile file,
                             @RequestParam("messageRoomNo") int messageRoomNo,
                             @RequestParam("sendId") String sendId,
                             @RequestParam("receiveId") String receiveId,
                             @RequestParam("readCheck") int readCheck,
                             HttpSession session) throws IOException {
        String changeName = saveFile(file, session);

		// 메시지 객체 생성 및 서비스 호출
		Message message = new Message();
		message.setMessageRoomNo(messageRoomNo);
		message.setSendId(sendId);
		message.setReceiveId(receiveId);
		message.setReadCheck(readCheck);
		message.setOriginName(file.getOriginalFilename());
		message.setChangeName("/reMerge/resources/uploadFiles/"+changeName);
	
		messageService.saveFile(message); // 저장된 파일 DB에 저장
        return "redirect:/message/dm";
    }
}