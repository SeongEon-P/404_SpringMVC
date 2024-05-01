package org.zerock.b01.service;

import org.zerock.b01.dto.ProgramDTO;

import java.util.List;

public interface ProgramService {
    //모든데이터를 받아올거임. <>안에는 반환할게 들어감
    List<ProgramDTO> selectAll();
}
