package org.talent.donation.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Data
@Builder
public class ReviewDTO {
    private Long reviewId;
    private Long transactionId;  // Transaction에 대한 FK로 구매 내역이 있을 때만 리뷰 작성 가능
    private Long talentId;       // Talent에 대한 FK
    private Long memberId;       // Member에 대한 FK (리뷰 작성자)
    private BigDecimal rating;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private String title;
}
