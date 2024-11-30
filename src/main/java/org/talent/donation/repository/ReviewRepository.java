package org.talent.donation.repository;

import lombok.Cleanup;
import org.talent.donation.database.DatabaseConnection;
import org.talent.donation.dto.ReviewDTO;
import org.talent.donation.entity.Review;
import org.talent.donation.entity.Transaction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ReviewRepository {

    // 1. 리뷰 저장
    public void save(Review review) throws Exception {
        String sql = "INSERT INTO reviews (transaction_id, talent_id, member_id, rating) VALUES (?, ?, ?, ?)";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, review.getTransactionId());
        pstmt.setLong(2, review.getTalentId());
        pstmt.setLong(3, review.getMemberId());
        pstmt.setBigDecimal(4, review.getRating());
        pstmt.executeUpdate();
    }

    // 2. 리뷰 ID로 조회
    public Review findById(Long reviewId) throws Exception {
        String sql = "SELECT * FROM reviews WHERE review_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, reviewId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return Review.builder()
                    .reviewId(rs.getLong("review_id"))
                    .transactionId(rs.getLong("transaction_id"))
                    .talentId(rs.getLong("talent_id"))
                    .memberId(rs.getLong("member_id"))
                    .rating(rs.getBigDecimal("rating"))
                    .build();
        }
        return null;
    }

    public Optional<Review> findByMemberId(Long transactionId) throws Exception {
        String sql = "SELECT * FROM reviews WHERE transaction_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, transactionId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return Optional.ofNullable(Review.builder()
                    .reviewId(rs.getLong("review_id"))
                    .transactionId(rs.getLong("transaction_id"))
                    .talentId(rs.getLong("talent_id"))
                    .memberId(rs.getLong("member_id"))
                    .rating(rs.getBigDecimal("rating"))
                    .build());
        }
        return Optional.empty();
    }

    public List<ReviewDTO> getAllReviews(Long memberId) throws Exception {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = """
                SELECT r.review_id, r.transaction_id, r.talent_id, r.member_id, r.rating,
                                    r.created_at, r.updated_at, t.title
                             FROM reviews r
                                     JOIN talents t ON r.talent_id = t.tno
                             WHERE r.member_id = ?
                    """;

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, memberId);

        @Cleanup ResultSet rs = pstmt.executeQuery();


        while (rs.next()) {
            ReviewDTO review = ReviewDTO.builder()
                    .reviewId(rs.getLong("review_id"))
                    .transactionId(rs.getLong("transaction_id"))
                    .talentId(rs.getLong("talent_id"))
                    .memberId(rs.getLong("member_id"))
                    .rating(rs.getBigDecimal("rating"))
                    .createdAt(rs.getTimestamp("created_at"))
                    .updatedAt(rs.getTimestamp("updated_at"))
                    .title(rs.getString("title"))
                    .build();

            reviews.add(review);
        }

        return reviews;
    }

    // 4. 리뷰 업데이트
    public void update(Review review) throws Exception {
        String sql = "UPDATE reviews SET rating = ? WHERE review_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setBigDecimal(1, review.getRating());
        pstmt.setLong(2, review.getReviewId());
        pstmt.executeUpdate();
    }

    // 5. 리뷰 삭제
    public void delete(Long reviewId) throws Exception {
        String sql = "DELETE FROM reviews WHERE review_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, reviewId);
        pstmt.executeUpdate();
    }
}
