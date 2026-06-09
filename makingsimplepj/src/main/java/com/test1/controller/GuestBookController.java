package com.test1.controller;

import java.io.IOException;
import java.util.List;

import com.test1.dao.GuestBookCommentDAO;
import com.test1.dao.GuestBookDAO;
import com.test1.dto.GuestBookCommentDTO;
import com.test1.dto.GuestBookDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/guestbook")
public class GuestBookController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final GuestBookDAO dao = GuestBookDAO.getInstance(); //dao를 싱글톤으로 메서드를 통해서만 접근하도록 세팅
    private final GuestBookCommentDAO commentDao = GuestBookCommentDAO.getInstance();// 댓글dao도 동일

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");// jsp내부 form태그에 정의된 action속성값 추출
        if (action == null || action.trim().isEmpty()) {
            action = "list"; // 처음 메인페이지에 접속해서 action내용이 없을경우 action값을 문자열"list"로 초기화
        }

        switch (action) {//위의 if문 조건에 해당하지 않거나 list로 초기화 한 뒤 분기
        case "write":
            forward(request, response, "/guestbookWrite.jsp");
            break;
        case "read":
            showDetail(request, response);// action값이 read일 경우 쇼디테일메서드호출+ 매개변수로 doget으로 받은 파라미터값등 전달
            break;
        case "list":
        default:
            List<GuestBookDTO> list = dao.getList();
            request.setAttribute("guestbookList", list);
            forward(request, response, "/guestbookList.jsp");
            break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("insert".equals(action)) {
            GuestBookDTO dto = new GuestBookDTO();
            dto.setWriter(request.getParameter("writer"));
            dto.setTitle(request.getParameter("title"));
            dto.setContent(request.getParameter("content"));

            // The DAO inserts the post number with contents_seq.NEXTVAL.
            dao.insert(dto);
            response.sendRedirect(request.getContextPath() + "/guestbook");
            return; // db에 글이 저장되었는지와 관계없이 첫화면으로 이동
        }

        if ("commentInsert".equals(action)) {
            int contentIdx = parseIdx(request.getParameter("idx"));

            GuestBookCommentDTO dto = new GuestBookCommentDTO();
            dto.setContentIdx(contentIdx);
            dto.setWriter(request.getParameter("commentWriter"));
            dto.setContent(request.getParameter("commentContent"));

            commentDao.insert(dto);
            response.sendRedirect(request.getContextPath() + "/guestbook?action=read&idx=" + contentIdx + "&hit=false");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/guestbook");
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idx = parseIdx(request.getParameter("idx")); // 인덱스값을 추출해서 정수로 변환

        if (!"false".equals(request.getParameter("hit"))) { // 잘은 모르겟는데 파라미터값 hit이 false가 아니라면? == 이게 무엇을 말하는가
            dao.increaseReadCount(idx);    // 조건을 충족하면   조회수증가메서드를 호출하고 매개변수로 idx전달 후 idx에 해당하는 컬럼의  readcount +1 하고 성공한 행의 수 리턴
        }
        GuestBookDTO detail = dao.getDetail(idx); // idx에 해당하는 튜플을 전부 가져와서(select문) dto필드에 초기화하고 그 dto를 리턴해서 detail에 저장

        if (detail == null) { // 가져온 dto가 비어있다면(select문의 값에 해당하는 튜플이 테이블에 없답면)
            response.sendRedirect(request.getContextPath() + "/guestbook"); // 첫페이지로 이동
            return;
        }

        List<GuestBookCommentDTO> comments = commentDao.getListByContentIdx(idx);
        request.setAttribute("guestbook", detail);
        request.setAttribute("commentList", comments);
        forward(request, response, "/maincontents.jsp");
    }

    private int parseIdx(String idxValue) { // 인덱스넘버를 받아서 정수로 형변환하는 메서드
        if (idxValue == null || idxValue.trim().isEmpty()) {
            throw new IllegalArgumentException("Content idx is required.");
        }

        try {
            return Integer.parseInt(idxValue);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid content idx.", e);
        }
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }
}
