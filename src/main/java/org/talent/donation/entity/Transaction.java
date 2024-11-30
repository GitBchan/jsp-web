package org.talent.donation.entity;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Transaction {
    private Long transactionId;
    private Long buyerId;           // 구매자 ID (Member에 대한 FK)
    private Long talentId;          // Talent에 대한 FK
    private Long talentOwnerId;
    private BigDecimal amount;      // 거래 금액
    private LocalDateTime transactionDate; // 거래 날짜

    // 재능 제공 일정 정보
    private LocalDateTime scheduledDate;   // 예약된 날짜와 시간
    private String timeSlot;               // 예약된 시간대 (예: "10:00-12:00")
    // 추가 필드 설명
    private String remarks;                // 예약 관련 요청사항 등 추가 설명
}
