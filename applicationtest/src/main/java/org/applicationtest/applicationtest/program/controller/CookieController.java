package org.applicationtest.applicationtest.program.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cookie")
public class CookieController extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try{
      String title = req.getParameter("title").replace(" ","");
      Cookie viewProgramsCookie = findCookie(req.getCookies(),"viewPrograms");
      String programListStr = viewProgramsCookie.getValue();
      boolean exist = false;
      if(programListStr != null && programListStr.indexOf(title+"-")>=0){
        exist = true;
      }
      if(!exist){
        programListStr += title+"-";
        viewProgramsCookie.setValue(programListStr);
//        viewProgramsCookie.setMaxAge(60*60*24);
        viewProgramsCookie.setPath("/");
        resp.addCookie(viewProgramsCookie);
      }
      resp.sendRedirect("/program");
    }catch (Exception e){
      e.printStackTrace();
    }
  }
  private Cookie findCookie(Cookie[] cookies,String cookieName){
    Cookie targetCookie = null;
    if(cookies != null && cookies.length > 0){
      for(Cookie ck : cookies){
        if(ck.getName().equals(cookieName)){
          targetCookie = ck;
          break;
        }
      }
    }
    if(targetCookie == null){
      targetCookie = new Cookie(cookieName,"");
      targetCookie.setPath("/");
//      targetCookie.setMaxAge(60*60*24);
    }
    return targetCookie;
  }
}
