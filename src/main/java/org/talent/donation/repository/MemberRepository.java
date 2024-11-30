package org.talent.donation.repository;

import lombok.Cleanup;
import org.talent.donation.database.DatabaseConnection;
import org.talent.donation.entity.Member;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MemberRepository {
    // 1. 회원 저장
    public void save(Member member) throws Exception {
        String sql = "INSERT INTO members (id, name, password, fileName) VALUES (?, ?, ?, ?)";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, member.getId());
        pstmt.setString(2, member.getName());
        pstmt.setString(3, member.getPassword());
        pstmt.setString(4, member.getFileName());
        pstmt.executeUpdate();
    }

    public Member findByMno(Long mno) throws Exception{
        String sql = "SELECT * FROM members WHERE mno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, mno);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        if (rs.next()) { // 데이터가 있는지 확인
            return Member.builder()
                    .mno(rs.getLong("mno"))
                    .id(rs.getString("id"))
                    .name(rs.getString("name"))
                    .password(rs.getString("password"))
                    .fileName(rs.getString("fileName"))
                    .build();
        }

        return null;
    }


    // 2. 회원 ID와 비밀번호로 조회
    public Member findByIdAndPassword(String id, String password) throws Exception {
        String sql = "SELECT * FROM members WHERE id = ? AND password = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, id);
        pstmt.setString(2, password);
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return Member.builder()
                        .mno(rs.getLong("mno"))
                        .id(rs.getString("id"))
                        .name(rs.getString("name"))
                        .password(rs.getString("password"))
                        .fileName(rs.getString("fileName"))
                        .build();
            }
        }

        return null; // 회원이 없을 경우 null 반환
    }

    // 3. 모든 회원 조회
    public List<Member> findAll() throws Exception {
        String sql = "SELECT * FROM members";
        List<Member> members = new ArrayList<>();

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Member member = Member.builder()
                    .mno(rs.getLong("mno"))
                    .id(rs.getString("id"))
                    .name(rs.getString("name"))
                    .password(rs.getString("password"))
                    .fileName(rs.getString("fileName"))
                    .build();
            members.add(member);
        }
        return members;
    }

    // 4. 회원 정보 업데이트
    public void update(Member member) throws Exception {
        String sql = "UPDATE members SET name = ?, password = ?, fileName = ? WHERE mno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, member.getName());
        pstmt.setString(2, member.getPassword());
        pstmt.setString(3, member.getFileName());
        pstmt.setLong(4, member.getMno());
        pstmt.executeUpdate();
    }

    // 5. 회원 삭제
    public void delete(Long mno) throws Exception {
        String sql = "DELETE FROM members WHERE mno = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, mno);
        pstmt.executeUpdate();
    }

    public void saveLoginToken(Long userId, String token) throws Exception {
        String sql = "INSERT INTO login_tokens (user_id, token, expiration_date) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 30 DAY))";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, userId);
        pstmt.setString(2, token);
        pstmt.executeUpdate();
    }

    // 토큰으로 회원 조회
    public Member findByToken(String token) throws Exception {
        String sql = "SELECT m.* FROM members m " +
                "JOIN login_tokens lt ON m.mno = lt.user_id " +
                "WHERE lt.token = ? AND lt.expiration_date > NOW()";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, token);

        @Cleanup ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return Member.builder()
                    .mno(rs.getLong("mno"))
                    .id(rs.getString("id"))
                    .name(rs.getString("name"))
                    .password(rs.getString("password"))
                    .fileName(rs.getString("fileName"))
                    .build();
        }
        return null; // 유효하지 않은 토큰이거나 만료된 경우 null 반환
    }

    // 특정 토큰 삭제
    public void deleteLoginToken(String token) throws Exception {
        String sql = "DELETE FROM login_tokens WHERE token = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, token);
        pstmt.executeUpdate();
    }

    // 모든 토큰 삭제 (특정 사용자 ID로)
    public void deleteLoginTokensByUserId(Long userId) throws Exception {
        String sql = "DELETE FROM login_tokens WHERE user_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, userId);
        pstmt.executeUpdate();
    }
}
