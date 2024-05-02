package org.applicationtest.applicationtest.member.dao;

import lombok.Cleanup;
import org.applicationtest.applicationtest.member.dto.MemberDTO;
import org.applicationtest.applicationtest.util.ConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

public class MemberDAO {
  public MemberDTO login(String id, String pw) throws Exception{
    String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw = ?";
    @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
    @Cleanup PreparedStatement preparedStatement = conn.prepareStatement(sql);
    preparedStatement.setString(1, id);
    preparedStatement.setString(2, pw);
    @Cleanup ResultSet resultSet = preparedStatement.executeQuery();
    resultSet.next();
    MemberDTO memberDTO = MemberDTO.builder()
        .member_id(resultSet.getString("member_id"))
        .member_pw(resultSet.getString("member_pw"))
        .name(resultSet.getString("name"))
        .phone(resultSet.getString("phone"))
        .email1(resultSet.getString("email1"))
        .email2(resultSet.getString("email2"))
        .gender(resultSet.getString("gender"))
        .agree(resultSet.getBoolean("agree"))
        .create_date(resultSet.getDate("create_date").toLocalDate())
        .build();
    return memberDTO;
  }

  public void insertMember(MemberDTO memberDTO) throws Exception{
    String sql = "INSERT INTO member(member_id,member_pw,name,phone,email1,email2,gender,agree) VALUES(?,?,?,?,?,?,?,?)";
    @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
    @Cleanup PreparedStatement preparedStatement = conn.prepareStatement(sql);
    preparedStatement.setString(1, memberDTO.getMember_id());
    preparedStatement.setString(2, memberDTO.getMember_pw());
    preparedStatement.setString(3, memberDTO.getName());
    preparedStatement.setString(4, memberDTO.getPhone());
    preparedStatement.setString(5, memberDTO.getEmail1());
    preparedStatement.setString(6, memberDTO.getEmail2());
    preparedStatement.setString(7, memberDTO.getGender());
    preparedStatement.setBoolean(8, memberDTO.isAgree());
    preparedStatement.executeUpdate();
  }
}
