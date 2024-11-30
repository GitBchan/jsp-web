package org.talent.donation.repository;

import lombok.Cleanup;
import org.talent.donation.database.DatabaseConnection;
import org.talent.donation.entity.AccountInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AccountInfoRepository {
    // 정산 정보 저장
    public void save(AccountInfo accountInfo) throws Exception {
        String sql = "INSERT INTO account_info (member_id, bank_name, account_number, account_holder) " +
                "VALUES (?, ?, ?, ?)";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, accountInfo.getMemberId());
        pstmt.setString(2, accountInfo.getBankName());
        pstmt.setString(3, accountInfo.getAccountNumber());
        pstmt.setString(4, accountInfo.getAccountHolder());

        pstmt.executeUpdate();
    }

    // 기존 레코드를 업데이트하는 메서드
    public void update(AccountInfo accountInfo) throws Exception {
        String sql = "UPDATE account_info SET bank_name = ?, account_number = ?, account_holder = ? WHERE account_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, accountInfo.getBankName());
        pstmt.setString(2, accountInfo.getAccountNumber());
        pstmt.setString(3, accountInfo.getAccountHolder());
        pstmt.setLong(4, accountInfo.getAccountId());

        pstmt.executeUpdate();
    }

    // 정산 정보 조회
    public AccountInfo findByMemberId(Long memberId) throws Exception {
        String sql = "SELECT * FROM account_info WHERE member_id = ?";

        @Cleanup Connection conn = DatabaseConnection.INSTANCE.getConnection();
        @Cleanup PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setLong(1, memberId);
        @Cleanup ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return AccountInfo.builder()
                    .accountId(rs.getLong("account_id"))
                    .memberId(rs.getLong("member_id"))
                    .bankName(rs.getString("bank_name"))
                    .accountNumber(rs.getString("account_number"))
                    .accountHolder(rs.getString("account_holder"))
                    .createdAt(rs.getTimestamp("created_at").toLocalDateTime())
                    .updatedAt(rs.getTimestamp("updated_at").toLocalDateTime())
                    .build();
        }
        return null;
    }
}
