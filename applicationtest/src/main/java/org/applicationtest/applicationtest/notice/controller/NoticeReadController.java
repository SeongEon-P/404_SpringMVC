package org.applicationtest.applicationtest.notice.controller;

import org.applicationtest.applicationtest.notice.dto.NoticeDTO;
import org.applicationtest.applicationtest.notice.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/notice")
public class NoticeReadController extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try{
      int no = Integer.parseInt(req.getParameter("no")) ;
      NoticeDTO noticeDTO = NoticeService.INTANCE.getNotice(no);
      req.setAttribute("notice", noticeDTO);
    }catch (Exception e){
      e.printStackTrace();
    }
    req.getRequestDispatcher("/WEB-INF/views/notice_view.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.sendRedirect("/notice_list");
    try{
      int no = Integer.parseInt(req.getParameter("no")) ;
      NoticeService.INTANCE.removeNotice(no);
    }catch (Exception e){
      e.printStackTrace();
    }
  }
}
