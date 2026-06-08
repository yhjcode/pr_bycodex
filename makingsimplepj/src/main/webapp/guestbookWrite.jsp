<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>방명록 작성</title>
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
        width: min(720px, calc(100% - 32px));
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

    .back {
        color: #1769aa;
        font-size: 14px;
        font-weight: 700;
        text-decoration: none;
    }

    .form-box {
        padding: 24px;
        border: 1px solid #dde3ea;
        border-radius: 8px;
        background: #fff;
    }

    .field {
        margin-bottom: 18px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        color: #344054;
        font-size: 14px;
        font-weight: 700;
    }

    input,
    textarea {
        width: 100%;
        border: 1px solid #cbd5df;
        border-radius: 6px;
        padding: 11px 12px;
        color: #222;
        font: inherit;
    }

    textarea {
        min-height: 180px;
        resize: vertical;
    }

    input:focus,
    textarea:focus {
        border-color: #1769aa;
        outline: 3px solid rgba(23, 105, 170, 0.14);
    }

    .actions {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }

    .btn {
        min-height: 42px;
        border: 0;
        border-radius: 6px;
        padding: 0 18px;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
    }

    .submit {
        background: #1769aa;
        color: #fff;
    }

    .reset {
        background: #e8eef4;
        color: #344054;
    }
</style>
</head>
<body>
<div class="wrap">
    <div class="top">
        <h1>방명록 작성</h1>
        <a class="back" href="${pageContext.request.contextPath}/guestbook">목록으로</a>
    </div>

    <form class="form-box" action="${pageContext.request.contextPath}/guestbook" method="post">
        <input type="hidden" name="action" value="insert">

        <div class="field">
            <label for="writer">작성자</label>
            <input type="text" id="writer" name="writer" maxlength="50" required>
        </div>

        <div class="field">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" maxlength="200" required>
        </div>

        <div class="field">
            <label for="content">내용</label>
            <textarea id="content" name="content" maxlength="4000" required></textarea>
        </div><%--required: 입력을 안 하고 등록을 누르면 브라우저가 "이 필드를 입력하세요"라며 전송을 막아줍니다. --%>

        <div class="actions">
            <button class="btn reset" type="reset">초기화</button>
            <button class="btn submit" type="submit">등록</button>
        </div>
    </form>
</div>
</body>
</html>
