package org.applicationtest.applicationtest.program.service;

import org.applicationtest.applicationtest.program.dao.ProgramDAO;
import org.applicationtest.applicationtest.program.dto.ProgramDTO;

import java.sql.SQLException;
import java.util.List;

public enum ProgramService {
  INSTANCE;
  private ProgramDAO programDAO = new ProgramDAO();
  public List<ProgramDTO> getProgramList() throws Exception {
    return programDAO.selectProgramList();
  }
}
