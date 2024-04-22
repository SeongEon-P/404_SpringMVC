package org.applicationtest.applicationtest.service;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.dao.NoticeDAO;
import org.applicationtest.applicationtest.dao.ProgramDAO;
import org.applicationtest.applicationtest.dto.NoticeDTO;
import org.applicationtest.applicationtest.dto.ProgramDTO;

import java.util.List;

@Log4j2
public enum ProgramService {
    INSTANCE;
    private ProgramDAO programDAO = new ProgramDAO();

    public List<ProgramDTO> listALL() throws Exception {

        return programDAO.selectAll();
    }
}