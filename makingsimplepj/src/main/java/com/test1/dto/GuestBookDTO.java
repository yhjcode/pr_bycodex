package com.test1.dto;

import java.sql.Timestamp;

public class GuestBookDTO {
    private int idx;
    private String writer;
    private String title;
    private String content;
    private Timestamp regDate;
    private int readCount;

    public GuestBookDTO() {
    }

    public GuestBookDTO(int idx, String writer, String title, String content, Timestamp regDate, int readCount) {
        this.idx = idx;
        this.writer = writer;
        this.title = title;
        this.content = content;
        this.regDate = regDate;
        this.readCount = readCount;
    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public int getReadCount() {
        return readCount;
    }

    public void setReadCount(int readCount) {
        this.readCount = readCount;
    }
}
