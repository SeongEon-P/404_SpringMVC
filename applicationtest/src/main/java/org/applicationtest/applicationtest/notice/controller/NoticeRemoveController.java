package org.applicationtest.applicationtest.notice.controller;

import org.applicationtest.applicationtest.notice.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/notice_remove")
public class NoticeRemoveController extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try{
      int no = Integer.parseInt(req.getParameter("no")) ;
      NoticeService.INTANCE.removeNotice(no);
    }catch (Exception e){
      e.printStackTrace();
    }
    resp.sendRedirect("/notice_list");
  }
}
