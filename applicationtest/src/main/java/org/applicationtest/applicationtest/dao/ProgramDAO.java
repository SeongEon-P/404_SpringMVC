package org.applicationtest.applicationtest.dao;

import lombok.Cleanup;
import org.applicationtest.applicationtest.dto.NoticeDTO;
import org.applicationtest.applicationtest.dto.ProgramDTO;

import java.sql.*;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProgramDAO {
    public List<ProgramDTO> selectAll() throws Exception{
    String sql = "select * from program";
    @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
    @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);
    @Cleanup ResultSet resultSet = pstmt.executeQuery();
    List<ProgramDTO> list = new ArrayList<>();

    while (resultSet.next()) {
        ProgramDTO vo = ProgramDTO.builder()
                .no(resultSet.getInt("no"))
                .title(resultSet.getString("title"))
                .text(resultSet.getString("text"))
                .subtext(resultSet.getString("subtext"))
                .schedule(resultSet.getString("schedule"))
                .img(resultSet.getString("img"))

                .build();
        list.add(vo);
    }
    return list;
}
}
