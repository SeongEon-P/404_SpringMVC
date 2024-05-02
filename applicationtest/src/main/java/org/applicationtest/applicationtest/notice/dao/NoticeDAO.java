package org.applicationtest.applicationtest.notice.dao;

import lombok.Cleanup;
import org.applicationtest.applicationtest.notice.dto.NoticeDTO;
import org.applicationtest.applicationtest.util.ConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NoticeDAO {
  public List<NoticeDTO> selectNoiceList() throws Exception {
    String sql = "SELECT * FROM notice";
    @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
    @Cleanup PreparedStatement preparedStatement = conn.prepareStatement(sql);
    @Cleanup ResultSet resultSet = preparedStatement.executeQuery();
    List<NoticeDTO> list = new ArrayList<NoticeDTO>();
    while(resultSet.next()) {
      NoticeDTO noticeDTO = NoticeDTO.builder()
          .no(resultSet.getInt("no"))
          .title(resultSet.getString("title"))
          .content(resultSet.getString("content"))
          .count(resultSet.getInt("count"))
          .create_date(resultSet.getDate("create_date").toLocalDate())
          .build();
      list.add(noticeDTO);
    }
    return list;
  }
  public NoticeDTO selectNoice(int no) throws Exception {
    String sql = "SELECT * FROM notice WHERE no = ?";
    @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
    @Cleanup PreparedStatement preparedStatement = conn.prepareStatement(sql);
    preparedStatement.setInt(1, no);
    @Cleanup ResultSet resultSet = preparedStatement.executeQuery();
    resultSet.next();
    NoticeDTO noticeDTO = NoticeDTO.builder()
        .no(resultSet.getInt("no"))
        .title(resultSet.getString("title"))
        .content(resultSet.getString("content"))
        .count(resultSet.getInt("count"))
        .create_date(resultSet.getDate("create_date").toLocalDate())
        .build();
    return noticeDTO;
  }

  public void insertNotice(NoticeDTO notice) throws Exception {
    String sql = "INSERT INTO notice(title,content) VALUES(?,?)";
    @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
    @Cleanup PreparedStatement preparedStatement = conn.prepareStatement(sql);
    preparedStatement.setString(1, notice.getTitle());
    preparedStatement.setString(2, notice.getContent());
    preparedStatement.executeUpdate();
  }
  public void deleteNotice(int no) throws Exception {
    String sql = "DELETE FROM notice WHERE no = ?";
    @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
    @Cleanup PreparedStatement preparedStatement = conn.prepareStatement(sql);
    preparedStatement.setInt(1, no);
    preparedStatement.executeUpdate();
  }
}
