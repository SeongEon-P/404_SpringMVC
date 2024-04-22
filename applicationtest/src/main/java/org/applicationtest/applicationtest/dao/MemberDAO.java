package org.applicationtest.applicationtest.dao;

import lombok.Cleanup;

import org.applicationtest.applicationtest.domain.MemberVO;
import org.applicationtest.applicationtest.dto.MemberDTO;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {

    public void insertMember(MemberDTO memberDTO) throws ServletException, IOException {
        String sql = "INSERT INTO member (member_id, member_pw, name, phone, Email1, Email2, gender, agree) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConnectionUtil.INSTANCE.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, memberDTO.getMemberId());
            pstmt.setString(2, memberDTO.getMemberPw());
            pstmt.setString(3, memberDTO.getName());
            pstmt.setString(4, memberDTO.getPhone());
            pstmt.setString(5, memberDTO.getEmail1());
            pstmt.setString(6, memberDTO.getEmail2());
            pstmt.setString(7, memberDTO.getGender());
            pstmt.setBoolean(8, memberDTO.getAgree());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("SQL error when inserting member", e);
        }
    }


    // 사용자 인증을 위한 메소드
    public MemberVO getWithPassword(String memberId, String memberPw) throws Exception {
        String query = "SELECT member_id, member_pw, name, phone, Email1, Email2, gender, agree, create_date " +
                "FROM member WHERE member_id=? AND member_pw=?";

        MemberVO memberVO = null;

        @Cleanup Connection conn = ConnectionUtil.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, memberId);
        pstmt.setString(2, memberPw);

        @Cleanup ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            memberVO = MemberVO.builder()
                    .memberId(rs.getString("member_id"))
                    .memberPw(rs.getString("member_pw"))
                    .name(rs.getString("name"))
                    .phone(rs.getString("phone"))
                    .email1(rs.getString("Email1"))
                    .email2(rs.getString("Email2"))
                    .gender(rs.getString("gender"))
                    .agree(rs.getBoolean("agree"))
                    .createDate(rs.getDate("create_date"))
                    .build();
        }
        return memberVO;


    }



}