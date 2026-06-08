package com.test1.controller;

import java.io.IOException;
import java.util.List;

import com.test1.dao.GuestBookDAO;
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

    private final GuestBookDAO dao = GuestBookDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        switch (action) {
        case "write":
            forward(request, response, "/guestbookWrite.jsp");
            break;
        case "read":
            increaseReadCount(request);
            response.sendRedirect(request.getContextPath() + "/guestbook");
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
        }

        response.sendRedirect(request.getContextPath() + "/guestbook");
    }

    private void increaseReadCount(HttpServletRequest request) {
        String idxValue = request.getParameter("idx");
        if (idxValue == null || idxValue.trim().isEmpty()) {
            return;
        }

        try {
            dao.increaseReadCount(Integer.parseInt(idxValue));
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
