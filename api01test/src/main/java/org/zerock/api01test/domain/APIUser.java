package org.zerock.api01test.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Setter
public class APIUser {
    @Id
    private String mid;
    private String mpw;
    private String name;
    private String email;

    public void changePw(String mpw){
        this.mpw = mpw;
    }
}