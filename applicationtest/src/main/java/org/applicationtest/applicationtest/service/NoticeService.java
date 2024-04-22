package org.applicationtest.applicationtest.service;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.dao.NoticeDAO;
import org.applicationtest.applicationtest.domain.NoticeVO;
import org.applicationtest.applicationtest.dto.NoticeDTO;
import org.modelmapper.ModelMapper;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;


@Log4j2
public enum NoticeService {
    INSTANCE;
    private NoticeDAO noticeDAO;
    private ModelMapper modelMapper;

    NoticeService() {
        this.noticeDAO = new NoticeDAO();
    }


    public void addNotice(NoticeDTO noticeDTO) throws ServletException, IOException, SQLException {
        noticeDAO.addNotice(noticeDTO);
    }

    public List<NoticeDTO> listALL() throws Exception{
//        List<NoticeVO> voList = noticeDAO.selectAll();
//        log.info("voList..................");
//        log.info(voList);
//
//        List<NoticeDTO> dtoList = voList.stream()
//                .map(vo -> modelMapper.map(vo,NoticeDTO.class))
//                .collect(Collectors.toList());

        return noticeDAO.selectAll();
    }

    public NoticeDTO get(int no) throws Exception{
        return noticeDAO.selectOne(no);
    }

    public void remove(int no) throws Exception{
        log.info("no:" + no);
        noticeDAO.deleteOne(no);
    }


}
