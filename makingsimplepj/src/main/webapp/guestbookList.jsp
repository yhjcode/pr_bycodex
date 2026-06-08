<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>방명록 목록</title>
<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        background: #f4f6f8;
        color: #222;
        font-family: Arial, "Malgun Gothic", sans-serif;
    }

    .wrap {
        width: min(960px, calc(100% - 32px));
        margin: 48px auto;
    }

    .top {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 20px;
    }

    h1 {
        margin: 0;
        font-size: 28px;
        font-weight: 700;
    }

    .write-btn {
        display: inline-flex;
        align-items: center;
        min-height: 40px;
        padding: 0 16px;
        border-radius: 6px;
        background: #1769aa;
        color: #fff;
        font-size: 14px;
        font-weight: 700;
        text-decoration: none;
    }

    .list {
        display: grid;
        gap: 12px;
    }

    .item {
        padding: 18px 20px;
        border: 1px solid #dde3ea;
        border-radius: 8px;
        background: #fff;
    }

    .item-head {
        display: flex;
        align-items: baseline;
        justify-content: space-between;
        gap: 18px;
        margin-bottom: 12px;
    }

    .title {
        min-width: 0;
        color: #1f2933;
        font-size: 18px;
        font-weight: 700;
        line-height: 1.4;
        text-decoration: none;
        word-break: break-word;
    }

    .title:hover {
        color: #1769aa;
        text-decoration: underline;
    }

    .meta {
        display: flex;
        flex-wrap: wrap;
        justify-content: flex-end;
        gap: 8px 14px;
        color: #607080;
        font-size: 13px;
        white-space: nowrap;
    }

    .content {
        margin: 0;
        color: #344054;
        font-size: 15px;
        line-height: 1.7;
        white-space: pre-wrap;
        word-break: break-word;
    }

    .empty {
        padding: 42px 20px;
        border: 1px dashed #b8c4d0;
        border-radius: 8px;
        background: #fff;
        color: #667085;
        text-align: center;
    }

    @media (max-width: 640px) {
        .top,
        .item-head {
            align-items: flex-start;
            flex-direction: column;
        }

        .meta {
            justify-content: flex-start;
            white-space: normal;
        }
    }
</style>
</head>
<body>
<div class="wrap">
    <div class="top">
        <h1>방명록</h1>
        <a class="write-btn" href="${pageContext.request.contextPath}/guestbook?action=write">글쓰기</a>
    </div>

    <div class="list">
        <c:choose>
            <c:when test="${empty guestbookList}">
                <div class="empty">등록된 방명록 글이 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="item" items="${guestbookList}">
                    <article class="item">
                        <div class="item-head">
                            <a class="title" href="${pageContext.request.contextPath}/guestbook?action=read&amp;idx=${item.idx}">
                                <c:out value="${item.title}" />
                            </a>
                            <div class="meta">
                                <span>글쓴이: <c:out value="${item.writer}" /></span>
                                <span>작성시간: <fmt:formatDate value="${item.regDate}" pattern="yyyy-MM-dd HH:mm" /></span>
                                <span>조회수: <c:out value="${item.readCount}" /></span>
                            </div>
                        </div>
                        <p class="content"><c:out value="${item.content}" /></p>
                    </article>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
