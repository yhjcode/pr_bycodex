<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><c:out value="${guestbook.title}" /></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    :root {
        --main-red: #DC3545;
        --hover-red: #C92A2A;
        --soft-red: #FFF5F5;
        --text: #212529;
        --muted: #6C757D;
        --border: #E9ECEF;
        --white: #FFFFFF;
    }

    body {
        background: var(--soft-red);
        color: var(--text);
        font-family: Arial, "Malgun Gothic", sans-serif;
    }

    .detail-wrap {
        max-width: 980px;
        margin: 48px auto;
        padding: 0 16px;
    }

    .detail-header {
        border-bottom: 2px solid var(--main-red);
        padding-bottom: 18px;
        margin-bottom: 24px;
    }

    .content-card,
    .comment-card {
        border: 1px solid var(--border);
        border-radius: 8px;
        background: var(--white);
    }

    .content-body {
        min-height: 240px;
        white-space: pre-wrap;
        word-break: break-word;
        line-height: 1.8;
    }

    .comment-item + .comment-item {
        border-top: 1px solid var(--border);
    }

    .comment-content {
        white-space: pre-wrap;
        word-break: break-word;
    }

    .btn-danger {
        --bs-btn-bg: var(--main-red);
        --bs-btn-border-color: var(--main-red);
        --bs-btn-hover-bg: var(--hover-red);
        --bs-btn-hover-border-color: var(--hover-red);
    }

    .form-control:focus {
        border-color: var(--main-red);
        box-shadow: 0 0 0 .25rem rgba(220, 53, 69, .14);
    }
</style>
</head>
<body>
<main class="detail-wrap">
    <div class="detail-header d-flex flex-column flex-sm-row align-items-sm-end justify-content-between gap-3">
        <div>
            <h1 class="h3 fw-bold mb-2"><c:out value="${guestbook.title}" /></h1>
            <div class="d-flex flex-wrap gap-3 text-secondary">
                <span>작성자명 <strong class="text-dark"><c:out value="${guestbook.writer}" /></strong></span>
                <span>작성일시 <fmt:formatDate value="${guestbook.regDate}" pattern="yyyy-MM-dd HH:mm" /></span>
                <span>조회수 <c:out value="${guestbook.readCount}" /></span>
            </div>
        </div>
        <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/guestbook">목록</a>
    </div>

    <article class="content-card p-4 mb-4">
        <div class="content-body"><c:out value="${guestbook.content}" /></div>
    </article>

    <section class="comment-card mb-4">
        <div class="p-4 border-bottom" style="border-color: var(--border) !important;">
            <h2 class="h5 fw-bold mb-0">댓글 <span class="text-danger"><c:out value="${fn:length(commentList)}" /></span></h2>
        </div>

        <c:choose>
            <c:when test="${empty commentList}">
                <div class="p-4 text-secondary">등록된 댓글이 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="comment" items="${commentList}">
                    <div class="comment-item p-4">
                        <div class="d-flex flex-wrap justify-content-between gap-2 mb-2">
                            <strong><c:out value="${comment.writer}" /></strong>
                            <span class="text-secondary small"><fmt:formatDate value="${comment.regDate}" pattern="yyyy-MM-dd HH:mm" /></span>
                        </div>
                        <div class="comment-content"><c:out value="${comment.content}" /></div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </section>

    <form class="comment-card p-4" action="${pageContext.request.contextPath}/guestbook" method="post">
        <input type="hidden" name="action" value="commentInsert">
        <input type="hidden" name="idx" value="${guestbook.idx}">

        <h2 class="h5 fw-bold mb-3">댓글 작성</h2>
        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label fw-bold" for="commentWriter">댓글 작성자명</label>
                <input class="form-control" type="text" id="commentWriter" name="commentWriter" maxlength="50" required>
            </div>
            <div class="col-md-8">
                <label class="form-label fw-bold" for="commentContent">댓글내용</label>
                <textarea class="form-control" id="commentContent" name="commentContent" rows="4" maxlength="1000" required></textarea>
            </div>
        </div>
        <div class="d-flex justify-content-end mt-3">
            <button class="btn btn-danger fw-bold" type="submit">댓글 등록</button>
        </div>
    </form>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
