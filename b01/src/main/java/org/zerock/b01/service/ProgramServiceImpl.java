package org.zerock.b01.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.zerock.b01.dto.ProgramDTO;
import org.zerock.b01.repository.ProgramRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional //database에 transaction을 걸기위해. 
public class ProgramServiceImpl implements ProgramService {
    private final ProgramRepository programRepository;
    private final ModelMapper modelMapper;
    
    @Override
    public List<ProgramDTO> selectAll(){
//        stream은 반복문 같은 여러 기능 할 수 있게 해줌
        return programRepository.findAll().stream()
                .map(program -> modelMapper.map(program, ProgramDTO.class))
                //리스트화된 program이 programDTO로 변환되서 반환됨
                .collect(Collectors.toList());
    }
}



