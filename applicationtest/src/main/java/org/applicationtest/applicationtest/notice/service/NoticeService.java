package org.applicationtest.applicationtest.notice.service;

import org.applicationtest.applicationtest.notice.dao.NoticeDAO;
import org.applicationtest.applicationtest.notice.dto.NoticeDTO;

import java.sql.SQLException;
import java.util.List;

public enum NoticeService {
  INTANCE;
  private NoticeDAO noticeDAO = new NoticeDAO();
  public List<NoticeDTO> getNoticeList() throws Exception {
    return noticeDAO.selectNoiceList();
  }
  public NoticeDTO getNotice(int no) throws Exception {
    return noticeDAO.selectNoice(no);
  }
  public void addNotice(NoticeDTO noticeDTO) throws Exception {
    noticeDAO.insertNotice(noticeDTO);
  }
  public void removeNotice(int no) throws Exception {
    noticeDAO.deleteNotice(no);
  }
}
