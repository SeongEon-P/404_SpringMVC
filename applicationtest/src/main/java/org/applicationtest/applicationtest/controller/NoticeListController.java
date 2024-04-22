package org.applicationtest.applicationtest.controller;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.dto.NoticeDTO;
import org.applicationtest.applicationtest.service.NoticeService;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/notice_list")
@Log4j2
public class NoticeListController extends HttpServlet {
    private NoticeService noticeService = NoticeService.INSTANCE;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        log.info("notice_list get..................");


        try{
            List<NoticeDTO> dtoList = noticeService.listALL();
            req.setAttribute("noticeList", dtoList);
            req.getRequestDispatcher("/WEB-INF/tourist/notice_list.jsp").forward(req, resp);
        }catch(Exception e){
            e.printStackTrace();
            log.error(e.getMessage());
            throw new ServletException("list error");
        }


    }

}