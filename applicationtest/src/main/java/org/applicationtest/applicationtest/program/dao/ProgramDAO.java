package org.applicationtest.applicationtest.program.dao;

import lombok.Cleanup;
import org.applicationtest.applicationtest.member.dto.MemberDTO;
import org.applicationtest.applicationtest.program.dto.ProgramDTO;
import org.applicationtest.applicationtest.util.ConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProgramDAO {
  public List<ProgramDTO> selectProgramList() throws Exception{
    String sql = "SELECT * FROM program";
    @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
    @Cleanup PreparedStatement preparedStatement = conn.prepareStatement(sql);
    @Cleanup ResultSet resultSet = preparedStatement.executeQuery();
    List<ProgramDTO> list = new ArrayList<ProgramDTO>();
    while(resultSet.next()){
      ProgramDTO programDTO = ProgramDTO.builder()
          .no(resultSet.getInt("no"))
          .title(resultSet.getString("title"))
          .text(resultSet.getString("text"))
          .subtext(resultSet.getString("subtext"))
          .schedule(resultSet.getString("schedule"))
          .img(resultSet.getString("img"))
          .create_date(resultSet.getDate("create_date").toLocalDate())
          .build();
      list.add(programDTO);
    }
    return list;
  }
}
