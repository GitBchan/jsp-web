package org.talent.donation.repository;

import lombok.Cleanup;
import org.talent.donation.database.DatabaseConnection;
import org.talent.donation.dto.TalentTimeSlotDTO;
import org.talent.donation.dto.TransactionDTO;
import org.talent.donation.entity.Review;
import org.talent.donation.entity.Transaction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class TransactionRepository {

    private final TalentRepository talentRepository = new TalentRepository();

    private final ReviewRepository reviewRepository = new ReviewRepository();

    // 1. 거래 저장
    public void save(Transaction transaction) throws Exception {
        String sql = "INSERT INTO transactions (buyer_id, talent_id, amount, transaction_date, scheduled_date, time_slot, talent_owner_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, transaction.getBuyerId());
        pstmt.setLong(2, transaction.getTalentId());
        pstmt.setBigDecimal(3, transaction.getAmount());
        pstmt.setObject(4, LocalDateTime.now());
        pstmt.setObject(5, transaction.getScheduledDate());
        pstmt.setString(6, transaction.getTimeSlot());
        pstmt.setLong(7, transaction.getTalentOwnerId());
        pstmt.executeUpdate();
    }

    // 2. 거래 ID로 조회
    public Transaction findById(Long transactionId) throws Exception {
        String sql = "SELECT * FROM transactions WHERE transaction_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, transactionId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return Transaction.builder()
                    .transactionId(rs.getLong("transaction_id"))
                    .buyerId(rs.getLong("buyer_id"))
                    .talentId(rs.getLong("talent_id"))
                    .amount(rs.getBigDecimal("amount"))
                    .transactionDate(rs.getObject("transaction_date", LocalDateTime.class))
                    .scheduledDate(rs.getObject("scheduled_date", LocalDateTime.class))
                    .timeSlot(rs.getString("time_slot"))
                    .remarks(rs.getString("remarks"))
                    .build();
        }
        return null;
    }

    // 3. 특정 사용자 ID(buyer_id)로 모든 거래 조회
    public List<TransactionDTO> findAllByBuyerId(Long buyerId) throws Exception {
        String sql = "SELECT * FROM transactions WHERE buyer_id = ?";
        List<TransactionDTO> transactionDTOs = new ArrayList<>();

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, buyerId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {

            Long talentId = rs.getLong("talent_id");
            String talentTitle = talentRepository.findTitleByTno(talentId);
            long transactionId = rs.getLong("transaction_id");
            String status = talentRepository.findStatus(buyerId, talentId);
            Optional<Review> byMemberId = reviewRepository.findByMemberId(transactionId);

            TransactionDTO transactionDTO = TransactionDTO.builder()
                    .transactionId(transactionId)
                    .buyerId(rs.getLong("buyer_id"))
                    .talentId(rs.getLong("talent_id"))
                    .talentTitle(talentTitle)  // 재능 제목 설정
                    .status(status)
                    .amount(rs.getBigDecimal("amount"))
                    .transactionDate(rs.getObject("transaction_date", LocalDateTime.class))
                    .scheduledDate(rs.getObject("scheduled_date", LocalDateTime.class))
                    .timeSlot(rs.getString("time_slot"))
                    .remarks(rs.getString("remarks"))
                    .build();

            if (byMemberId.isPresent()) {
                Review review = byMemberId.get();
                transactionDTO.setReviewId(review.getReviewId());
            }

            transactionDTOs.add(transactionDTO);
        }
        return transactionDTOs;
    }

    // 4. 거래 정보 업데이트
    public void update(Transaction transaction) throws Exception {
        String sql = "UPDATE transactions SET buyer_id = ?, talent_id = ?, amount = ?, status = ?, transaction_date = ?, scheduled_date = ?, time_slot = ?, remarks = ? WHERE transaction_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, transaction.getBuyerId());
        pstmt.setLong(2, transaction.getTalentId());
        pstmt.setBigDecimal(3, transaction.getAmount());
        pstmt.setObject(5, transaction.getTransactionDate());
        pstmt.setObject(6, transaction.getScheduledDate());
        pstmt.setString(7, transaction.getTimeSlot());
        pstmt.setString(8, transaction.getRemarks());
        pstmt.setLong(9, transaction.getTransactionId());
        pstmt.executeUpdate();
    }

    // 5. 거래 삭제
    public void delete(Long transactionId) throws Exception {
        String sql = "DELETE FROM transactions WHERE transaction_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, transactionId);
        pstmt.executeUpdate();
    }
}
