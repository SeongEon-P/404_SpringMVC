package org.applicationtest.applicationtest.notice.controller;

import org.applicationtest.applicationtest.notice.dto.NoticeDTO;
import org.applicationtest.applicationtest.notice.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addnotice")
public class NoticeAddController extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.getRequestDispatcher("/WEB-INF/views/notice_add.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    try{
      NoticeDTO noticeDTO = NoticeDTO.builder()
          .title(req.getParameter("title"))
          .content(req.getParameter("contents"))
          .build();
      NoticeService.INTANCE.addNotice(noticeDTO);
    }catch(Exception e){
      e.printStackTrace();
    }
    resp.sendRedirect("/notice_list");
  }
}

