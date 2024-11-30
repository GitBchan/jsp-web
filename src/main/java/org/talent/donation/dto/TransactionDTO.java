package org.talent.donation.dto;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
public class TransactionDTO {
    private Long transactionId;
    private Long buyerId;
    private Long talentId;
    private String talentTitle;    // 재능의 제목
    private BigDecimal amount;
    private String status;
    private LocalDateTime transactionDate;
    private LocalDateTime scheduledDate;
    private String timeSlot;
    private String remarks;

    private Long reviewId;
}
