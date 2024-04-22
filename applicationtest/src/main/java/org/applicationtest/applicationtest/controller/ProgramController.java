package org.applicationtest.applicationtest.controller;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.dto.NoticeDTO;
import org.applicationtest.applicationtest.dto.ProgramDTO;
import org.applicationtest.applicationtest.service.NoticeService;
import org.applicationtest.applicationtest.service.ProgramService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


    @WebServlet("/program")
    @Log4j2
    public class ProgramController extends HttpServlet {
        private ProgramService programService = ProgramService.INSTANCE;

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            log.info("program get..................");


            try{
                List<ProgramDTO> dtoList = programService.listALL();
                req.setAttribute("programList", dtoList);
                req.getRequestDispatcher("/WEB-INF/tourist/program.jsp").forward(req, resp);
            }catch(Exception e){
                e.printStackTrace();
                log.error(e.getMessage());


            }


        }

    }

