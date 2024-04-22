package org.applicationtest.applicationtest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {

    private String memberId;
    private String memberPw;
    private String name;
    private String phone;
    private String email1;
    private String email2;
    private String gender;
    private Boolean agree;
    private Date createDate;
}
