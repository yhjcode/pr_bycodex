<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티 게시판</title>
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

    .board-wrap {
        max-width: 1080px;
        margin: 48px auto;
        padding: 0 16px;
    }

    .board-header {
        border-bottom: 2px solid var(--main-red);
        padding-bottom: 18px;
        margin-bottom: 24px;
    }

    .btn-danger {
        --bs-btn-bg: var(--main-red);
        --bs-btn-border-color: var(--main-red);
        --bs-btn-hover-bg: var(--hover-red);
        --bs-btn-hover-border-color: var(--hover-red);
    }

    .board-card {
        border: 1px solid var(--border);
        border-radius: 8px;
        background: var(--white);
        overflow: hidden;
    }

    .table {
        margin-bottom: 0;
    }

    .table thead th {
        background: var(--soft-red);
        color: var(--text);
        border-bottom: 1px solid var(--border);
        font-weight: 700;
    }

    .table td {
        border-color: var(--border);
        vertical-align: middle;
    }

    .post-title {
        color: var(--text);
        font-weight: 700;
        text-decoration: none;
    }

    .post-title:hover {
        color: var(--hover-red);
        text-decoration: underline;
    }

    .post-preview {
        color: var(--muted);
        font-size: 0.925rem;
        max-width: 640px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .empty-box {
        border: 1px dashed var(--border);
        border-radius: 8px;
        background: var(--white);
        color: var(--muted);
        padding: 56px 16px;
        text-align: center;
    }
</style>
</head>
<body>
<main class="board-wrap">
    <div class="board-header d-flex flex-column flex-sm-row align-items-sm-end justify-content-between gap-3">
        <div>
            <h2 class="h3 fw-bold mb-2">커뮤니티 게시판</h2>
            <p class="text-secondary mb-0">게시글을 클릭하면 내용과 댓글을 확인할 수 있습니다.</p>
        </div>
        <a class="btn btn-danger fw-bold" href="${pageContext.request.contextPath}/guestbook?action=write">글쓰기</a> <!-- [개념] 웹 애플리케이션 경로를 동적으로 처리하는
         컨텍스트 패스 표현식(${pageContext.request.contextPath})과, 서블릿(Controller)에 '글쓰기 페이지 요청'임을 알리는 
        쿼리 스트링(?action=write) 파라미터 전송 방식이 사용되었습니다. -->
    </div>

    <c:choose> <%-- when otherwise 문법 = if, else if 문법을 jstl 방식으로--%>
        <c:when test="${empty guestbookList}">
            <div class="empty-box">등록된 게시글이 없습니다.</div>
        </c:when>
        <c:otherwise>
            <div class="board-card table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th style="width: 80px;">번호</th>
                            <th>제목</th>
                            <th style="width: 150px;">작성자</th>
                            <th style="width: 170px;">작성일시</th>
                            <th style="width: 90px;">조회</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${guestbookList}"> <%--게스트북리스트의 인데스수만큼 반복하며 var에 list값(dto)를 저장  --%>
                            <tr>
                                <td class="text-secondary"><c:out value="${item.idx}" /></td><%-- 보안처리후 출력 + 뽑은item dto 리스트에서 idx만 출력하겠다(dto.getidx()) --%>
                                <td>
                                    <a class="post-title" href="${pageContext.request.contextPath}/guestbook?action=read&amp;idx=${item.idx}">
                                        <c:out value="${item.title}" /><%--애노테이션이guestbook인 서블릿에 action에 정의된 파라미터를 전달(?로 url정보와 파라미터를 구분)
                                          action값으로 read와 idx값을 전달(idx값은 item에저장된 dto의 idx필드에서 추출하여 저장) --%>
                                    </a>
                                    <div class="post-preview"><c:out value="${item.content}" /></div><%--게시글 내용을 출력(css로 분량제한. 체크해볼것) --%>
                                </td>
                                <td><c:out value="${item.writer}" /></td><%--작성자정보 value에 저장하고 출력 --%>
                                <td class="text-secondary"><fmt:formatDate value="${item.regDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td class="text-secondary"><c:out value="${item.readCount}" /></td><%--날짜데이터 다듬기 + 출력 --%>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
