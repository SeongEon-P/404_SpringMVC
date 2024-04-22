package org.applicationtest.applicationtest.controller;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@Log4j2
@WebServlet("/notice_remove")

public class NoticeRemoveController extends HttpServlet {

    private NoticeService noticeService = NoticeService.INSTANCE;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int no = Integer.parseInt(req.getParameter("id"));
        log.info("no : " + no);

        try {
            noticeService.remove(no);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect("/notice_list");

    }
}
