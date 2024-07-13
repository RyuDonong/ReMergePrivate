package com.kh.reMerge.message.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Emoji {
    private String slug;
    private String character;
    private String unicodeName;
    private String codePoint;
    private String group;
    private String subGroup;
}