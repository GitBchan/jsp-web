package org.talent.donation.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AccountInfo {
    private Long accountId;
    private Long memberId;
    private String bankName;
    private String accountNumber;
    private String accountHolder;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
