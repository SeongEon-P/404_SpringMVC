package org.applicationtest.applicationtest.dao;

import lombok.Cleanup;
import org.applicationtest.applicationtest.domain.NoticeVO;
import org.applicationtest.applicationtest.dto.MemberDTO;
import org.applicationtest.applicationtest.dto.NoticeDTO;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NoticeDAO {
    public void addNotice(NoticeDTO noticeDTO) throws ServletException, IOException {
        String sql = "INSERT INTO notice (title, content) " +
                "VALUES (?, ?)";
        try (Connection conn = ConnectionUtil.INSTANCE.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, noticeDTO.getTitle());
            pstmt.setString(2, noticeDTO.getContent());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("SQL error when add notice", e);
        }
    }

    public List<NoticeDTO> selectAll() throws Exception{
        String sql = "select * from notice";
        @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);
        @Cleanup ResultSet resultSet = pstmt.executeQuery();
        List<NoticeDTO> list = new ArrayList<>();

        while (resultSet.next()) {
            NoticeDTO vo = NoticeDTO.builder()
                    .no(resultSet.getInt("no"))
                    .title(resultSet.getString("title"))
                    .content(resultSet.getString("content"))
                    .count(resultSet.getInt("count"))
                    .createDate(resultSet.getDate("create_date").toLocalDate())
                    .build();
            list.add(vo);
        }
        return list;
    }

    public NoticeDTO selectOne(int no) throws Exception {

        String sql = "select * from notice where no = ?";
        @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, no);
        @Cleanup ResultSet resultSet = pstmt.executeQuery();
        resultSet.next();

        NoticeDTO dto = NoticeDTO.builder()
                .no(resultSet.getInt("no"))
                .title(resultSet.getString("title"))
                .content(resultSet.getString("content"))
                .count(resultSet.getInt("count"))
                .createDate(resultSet.getDate("create_date").toLocalDate())
                .build();

        return dto;
    }

    public void deleteOne(int no) throws Exception {
        String sql = "delete from notice where no = ?";
        @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setLong(1, no);
        pstmt.executeUpdate();
    }


}




