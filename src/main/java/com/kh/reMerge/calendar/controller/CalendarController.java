package com.kh.reMerge.calendar.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.reMerge.calendar.model.service.CalendarService;
import com.kh.reMerge.calendar.model.vo.Schedule;
import com.kh.reMerge.common.model.vo.FollowListPageInfo;
import com.kh.reMerge.common.template.Pagination;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;


	@Controller
	public class CalendarController {
		
		@Autowired
		private CalendarService cs;
		
		//캘린더 페이지 이동
		@GetMapping("calendar.sc")
		public String calendar() {
			
			return "calendar/main";
		}
		
		//일정 추가
		@ResponseBody
		@PostMapping(value="insertSchedule.sc",produces="application/json;charset=UTF-8")
		public int insertSchedule(Schedule s) {
//			System.out.println(s);
			int result = cs.insertSchedule(s);
			return result;
		}
		
		//캘린더 페이지에서 일정 조회
		@ResponseBody
		@GetMapping(value="selectSchedule.sc",produces="application/json;charset=UTF-8")
		public ArrayList<Schedule> selectSchedule(String userId){

			return cs.selectSchedule(userId);
		}
		
		//일정 클릭시 상세 조회
		@ResponseBody
		@GetMapping(value="detailSchedule.sc",produces="application/json;charset=UTF-8")
		public Schedule detailSchedule(int scheduleNo) {
			
			return cs.detailSchedule(scheduleNo);
		}
	
		//일정 삭제
		@GetMapping("deleteSchedule.sc")
		public String deleteSchedule(int scheduleNo ,HttpSession session) {
			
//			System.out.println(scheduleNo); //넘어오는지 확인
			int result = cs.deleteSchedule(scheduleNo);
			if(result>0) {
				session.setAttribute("alertMsg", "성공적으로 삭제 되었습니다.");
				return "redirect:calendar.sc";
			}else{
				session.setAttribute("alertMsg", "삭제 되지 않았습니다. 관리자에게 문의하세요.");
				return "redirect:calendar.sc";
			}
		}
		
		//일정 수정
		@PostMapping("updateSchedule.sc")
		public String updateSchedule(Schedule s,HttpSession session) {
//			System.out.println(s);
			int result = cs.updateSchedule(s);
			if(result>0) {
				session.setAttribute("alertMsg", "성공적으로 수정 되었습니다.");
				return "redirect:calendar.sc";
			}else{
				session.setAttribute("alertMsg", "수정 되지 않았습니다. 관리자에게 문의하세요.");
				return "redirect:calendar.sc";
			}
			
		}
		
		//캘린더 팔로우 리스트 페이지로 이동
		@GetMapping("followList.sc")
		public String followList() {
			
			return "/calendar/calendarFollowList";
		}
		
		//무한스크롤로 팔로우 리스트 조회하기
		@ResponseBody
		@PostMapping(value = "selectFollowList.sc", produces = "application/json;charset=UTF-8")
		public HashMap<String, Object> selectFollowList(String userId, @RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		    int listCount = cs.followListCount(userId);
		    int pageLimit = 10;
		    int userLimit = 10; 

		    FollowListPageInfo fpi = Pagination.getFollowListPageInfo(listCount, currentPage, pageLimit, userLimit);
		    ArrayList<User> followList = cs.followList(userId, fpi);
		    HashMap<String, Object> map = new HashMap<>();
		    map.put("fpi", fpi);
		    map.put("followList", followList);
		    return map;
		}
		
		
		@PostMapping("shareCalendar.sc")
		public String shareCalendar(String chooseFollow,HttpSession session) {
//			System.out.println(chooseFollow);
			String[] follower = chooseFollow.split(",");
			 // HashSet을 사용하여 중복 제거
	        Set<String> uniqueFollowerSet = new HashSet<>(Arrays.asList(follower));
	        
	        // HashSet을 배열로 변환
	        String[] uniqueFollower = uniqueFollowerSet.toArray(new String[0]);
			
			ArrayList<Schedule> list = cs.selectShareSchedule(uniqueFollower);
//			System.out.println(list);
			session.setAttribute("list", list);
			return "/calendar/shareCalendar";
		}
		
		//공유 캘린더 팔로우 리스트 목록에서 검색 
		@ResponseBody
		@GetMapping("searchFollower.sc")
		public ArrayList<User> searchFollower(FollowList followList){
			
			return cs.searchFollower(followList);
		}
		
		
}
