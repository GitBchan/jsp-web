package org.talent.donation.entity;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class TalentTimeSlot {
    private Long sno;
    private Long talentId;           // Talent의 FK
    private int timeSlot;            // 예약 시간대 (1: 09-11, 2: 11-13, ..., 5: 17-19)
    private String status;           // 예약 상태 (AVAILABLE, BLOCKED, PENDING, CONFIRMED)
    private LocalDateTime scheduledDate; // 예약 가능한 날짜
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
