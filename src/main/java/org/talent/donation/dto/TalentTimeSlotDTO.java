package org.talent.donation.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TalentTimeSlotDTO {

    // TalentTimeSlot fields
    private Long sno;
    private Long talentId;
    private int timeSlot;
    private String status;
    private LocalDateTime scheduledDate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Transaction fields
    private Long transactionId;
    private Long buyerId;
    private BigDecimal amount;
    private LocalDateTime transactionDate;
    private LocalDateTime transactionScheduledDate;
    private String transactionTimeSlot;
    private String remarks;

    private String title;
}
