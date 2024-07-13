package com.kh.reMerge.message.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@Controller
public class EmojiController {

    @ResponseBody
    @RequestMapping(value = "/emojis", produces = "application/json;charset=UTF-8")
    public String getEmojis() throws IOException {
        // API 호출을 위한 설정
        String accessKey = "390b0bed90d29e75d094949b7cf9f68e037941ff";
        String url = "https://emoji-api.com/emojis";

        URL requestUrl = new URL(url + "?access_key=" + accessKey);
        HttpURLConnection urlCon = (HttpURLConnection) requestUrl.openConnection();
        urlCon.setRequestMethod("GET");
        BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));

        // 응답 데이터를 받아서 문자열로 변환
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }

        br.close();
        urlCon.disconnect();

        return response.toString();
    }
}
