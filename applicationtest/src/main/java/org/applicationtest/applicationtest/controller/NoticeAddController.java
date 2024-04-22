package org.applicationtest.applicationtest.controller;


import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.dto.NoticeDTO;
import org.applicationtest.applicationtest.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/notice_add")
@Log4j2
public class NoticeAddController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/tourist/notice_add.jsp").forward(req, resp);
    }

    @Override
        protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            NoticeDTO noticeDTO = NoticeDTO.builder()
                    .title(req.getParameter("title"))
                    .content(req.getParameter("contents"))
                    .build();
            log.info("/tourist/add Notice ........");
            log.info(noticeDTO);
            try{
                NoticeService.INSTANCE.addNotice(noticeDTO);
            }catch(Exception e){
                e.printStackTrace();
            }
            resp.sendRedirect("/notice_list");
        }

}
