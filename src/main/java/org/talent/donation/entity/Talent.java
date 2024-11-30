package org.talent.donation.entity;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Talent {
    private Long tno;
    private Long memberId; // Member를 직접 참조하는 대신 ID만 저장
    private String title;
    private String description;
    private BigDecimal price;
    private String category; // Category 열거형 대신 String으로 저장
    private BigDecimal rating;
    private LocalDateTime creationDate;
    private String image;

    public String getFormatCreateDate() {
        return creationDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

}
