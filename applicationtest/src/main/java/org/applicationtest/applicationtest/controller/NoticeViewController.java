package org.applicationtest.applicationtest.controller;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.dto.NoticeDTO;
import org.applicationtest.applicationtest.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/notice_view")
@Log4j2
public class NoticeViewController extends HttpServlet {

    private NoticeService noticeService = NoticeService.INSTANCE;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try{
            int no = Integer.parseInt(req.getParameter("no"));

            NoticeDTO noticeDTO = noticeService.get(no);
            req.setAttribute("dto", noticeDTO);

            req.getRequestDispatcher("/WEB-INF/tourist/notice_view.jsp").forward(req, resp);

        } catch (Exception e){
            e.printStackTrace();
            log.error(e.getMessage());
            throw new ServletException(e);
        }
}
}
