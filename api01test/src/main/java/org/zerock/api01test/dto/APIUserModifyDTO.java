package org.zerock.api01test.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class APIUserModifyDTO {
    private String mid;
    private String mpw;
    private String name;
    private String email;
    private boolean emailConsent;
    private boolean snsConsent;
}
