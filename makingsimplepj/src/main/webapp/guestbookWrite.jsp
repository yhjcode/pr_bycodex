<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성</title>
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

    .write-wrap {
        max-width: 760px;
        margin: 48px auto;
        padding: 0 16px;
    }

    .write-header {
        border-bottom: 2px solid var(--main-red);
        padding-bottom: 18px;
        margin-bottom: 24px;
    }

    .write-card {
        border: 1px solid var(--border);
        border-radius: 8px;
        background: var(--white);
        padding: 24px;
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
<main class="write-wrap">
    <div class="write-header d-flex align-items-end justify-content-between gap-3">
        <div>
            <h1 class="h3 fw-bold mb-2">게시글 작성</h1>
            <p class="text-secondary mb-0">커뮤니티에 공유할 내용을 작성해주세요.</p>
        </div>
        <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/guestbook">목록</a>
    </div>

    <form class="write-card" action="${pageContext.request.contextPath}/guestbook" method="post">
        <input type="hidden" name="action" value="insert">

        <div class="mb-3">
            <label class="form-label fw-bold" for="writer">작성자명</label>
            <input class="form-control" type="text" id="writer" name="writer" maxlength="50" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-bold" for="title">제목</label>
            <input class="form-control" type="text" id="title" name="title" maxlength="200" required>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold" for="content">내용</label>
            <textarea class="form-control" id="content" name="content" rows="10" maxlength="4000" required></textarea>
        </div>

        <div class="d-flex justify-content-end gap-2">
            <button class="btn btn-light border fw-bold" type="reset">초기화</button>
            <button class="btn btn-danger fw-bold" type="submit">등록</button>
        </div>
    </form>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
