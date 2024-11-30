package org.talent.donation.entity;

import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
public class Inquiry {
    private Long inquiryId;
    private Long writerId;
    private Long talentId;
    private Long talentOwnerId;
    private String content;
    private String responseContent;
    private String status; // "pending", "answered", or "closed"
    private Timestamp createdAt;

}
