package com.test1.dto;

import java.sql.Timestamp;

public class GuestBookCommentDTO {
    private int commentIdx;
    private int contentIdx;
    private String writer;
    private String content;
    private Timestamp regDate;

    public GuestBookCommentDTO() {
    }

    public GuestBookCommentDTO(int commentIdx, int contentIdx, String writer, String content, Timestamp regDate) {
        this.commentIdx = commentIdx;
        this.contentIdx = contentIdx;
        this.writer = writer;
        this.content = content;
        this.regDate = regDate;
    }

    public int getCommentIdx() {
        return commentIdx;
    }

    public void setCommentIdx(int commentIdx) {
        this.commentIdx = commentIdx;
    }

    public int getContentIdx() {
        return contentIdx;
    }

    public void setContentIdx(int contentIdx) {
        this.contentIdx = contentIdx;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }
}
