package org.applicationtest.applicationtest.program.controller;

import org.applicationtest.applicationtest.program.dto.ProgramDTO;
import org.applicationtest.applicationtest.program.service.ProgramService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/program")
public class ProgramListController extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try{
      List<ProgramDTO> list = ProgramService.INSTANCE.getProgramList();
      req.setAttribute("list",list);
      req.getRequestDispatcher("/WEB-INF/views/program.jsp").forward(req, resp);
    }catch(Exception e){
      e.printStackTrace();
    }
  }
}
