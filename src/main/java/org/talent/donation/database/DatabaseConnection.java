package org.talent.donation.database;


import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;

public enum DatabaseConnection {

    INSTANCE;

    private HikariDataSource ds;

    DatabaseConnection(){
        HikariConfig config = new HikariConfig();
        config.setDriverClassName("org.mariadb.jdbc.Driver");
        config.setJdbcUrl("jdbc:mariadb://localhost:3306/talent_exchange");
        config.setUsername("talent_user");
        config.setPassword("batch_password");
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("perpStmtCacheSize","250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit","2048");

        ds = new HikariDataSource(config);
    }

    public Connection getConnection() throws Exception{
        return ds.getConnection();
    }
}
