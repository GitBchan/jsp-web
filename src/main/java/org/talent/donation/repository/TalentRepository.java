package org.talent.donation.repository;

import lombok.Cleanup;
import org.talent.donation.database.DatabaseConnection;
import org.talent.donation.dto.TalentTimeSlotDTO;
import org.talent.donation.entity.Talent;
import org.talent.donation.entity.TalentTimeSlot;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TalentRepository {
    // 1. 재능 저장
    public void save(Talent talent) throws Exception {
        String sql = "INSERT INTO talents (member_id, title, description, price, category, creation_date, image) VALUES (?, ?, ?, ?, ?, ?, ?)";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, talent.getMemberId());
        pstmt.setString(2, talent.getTitle());
        pstmt.setString(3, talent.getDescription());
        pstmt.setBigDecimal(4, talent.getPrice());
        pstmt.setString(5, talent.getCategory());
        pstmt.setObject(6, LocalDateTime.now());

        // 이미지가 없으면 NULL을 설정
        if (talent.getImage() != null && !talent.getImage().isEmpty()) {
            pstmt.setString(7, talent.getImage());
        } else {
            pstmt.setNull(7, Types.VARCHAR);
        }
        pstmt.executeUpdate();
    }

    // 2. 재능 ID로 조회
    public Talent findById(Long tno) throws Exception {
        String sql = "SELECT * FROM talents WHERE tno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, tno);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return Talent.builder()
                    .tno(rs.getLong("tno"))
                    .memberId(rs.getLong("member_id"))
                    .title(rs.getString("title"))
                    .description(rs.getString("description"))
                    .price(rs.getBigDecimal("price"))
                    .category(rs.getString("category"))
                    .rating(rs.getBigDecimal("rating"))
                    .creationDate(rs.getObject("creation_date", LocalDateTime.class))
                    .image(rs.getString("image"))
                    .build();
        }
        return null;
    }



    // 3. 모든 재능 조회
    public List<Talent> findAll() throws Exception {
        String sql = "SELECT * FROM talents";
        List<Talent> talents = new ArrayList<>();

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Talent talent = Talent.builder()
                    .tno(rs.getLong("tno"))
                    .memberId(rs.getLong("member_id"))
                    .title(rs.getString("title"))
                    .description(rs.getString("description"))
                    .price(rs.getBigDecimal("price"))
                    .category(rs.getString("category"))
                    .rating(rs.getBigDecimal("rating"))
                    .creationDate(rs.getObject("creation_date", LocalDateTime.class))
                    .image(rs.getString("image"))
                    .build();
            talents.add(talent);
        }
        return talents;
    }

    // 4. 재능 정보 업데이트
    public void update(Talent talent) throws Exception {
        String sql = "UPDATE talents SET member_id = ?, title = ?, description = ?, price = ?, category = ?, rating = ?, creation_date = ?, image = ? WHERE tno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, talent.getMemberId());
        pstmt.setString(2, talent.getTitle());
        pstmt.setString(3, talent.getDescription());
        pstmt.setBigDecimal(4, talent.getPrice());
        pstmt.setString(5, talent.getCategory());
        pstmt.setBigDecimal(6, talent.getRating());
        pstmt.setObject(7, talent.getCreationDate());
        pstmt.setString(8, talent.getImage());
        pstmt.setLong(9, talent.getTno());
        pstmt.executeUpdate();
    }

    // 5. 재능 삭제
    public void delete(Long tno) throws Exception {
        String sql = "DELETE FROM talents WHERE tno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, tno);
        pstmt.executeUpdate();
    }

    // 동적 페이징 기능 - 특정 페이지의 재능 목록 조회
    // 검색 및 카테고리 필터가 포함된 동적 페이징 메서드
    public List<Talent> findTalentsWithPaging(int page, int pageSize, String search, String category) throws Exception {
        // 동적 쿼리 생성
        StringBuilder sql = new StringBuilder("SELECT * FROM talents WHERE 1=1");

        // 검색어가 있는 경우 조건 추가
        if (search != null && !search.isEmpty()) {
            sql.append(" AND title LIKE ?");
        }

        // 카테고리가 있는 경우 조건 추가
        if (category != null && !category.isEmpty()) {
            sql.append(" AND category = ?");
        }

        // 정렬 및 페이징 조건 추가
        sql.append(" ORDER BY creation_date DESC LIMIT ? OFFSET ?");

        List<Talent> talents = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql.toString());

        int paramIndex = 1;

        // 검색어가 있는 경우 파라미터 설정
        if (search != null && !search.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + search + "%"); // LIKE 검색용
        }

        // 카테고리가 있는 경우 파라미터 설정
        if (category != null && !category.isEmpty()) {
            pstmt.setString(paramIndex++, category);
        }

        // 페이징 파라미터 설정
        pstmt.setInt(paramIndex++, pageSize);
        pstmt.setInt(paramIndex, offset);

        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Talent talent = Talent.builder()
                    .tno(rs.getLong("tno"))
                    .memberId(rs.getLong("member_id"))
                    .title(rs.getString("title"))
                    .description(rs.getString("description"))
                    .price(rs.getBigDecimal("price"))
                    .category(rs.getString("category"))
                    .rating(rs.getBigDecimal("rating"))
                    .creationDate(rs.getObject("creation_date", LocalDateTime.class))
                    .image(rs.getString("image"))
                    .build();
            talents.add(talent);
        }
        return talents;
    }

    // 검색 및 카테고리에 따른 총 페이지 수 계산
    public int getTotalPages(int pageSize, String search, String category) throws Exception {
        // 동적 쿼리 생성
        StringBuilder countSql = new StringBuilder("SELECT COUNT(*) FROM talents WHERE 1=1");

        // 검색어가 있는 경우 조건 추가
        if (search != null && !search.isEmpty()) {
            countSql.append(" AND title LIKE ?");
        }

        // 카테고리가 있는 경우 조건 추가
        if (category != null && !category.isEmpty()) {
            countSql.append(" AND category = ?");
        }

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(countSql.toString());

        int paramIndex = 1;

        // 검색어 파라미터 설정
        if (search != null && !search.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + search + "%");
        }

        // 카테고리 파라미터 설정
        if (category != null && !category.isEmpty()) {
            pstmt.setString(paramIndex++, category);
        }

        @Cleanup ResultSet rs = pstmt.executeQuery();
        int totalRecords = 0;

        if (rs.next()) {
            totalRecords = rs.getInt(1);
        }

        return (int) Math.ceil((double) totalRecords / pageSize);
    }

    // talentId로 title을 가져오는 메서드
    public String findTitleByTno(Long talentId) throws Exception {
        String sql = "SELECT title FROM talents WHERE tno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, talentId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return rs.getString("title");
        }
        return null;
    }

    // memberId로 Talent 리스트 조회
    public List<Talent> findByMemberId(Long memberId) throws Exception {
        List<Talent> talents = new ArrayList<>();
        String sql = "SELECT tno, member_id, title, description, price, category, rating, creation_date, image FROM talent WHERE member_id = ?";

        try (Connection conn = DatabaseConnection.INSTANCE.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, memberId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Talent talent = new Talent();
                    talent.setTno(rs.getLong("tno"));
                    talent.setMemberId(rs.getLong("member_id"));
                    talent.setTitle(rs.getString("title"));
                    talent.setDescription(rs.getString("description"));
                    talent.setPrice(rs.getBigDecimal("price"));
                    talent.setCategory(rs.getString("category"));
                    talent.setRating(rs.getBigDecimal("rating"));
                    talent.setCreationDate(rs.getTimestamp("creation_date").toLocalDateTime());
                    talent.setImage(rs.getString("image"));
                    talents.add(talent);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Failed to retrieve talents by memberId", e);
        }

        return talents;
    }

    // memberId가 같은 Talent 리스트 조회 메서드
    public List<Talent> findAllByMemberId(Long memberId) throws Exception {
        List<Talent> talents = new ArrayList<>();
        String sql = "SELECT tno, member_id, title, description, price, category, rating, creation_date, image " +
                "FROM talents WHERE member_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, memberId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Talent talent = Talent.builder()
                    .tno(rs.getLong("tno"))
                    .memberId(rs.getLong("member_id"))
                    .title(rs.getString("title"))
                    .description(rs.getString("description"))
                    .price(rs.getBigDecimal("price"))
                    .category(rs.getString("category"))
                    .rating(rs.getBigDecimal("rating"))
                    .creationDate(rs.getObject("creation_date", LocalDateTime.class))
                    .image(rs.getString("image"))
                    .build();
            talents.add(talent);
        }

        return talents;
    }


    public List<TalentTimeSlotDTO> findPendingTimeSlotsWithTransactions(Long memberId) throws Exception {
        List<TalentTimeSlotDTO> results = new ArrayList<>();
        String sql = "SELECT tts.sno, tts.talent_id, tts.time_slot, tts.status, tts.scheduled_date, " +
                "tts.created_at, tts.updated_at, " +
                "tr.transaction_id, tr.buyer_id, tr.amount, tr.transaction_date, tr.scheduled_date AS tr_scheduled_date, " +
                "tr.time_slot AS tr_time_slot, tr.remarks " +
                "FROM talent_time_slot tts " +
                "LEFT JOIN transactions tr ON tts.talent_id = tr.talent_id " +
                "WHERE tts.status = 'PENDING' " +
                "AND tr.talent_owner_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setLong(1, memberId);

        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            long talentId = rs.getLong("talent_id");
            String title = findTitleByTno(talentId);

            TalentTimeSlotDTO dto = TalentTimeSlotDTO.builder()
                    // Mapping TalentTimeSlot fields
                    .sno(rs.getLong("sno"))
                    .talentId(talentId)
                    .timeSlot(rs.getInt("time_slot"))
                    .status(rs.getString("status"))
                    .scheduledDate(rs.getTimestamp("scheduled_date").toLocalDateTime())
                    .createdAt(rs.getTimestamp("created_at").toLocalDateTime())
                    .updatedAt(rs.getTimestamp("updated_at").toLocalDateTime())
                    .title(title)

                    // Mapping Transaction fields
                    .transactionId(rs.getLong("transaction_id"))
                    .buyerId(rs.getLong("buyer_id"))
                    .amount(rs.getBigDecimal("amount"))
                    .transactionDate(rs.getTimestamp("transaction_date") != null ? rs.getTimestamp("transaction_date").toLocalDateTime() : null)
                    .transactionScheduledDate(rs.getTimestamp("tr_scheduled_date") != null ? rs.getTimestamp("tr_scheduled_date").toLocalDateTime() : null)
                    .transactionTimeSlot(rs.getString("tr_time_slot"))
                    .remarks(rs.getString("remarks"))
                    .build();

            results.add(dto);
        }

        return results;
    }

    public String findStatus(Long memberId, Long tno) throws Exception {
        String sql = "SELECT tts.sno, tts.talent_id, tts.time_slot, tts.status, tts.scheduled_date, " +
                "tts.created_at, tts.updated_at, " +
                "tr.transaction_id, tr.buyer_id, tr.amount, tr.transaction_date, tr.scheduled_date AS tr_scheduled_date, " +
                "tr.time_slot AS tr_time_slot, tr.remarks " +
                "FROM talent_time_slot tts " +
                "LEFT JOIN transactions tr ON tts.talent_id = tr.talent_id " +
                "WHERE tr.buyer_id = ? " +
                "AND tts.talent_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, memberId);
        pstmt.setLong(2, tno);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            return rs.getString("status");
        }

        return null;
    }

    public List<TalentTimeSlot> findByTalentId(Long talentId, LocalDateTime selectedDate) throws Exception {
        String sql = "SELECT * FROM talent_time_slot WHERE talent_id = ? AND scheduled_date = ? AND status <> 'AVAILABLE'";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, talentId);
        pstmt.setTimestamp(2, Timestamp.valueOf(selectedDate));
        @Cleanup ResultSet rs = pstmt.executeQuery();

        List<TalentTimeSlot> results = new ArrayList<>();

        while (rs.next()) {
            TalentTimeSlot current = TalentTimeSlot.builder()
                    .sno(rs.getLong("sno"))
                    .talentId(rs.getLong("talent_id"))
                    .timeSlot(rs.getInt("time_slot"))
                    .status(rs.getString("status"))
                    .scheduledDate(rs.getTimestamp("scheduled_date").toLocalDateTime())
                    .createdAt(rs.getTimestamp("created_at").toLocalDateTime())
                    .updatedAt(rs.getTimestamp("updated_at").toLocalDateTime())
                    .build();

            results.add(current);
        }

        return results;
    }

    public void saveTimeSlot(TalentTimeSlot timeSlot) throws Exception {
        String sql = "INSERT INTO talent_time_slot (talent_id, time_slot, status, scheduled_date) VALUES (?, ?, 'PENDING', ?)";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, timeSlot.getTalentId());
        pstmt.setInt(2, timeSlot.getTimeSlot());
        pstmt.setTimestamp(3, Timestamp.valueOf(timeSlot.getScheduledDate()));

        pstmt.executeUpdate();
    }

    public void updateStatusToConfirmed(long sno) throws Exception {
        String sql = "UPDATE talent_time_slot SET status = 'CONFIRMED' WHERE sno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, sno);
        pstmt.executeUpdate();
    }

    public void updateStatusToAvailable(long sno) throws Exception {
        String sql = "UPDATE talent_time_slot SET status = 'AVAILABLE' WHERE sno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, sno);
        pstmt.executeUpdate();
    }

    public List<Talent> findTop3ByRating() throws Exception {
        List<Talent> talents = new ArrayList<>();
        String query = """
                SELECT tno, member_id, title, description, price, category, rating, creation_date, image 
                FROM talents 
                ORDER BY rating DESC 
                LIMIT 3
                """;

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(query);

        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Talent talent = Talent.builder()
                    .tno(rs.getLong("tno"))
                    .memberId(rs.getLong("member_id"))
                    .title(rs.getString("title"))
                    .description(rs.getString("description"))
                    .price(rs.getBigDecimal("price"))
                    .category(rs.getString("category"))
                    .rating(rs.getBigDecimal("rating"))
                    .creationDate(rs.getTimestamp("creation_date").toLocalDateTime())
                    .image(rs.getString("image"))
                    .build();

            talents.add(talent);
        }
        return talents;
    }


}
