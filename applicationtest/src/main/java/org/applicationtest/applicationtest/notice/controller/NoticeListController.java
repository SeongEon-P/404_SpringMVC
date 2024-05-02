package org.applicationtest.applicationtest.notice.controller;

import org.applicationtest.applicationtest.notice.dto.NoticeDTO;
import org.applicationtest.applicationtest.notice.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/notice_list")
public class NoticeListController extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try{
      List<NoticeDTO> list = NoticeService.INTANCE.getNoticeList();
      req.setAttribute("list", list);
    }catch(Exception e){
      e.printStackTrace();
    }
    req.getRequestDispatcher("/WEB-INF/views/notice_list.jsp").forward(req, resp);
  }
}
