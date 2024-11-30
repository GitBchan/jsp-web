package org.talent.donation.repository;

import lombok.Cleanup;
import org.talent.donation.database.DatabaseConnection;
import org.talent.donation.entity.Inquiry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class InquiryRepository {

    // 1. 문의 저장
    public void save(Inquiry inquiry) throws Exception {
        String sql = "INSERT INTO inquiries (writer_id, talent_id, talent_owner_id, content, status) VALUES (?, ?, ?, ?, 'pending')";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, inquiry.getWriterId());
        pstmt.setLong(2, inquiry.getTalentId());
        pstmt.setLong(3, inquiry.getTalentOwnerId());
        pstmt.setString(4, inquiry.getContent());
        pstmt.executeUpdate();
    }


    // talent_owner_id가 답변을 작성하고 상태를 업데이트하는 메서드
    public void answerInquiry(Long inquiryId, String responseContent) throws Exception {
        String sql = "UPDATE inquiries SET response_content = ?, status = 'answered' WHERE inquiry_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, responseContent);
        pstmt.setLong(2, inquiryId);
        pstmt.executeUpdate();
    }

    // Pending 상태의 특정 talentOwnerId의 모든 문의 조회
    public List<Inquiry> findPendingInquiriesByOwner(Long memberId) throws Exception {
        String sql = "SELECT * FROM inquiries WHERE talent_owner_id = ? AND status = 'pending'";
        List<Inquiry> inquiries = new ArrayList<>();

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, memberId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Inquiry inquiry = Inquiry.builder()
                    .inquiryId(rs.getLong("inquiry_id"))
                    .writerId(rs.getLong("writer_id"))
                    .talentId(rs.getLong("talent_id"))
                    .talentOwnerId(rs.getLong("talent_owner_id"))
                    .content(rs.getString("content"))
                    .responseContent(rs.getString("response_content"))
                    .status(rs.getString("status"))
                    .createdAt(rs.getTimestamp("created_at"))
                    .build();
            inquiries.add(inquiry);
        }

        return inquiries;
    }

    public List<Inquiry> findAnsweredInquiriesByWriter(Long writerId) throws Exception {
        String sql = "SELECT * FROM inquiries WHERE writer_id = ? AND status = 'answered'";
        List<Inquiry> inquiries = new ArrayList<>();

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, writerId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Inquiry inquiry = Inquiry.builder()
                    .inquiryId(rs.getLong("inquiry_id"))
                    .writerId(rs.getLong("writer_id"))
                    .talentId(rs.getLong("talent_id"))
                    .talentOwnerId(rs.getLong("talent_owner_id"))
                    .content(rs.getString("content"))
                    .responseContent(rs.getString("response_content"))
                    .status(rs.getString("status"))
                    .createdAt(rs.getTimestamp("created_at"))
                    .build();
            inquiries.add(inquiry);
        }

        return inquiries;
    }

    // 5. 문의 삭제
    public void delete(Long inquiryId) throws Exception {
        String sql = "DELETE FROM inquiries WHERE inquiry_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, inquiryId);
        pstmt.executeUpdate();
    }
}
